/* 1. Implement the Cinema database and create the database in SQL server. Don't forget to implement the primary and foreign keys. */

GO
CREATE DATABASE Cinema;

GO
USE Cinema;

GO
CREATE TABLE Rating
(
	RatingID INT IDENTITY(1,1) PRIMARY KEY,
	RatingName NVARCHAR(10) NOT NULL,
	RatingDescription NVARCHAR(255) NOT NULL
);

CREATE TABLE Movie 
(
	MovieID INT IDENTITY(1,1) PRIMARY KEY,
	Title NVARCHAR(50) NOT NULL,
	ReleaseDate DATE NULL,
	Runtime INT NULL,
	RatingID INT NULL FOREIGN KEY REFERENCES Rating(RatingID),
);

CREATE TABLE Genre
(
	GenreID INT IDENTITY(1,1) PRIMARY KEY,
	GenreName NVARCHAR(50) NOT NULL
);

CREATE TABLE MovieGenre
(
	MovieGenreID INT IDENTITY(1,1) PRIMARY KEY,
	MovieID INT NOT NULL FOREIGN KEY REFERENCES Movie(MovieID),
	GenreID INT NOT NULL FOREIGN KEY REFERENCES Genre(GenreID)
);

CREATE TABLE Auditorium
(
	AuditoriumID INT IDENTITY(1,1) PRIMARY KEY,
	AuditoriumName NVARCHAR(50) NOT NULL,
	Available_Seats INT NOT NULL
);

CREATE TABLE Showing
(
	ShowingID INT IDENTITY(1,1) PRIMARY KEY,
	MovieID INT NOT NULL FOREIGN KEY REFERENCES Movie(MovieID),
	AuditoriumID INT NOT NULL FOREIGN KEY REFERENCES Auditorium(AuditoriumID),
	[Date] DATE NOT NULL,
	[Time] TIME NOT NULL
);

CREATE TABLE Customer
(
	CustomerID INT IDENTITY(1,1) PRIMARY KEY,
	FirstName NVARCHAR(100) NOT NULL,
	LastName NVARCHAR(100) NOT NULL,
	Gender CHAR NOT NULL,
	DOB DATE NOT NULL,
	Email NVARCHAR(255) NOT NULL,
	CHECK (Gender IN ('M','F'))
);

CREATE TABLE [Order]
(
	OrderID INT IDENTITY(1,1) PRIMARY KEY,
	CustomerID INT NOT NULL FOREIGN KEY REFERENCES Customer(CustomerID),
	OrderDate DATE NOT NULL
);

CREATE TABLE Category
(
	CategoryID INT IDENTITY(1,1) PRIMARY KEY,
	Name NVARCHAR(50) NOT NULL,
	[Description] NVARCHAR(255) NOT NULL
);

CREATE TABLE Ticket
(
	TicketID INT IDENTITY(1,1) PRIMARY KEY,
	ShowingID INT NOT NULL FOREIGN KEY REFERENCES Showing(ShowingID),
	CategoryID INT NOT NULL FOREIGN KEY REFERENCES Category(CategoryID),
	Price MONEY
);

CREATE TABLE OrderDetail
(
	OrderID INT FOREIGN KEY REFERENCES [Order](OrderID),
	TicketID INT FOREIGN KEY REFERENCES Ticket(TicketID),
	PRIMARY KEY (OrderID, TicketID)
);

/* 2. Add records to each table. Make sure that each table has at least 5 records and the table Showing, Ticket and Order need to have at least 15 records. Write the insert statements, execute them and make sure all data is entered correctly. */

/* Rating INSERTS */
INSERT INTO Rating VALUES('G','All ages admitted. Nothing that would offend parents for viewing by children.');
INSERT INTO Rating VALUES('PG','Some material may not be suitable for children. Parents urged to give "parental guidance". May contain some material parents might not like for their young children.');
INSERT INTO Rating VALUES('PG-13','Some material may be inappropriate for children under 13. Parents are urged to be cautious. Some material may be inappropriate for pre-teenagers.');
INSERT INTO Rating VALUES('R','Under 17 requires accompanying parent or adult guardian. Contains some adult material. Parents are urged to learn more about the film before taking their young children with them.');
INSERT INTO Rating VALUES('NC-17','No One 17 and Under Admitted. Clearly adult. Children are not admitted.');

/* Movie INSERTS */
INSERT INTO Movie VALUES
(
	'The Shawshank Redeption',
	'1994-10-14',
	142,
	4
);
INSERT INTO Movie VALUES
(
	'Interstellar',
	'2014-11-07',
	169,
	3
);
INSERT INTO Movie VALUES
(
	'The Shining',
	'1980-06-13',
	146,
	4
);
INSERT INTO Movie VALUES
(
	'Requiem for a Dream',
	'2000-12-15',
	102,
	4
);
INSERT INTO Movie VALUES
(
	'Toy Story',
	'1995-11-22',
	81,
	1
);
INSERT INTO Movie VALUES
(
	'Star Wars: The Last Jedi',
	'2017-12-15'
);
INSERT INTO Movie VALUES
(
	'Cars 3',
	'2017-06-16'
);
INSERT INTO Movie VALUES
(
	'There Will Be Blood',
	'2007-1-25',
	158,
	4
);
INSERT INTO Movie VALUES
(
	'Raiders of the Lost Ark',
	'1981-06-12',
	115,
	2
);
INSERT INTO Movie VALUES
(
	'Back to the Future',
	'1985-07-03',
	116,
	2
);

/* Genre INSERTS */
INSERT INTO Genre VALUES ('Action');
INSERT INTO Genre VALUES ('Adventure');
INSERT INTO Genre VALUES ('Animated');
INSERT INTO Genre VALUES ('Comedy');
INSERT INTO Genre VALUES ('Documentary');
INSERT INTO Genre VALUES ('Family');
INSERT INTO Genre VALUES ('Crime');
INSERT INTO Genre VALUES ('Horror');
INSERT INTO Genre VALUES ('Musical');
INSERT INTO Genre VALUES ('Romance');
INSERT INTO Genre VALUES ('Sport');
INSERT INTO Genre VALUES ('War');
INSERT INTO Genre VALUES ('Biography');
INSERT INTO Genre VALUES ('Drama');
INSERT INTO Genre VALUES ('Fantasy');
INSERT INTO Genre VALUES ('History');
INSERT INTO Genre VALUES ('Mystery');
INSERT INTO Genre VALUES ('Thriller');
INSERT INTO Genre VALUES ('Sci-Fi');
INSERT INTO Genre VALUES ('Western');
INSERT INTO Genre VALUES ('Romantic Comedy');