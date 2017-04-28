/* 
The following file covers the following constraints:
	'A Customer needs to be older than 13 to order a ticket.'
	'A Customer that is younger than 17 is not allowed to purchase a ticket for an R-rated movie.'
	'It is not allowed sell more tickets than there are seats available for a showing.'
*/

CREATE TRIGGER checkOrder
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
	DECLARE @showingID INT;
	DECLARE @noTickets INT;
	DECLARE @totalSeats INT;
	DECLARE @seatsLeft INT;
	DECLARE @seatsBeingPurchased INT;
	DECLARE @ticketsAlreadyPurchased INT;

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
	SET @showingID = (SELECT ShowingID FROM Ticket T WHERE T.TicketID = @ticketID);
	SET @totalSeats = (SELECT Available_Seats 
						FROM Auditorium 
						WHERE AuditoriumID = (SELECT AuditoriumID 
												FROM Showing S 
												WHERE S.ShowingID = @showingID));
	SET @seatsBeingPurchased = (SELECT No_of_Tickets FROM INSERTED);
	SET @ticketsAlreadyPurchased = (SELECT SUM(No_of_Tickets)
									  FROM OrderDetail OD 
										JOIN Ticket T 
									  ON OD.TicketID = T.TicketID
										JOIN Showing S
									  ON T.ShowingID = S.ShowingID
										JOIN Auditorium A
									  ON S.AuditoriumID = A.AuditoriumID
									  WHERE S.ShowingID = 1);
	SET @seatsLeft = @totalSeats - (@ticketsAlreadyPurchased + @seatsBeingPurchased);
	/* LOGIC FOR ALL CONSTRAINTS */
	BEGIN
		IF @age < 13
			RAISERROR('You have to be at least 13 years old to order a ticket',13,13);
		ELSE IF @movieRatingID > 3 AND @age < 17
			RAISERROR('You have to be at least 17 years old to order a ticket with a rating of R',13,13);
		ELSE IF @seatsLeft < 0
			RAISERROR('You have ordered too many tickets.',13,13);
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

BEGIN TRANSACTION;
	DECLARE @varDate2 DATE;
	SET @varDate2 = GETDATE();
	EXEC orderTicket @numberOfTickets = 3, @customerID = 8, @date = @varDate2, @ticketID = 8;
	/* Customer is only 16 years of age */
COMMIT TRANSACTION;

BEGIN TRANSACTION;
	DECLARE @varDate2 DATE;
	SET @varDate2 = GETDATE();
	EXEC orderTicket @numberOfTickets = 200, @customerID = 8, @date = @varDate2, @ticketID = 8;
	/* Customer ordered too many tickets */
COMMIT TRANSACTION;