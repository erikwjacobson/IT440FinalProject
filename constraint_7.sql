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