/* 
The following file covers the following constraints:
	'Every Order needs to have at least one OrderDetail record.'
*/

/* Stored Procedure */
CREATE PROCEDURE orderTicket
	@numberOfTickets INT,
	@customerID INT,
	@date DATE,
	@ticketID INT
AS
BEGIN
	DECLARE @count INT
	SET @count = @@TRANCOUNT 
	IF @count > 0
	BEGIN
		SAVE TRANSACTION flag
	END
	ELSE
	BEGIN
		BEGIN TRANSACTION
	END
	BEGIN TRY
		BEGIN

		/* Order Insert */ 
			INSERT INTO [Order] VALUES(@customerID, @date);
		/* OrderDetail Insert */
			INSERT INTO [OrderDetail] VALUES(@@IDENTITY, @ticketID, @numberOfTickets);

		   IF @count = 0
		      COMMIT TRANSACTION;
		END
	END TRY
	BEGIN CATCH
		IF @count > 0		
			BEGIN
				RAISERROR('Rollback to save proc',16,1)
				ROLLBACK TRANSACTION flag
			END
		ELSE
			BEGIN
				RAISERROR('Rollback entire transaction',16,1)
				ROLLBACK TRANSACTION
			END
	END CATCH
END;

/* Test Execution */
 BEGIN TRANSACTION;
 	/* Fail */
 COMMIT TRANSACTION;
/***********************/
 BEGIN TRANSACTION;
 	/* Pass */
 COMMIT TRANSACTION;