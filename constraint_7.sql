use Cinema
GO

CREATE TRIGGER assertShowingDate on Showing
INSTEAD OF INSERT, UPDATE
AS 
	BEGIN
		DECLARE @releaseDate DATE;

		SELECT @releaseDate = ReleaseDate FROM Movie WHERE MovieID IN (SELECT MovieID FROM inserted);
		
		IF @releaseDate < (SELECT Date FROM inserted)
			INSERT INTO Showing SELECT MovieID, AuditoriumID, Date, Time FROM inserted
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

-- Failure Case --
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