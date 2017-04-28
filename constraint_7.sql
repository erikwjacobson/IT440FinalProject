/* 
	The following constraints are being satisfied with this trigger:
		'Only one movie can be displayed at a time in an auditorium.'
		'If a customer has ordered a ticket it is not allowed to change any information for that showing.'
		'A movie needs to be released before it can be shown to the customers.'
*/

USE Cinema
GO

CREATE TRIGGER assertValidShowing on Showing
INSTEAD OF INSERT, UPDATE
AS 
	BEGIN
		DECLARE @showingID INT; 
		SET @showingID = (SELECT ShowingID from INSERTED);
		BEGIN
			IF @showingID IN (SELECT S.ShowingID 
							FROM Showing S 
							JOIN Ticket T
							ON S.ShowingID = T.ShowingID
							JOIN OrderDetail OD
							ON T.TicketID = OD.TicketID)
				RAISERROR('You cannot update a showing that has tickets already bought',13,13);
		END
		
		DECLARE @releaseDate DATE;

		SELECT @releaseDate = ReleaseDate FROM Movie WHERE MovieID IN (SELECT MovieID FROM inserted);
		
		IF @releaseDate < (SELECT Date FROM inserted)
		BEGIN
			DECLARE @movieCount INT
			DECLARE @datetime DATETIME

			SELECT @datetime = CAST(DATE AS DATETIME) + CAST(TIME AS DATETIME) FROM inserted;

			SELECT @movieCount = COUNT(*) 
			FROM Showing s
				JOIN Movie m
					ON s.MovieID = m.MovieID
			WHERE (CAST(DATE AS DATETIME) + CAST(TIME AS DATETIME)) <= @datetime
				AND DATEADD(MINUTE, m.Runtime, CAST(DATE AS DATETIME) + CAST(TIME AS DATETIME)) >= @datetime;

			IF @movieCount <= 0
				INSERT INTO Showing SELECT MovieID, AuditoriumID, Date, Time FROM inserted
			ELSE 
				RAISERROR('Cannot show a movie during another movie', 13, 13);
		END
		ELSE 
			RAISERROR('Cannot be showing before release date', 13, 13);
	END
GO

-- Success case --
BEGIN TRAN testInsertShowing
	INSERT INTO Showing (MovieID, AuditoriumID, Date, Time) VALUES (
		(SELECT TOP 1 MovieID FROM Movie ORDER BY RAND()),
		(SELECT TOP 1 AuditoriumID FROM Auditorium ORDER BY RAND()),
		CONVERT(Date, GETDATE()),
		CONVERT(Time, GETDATE())
	);
	SELECT * FROM Showing
	GO
ROLLBACK TRAN testInsertShowing

-- Failure Case: showing before release --
BEGIN TRAN testInsertShowing
	INSERT INTO Movie (Title, ReleaseDate, Runtime, RatingID) VALUES (
		'Testing',
		CONVERT(Date, GETDATE()),
		RAND(),
		(SELECT TOP 1 RatingID FROM Rating ORDER BY RAND())
	);

	INSERT INTO Showing (MovieID, AuditoriumID, Date, Time) VALUES (
		@@IDENTITY,
		(SELECT TOP 1 AuditoriumID FROM Auditorium ORDER BY RAND()),
		'1970-01-01',
		CONVERT(Time, GETDATE())
	);
ROLLBACK TRAN testInsertShowing

-- Failure Case: two movies at the same time --
BEGIN TRAN testInsertShowing
	DECLARE @auditorium INT;
	SELECT TOP 1 @auditorium = AuditoriumID FROM Auditorium ORDER BY RAND();
	
	INSERT INTO Showing (MovieID, AuditoriumID, Date, Time) VALUES (
		(SELECT TOP 1 MovieID FROM Movie ORDER BY RAND()),
		@auditorium,
		CONVERT(Date, GETDATE()),
		CONVERT(Time, GETDATE())
	);

	INSERT INTO Showing (MovieID, AuditoriumID, Date, Time) VALUES (
		(SELECT TOP 1 MovieID FROM Movie ORDER BY RAND()),
		@auditorium,
		CONVERT(Date, GETDATE()),
		CONVERT(Time, GETDATE())
	);
ROLLBACK TRAN testInsertShowing