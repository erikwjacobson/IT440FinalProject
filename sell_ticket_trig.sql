/*
	The trigger meets the following constraints:
		'It is not allowed sell more tickets than there are seats available for a showing.'
*/

CREATE TRIGGER checkSeatsAvailable
ON OrderDetail
INSTEAD OF UPDATE
AS
BEGIN
	DECLARE @orderID INT;
	DECLARE @ticketID INT;
	DECLARE @showingID INT;
	DECLARE @totalSeats INT;
	DECLARE @seatsLeft INT;
	DECLARE @seatsBeingPurchased INT;
	DECLARE @ticketsAlreadyPurchased INT;

	SET @orderID = (SELECT OrderID FROM INSERTED);
	SET @ticketID = (SELECT TicketID FROM INSERTED);
	SET @showingID = (SELECT ShowingID FROM Ticket T WHERE T.TicketID = @ticketID);
	SET @totalSeats = (SELECT Available_Seats 
						FROM Auditorium 
						WHERE AuditoriumID = (SELECT AuditoriumID 
												FROM Showing S 
												WHERE S.ShowingID = @showingID));
	SET @seatsBeingPurchased = (SELECT No_of_Tickets FROM INSERTED);
	SET @ticketsAlreadyPurchased = (SELECT COUNT(No_of_Tickets)
									  FROM OrderDetail OD 
										JOIN Ticket T 
									  ON OD.TicketID = T.TicketID
										JOIN Showing S
									  ON T.ShowingID = S.ShowingID
										JOIN Auditorium A
									  ON S.AuditoriumID = A.AuditoriumID
									  WHERE S.ShowingID = @showingID);
	SET @seatsLeft = @totalSeats - (@ticketsAlreadyPurchased + @seatsBeingPurchased);

	IF @seatsLeft < 0
		RAISERROR('You cannot purchase more seats than are available',13,13);
END