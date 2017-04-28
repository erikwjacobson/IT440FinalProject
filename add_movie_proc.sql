/* 
The following file covers the following constraints:
	'A movie is required to have at least one genre.'
*/

GO
CREATE PROCEDURE addMovie
	@title NVARCHAR(50),
	@releaseDate DATE,
	@runTime INT,
	@ratingID INT,
	@genreID INT
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

		/* MOVIE INSERT */
		INSERT INTO Movie VALUES(@title, @releaseDate,@runTime,@ratingID);

		/* MOVIEGENRE INSERT */
		INSERT INTO MovieGenre VALUES(@@IDENTITY, @genreID);

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

BEGIN TRANSACTION;
	DECLARE @releaseDate1 DATE;
	SET @releaseDate1 = '2016-12-25';
	EXEC addMovie @title = 'La La Land', @releaseDate = @releaseDate1, @runTime = 126, @ratingID = 99, @genreID = 99;
COMMIT TRANSACTION;
/***********************/
BEGIN TRANSACTION;
	/* Pass */
	DECLARE @releaseDate2 DATE;
	SET @releaseDate2 = '2016-12-25';
	EXEC addMovie @title = 'La La Land', @releaseDate = @releaseDate2, @runTime = 128, @ratingID = 3, @genreID = 14;
COMMIT TRANSACTION;