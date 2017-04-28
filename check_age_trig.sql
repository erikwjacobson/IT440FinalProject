/* 
The following file covers the following constraints:
	'A Customer needs to be older than 13 to order a ticket.'
	'A Customer that is younger than 17 is not allowed to purchase a ticket for an R-rated movie.'
*/

CREATE TRIGGER checkAge
ON OrderDetail
INSTEAD OF INSERT
AS
BEGIN
	/* Declare Necessary Variables */
	DECLARE @ticketID INT;
	DECLARE @orderID INT;
	DECLARE @customerID INT;
	DECLARE @custBirthdate DATE;
	DECLARE @age INT;
	DECLARE @movieRatingID INT;
	DECLARE @noTickets INT;

	/* Set Variables */
	SET @ticketID = (SELECT TicketID FROM INSERTED);
	SET @orderID = (SELECT OrderID FROM INSERTED);
	SET @noTickets = (SELECT No_of_Tickets FROM INSERTED);
	SET @customerID = (SELECT CustomerID FROM [Order] O WHERE O.OrderID = @orderID);
	SET @custBirthdate = (SELECT DOB FROM Customer C WHERE C.CustomerID = @customerID);
	SET @age = (SELECT DATEDIFF(year, @custBirthdate, GETDATE()));
	SET @movieRatingID = (SELECT RatingID 
						  FROM Movie M
						  WHERE M.MovieID = (SELECT MovieID
							                 FROM Showing S
											 WHERE S.ShowingID = (SELECT ShowingID
																  FROM Ticket T
																  WHERE T.TicketID = @ticketID)));

	/* LOGIC FOR 'A Customer needs to be older than 13 to order a ticket.' */
	BEGIN
		IF @age < 13
			RAISERROR('You have to be at least 13 years old to order a ticket',13,13);
		ELSE IF @movieRatingID > 3 AND @age < 17
			RAISERROR('You have to be at least 17 years old to order a ticket with a rating of R',13,13);
		ELSE
			INSERT INTO OrderDetail VALUES(@orderID,@ticketID,@noTickets);
	END
END;

/* Test Execution */

/* PASS */

BEGIN TRANSACTION;
	DECLARE @varDate2 DATE;
	SET @varDate2 = GETDATE();
	EXEC orderTicket @numberOfTickets = 3, @customerID = 2, @date = @varDate2, @ticketID = 3;
	/* Customer is 21 years of age */
COMMIT TRANSACTION;

/* FAIL */

BEGIN TRANSACTION;
	DECLARE @varDate2 DATE;
	SET @varDate2 = GETDATE();
	EXEC orderTicket @numberOfTickets = 3, @customerID = 7, @date = @varDate2, @ticketID = 3;
	/* Customer is only 12 years of age */
COMMIT TRANSACTION;
SELECT * FROM Movie where MovieID = 1;
BEGIN TRANSACTION;
	DECLARE @varDate2 DATE;
	SET @varDate2 = GETDATE();
	EXEC orderTicket @numberOfTickets = 3, @customerID = 8, @date = @varDate2, @ticketID = 8;
	/* Customer is only 16 years of age */
COMMIT TRANSACTION;