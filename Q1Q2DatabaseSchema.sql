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
	No_of_Tickets INT NOT NULL,
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
	'2017-12-15',
	NULL,
	NULL
);
INSERT INTO Movie VALUES
(
	'Cars 3',
	'2017-06-16',
	NULL,
	NULL
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

/* MovieGenre INSERTS */
INSERT INTO MovieGenre VALUES (1,14);
INSERT INTO MovieGenre VALUES (1,17);
INSERT INTO MovieGenre VALUES (2,19);
INSERT INTO MovieGenre VALUES (2,14);
INSERT INTO MovieGenre VALUES (3,8);
INSERT INTO MovieGenre VALUES (4,18);
INSERT INTO MovieGenre VALUES (4,14);
INSERT INTO MovieGenre VALUES (5,6);
INSERT INTO MovieGenre VALUES (5,3);
INSERT INTO MovieGenre VALUES (6,1);
INSERT INTO MovieGenre VALUES (6,2);
INSERT INTO MovieGenre VALUES (6,19);
INSERT INTO MovieGenre VALUES (7,3);
INSERT INTO MovieGenre VALUES (7,6);
INSERT INTO MovieGenre VALUES (8,14);
INSERT INTO MovieGenre VALUES (9,2);
INSERT INTO MovieGenre VALUES (9,1);
INSERT INTO MovieGenre VALUES (10,2);
INSERT INTO MovieGenre VALUES (10,19);

/* Auditorium INSERTS */
INSERT INTO Auditorium VALUES ('Orpheum Theater',75);
INSERT INTO Auditorium VALUES ('AMC Theater',65);
INSERT INTO Auditorium VALUES ('Cinemark',60);
INSERT INTO Auditorium VALUES ('Grand Cinema',100);
INSERT INTO Auditorium VALUES ('Mankato Movies',40);

/* Category INSERTS */
INSERT INTO Category VALUES ('Employee','Employee tickets provide a 10% discount.');
INSERT INTO Category VALUES ('Adult','Adult tickets allow admission into any available movie.');
INSERT INTO Category VALUES ('Teenager','Teenager tickets allow admission into any movie with a PG-13 rating or below');
INSERT INTO Category VALUES ('Children','Child tickets allow admission into any PG or G movie.');
INSERT INTO Category VALUES ('Veterans','Veteran tickets allow admission into any available movie and provide a 10% discount.');

/* Showing INSERTS */
INSERT INTO Showing VALUES (1,5,'2017-03-06','10:15:00 AM');
INSERT INTO Showing VALUES (1,4,'2017-03-06','12:15:00 PM');
INSERT INTO Showing VALUES (1,2,'2017-03-06','08:45:00 PM');
INSERT INTO Showing VALUES (1,1,'2017-03-06','09:00:00 PM');
INSERT INTO Showing VALUES (1,2,'2017-04-12','09:00:00 PM');
INSERT INTO Showing VALUES (1,2,'2017-04-12','11:00:00 PM');
INSERT INTO Showing VALUES (1,3,'2017-04-12','09:00:00 PM');
INSERT INTO Showing VALUES (1,5,'2017-04-12','09:00:00 PM');
INSERT INTO Showing VALUES (1,2,'2017-04-12','09:00:00 PM');
INSERT INTO Showing VALUES (1,5,'2017-03-06','04:00:00 PM');
INSERT INTO Showing VALUES (2,2,'2016-08-14','08:15:00 PM');
INSERT INTO Showing VALUES (2,3,'2016-08-14','03:35:00 PM');
INSERT INTO Showing VALUES (2,2,'2016-08-14','05:30:00 PM');
INSERT INTO Showing VALUES (2,5,'2017-02-04','12:00:00 PM');
INSERT INTO Showing VALUES (2,1,'2017-02-04','03:35:00 PM');
INSERT INTO Showing VALUES (3,4,'2016-01-22','08:15:00 PM');
INSERT INTO Showing VALUES (3,2,'2015-05-06','03:00:00 PM');
INSERT INTO Showing VALUES (3,5,'2015-05-06','06:00:00 PM');
INSERT INTO Showing VALUES (3,1,'2015-11-19','04:20:00 PM');
INSERT INTO Showing VALUES (3,1,'2017-02-04','08:15:00 PM');
INSERT INTO Showing VALUES (4,5,'2011-05-14','06:00:00 PM');
INSERT INTO Showing VALUES (4,3,'2015-11-19','03:00:00 PM');
INSERT INTO Showing VALUES (4,3,'2012-07-11','05:30:00 PM');
INSERT INTO Showing VALUES (4,5,'2011-05-14','06:00:00 PM');
INSERT INTO Showing VALUES (5,3,'2014-02-06','08:15:00 PM');
INSERT INTO Showing VALUES (5,1,'2017-02-04','05:30:00 PM');
INSERT INTO Showing VALUES (5,1,'2017-02-06','05:30:00 PM');
INSERT INTO Showing VALUES (5,2,'2015-05-06','04:20:00 PM');
INSERT INTO Showing VALUES (5,2,'2012-07-11','06:00:00 PM');
INSERT INTO Showing VALUES (6,1,'2017-02-06','01:00:00 PM');
INSERT INTO Showing VALUES (6,3,'2016-07-07','04:20:00 PM');
INSERT INTO Showing VALUES (6,2,'2012-07-11','09:00:00 PM');
INSERT INTO Showing VALUES (6,1,'2017-02-06','03:00:00 PM');
INSERT INTO Showing VALUES (7,4,'2015-12-21','02:45:00 PM');
INSERT INTO Showing VALUES (7,1,'2013-04-06','03:00:00 PM');
INSERT INTO Showing VALUES (7,1,'2017-02-06','09:00:00 PM');
INSERT INTO Showing VALUES (7,2,'2016-01-22','01:00:00 PM');
INSERT INTO Showing VALUES (8,3,'2012-03-10','06:00:00 PM');
INSERT INTO Showing VALUES (8,2,'2013-04-06','04:20:00 PM');
INSERT INTO Showing VALUES (8,5,'2017-03-04','03:00:00 PM');
INSERT INTO Showing VALUES (8,5,'2016-01-22','02:45:00 PM');
INSERT INTO Showing VALUES (9,3,'2015-12-21','04:20:00 PM');
INSERT INTO Showing VALUES (9,2,'2015-12-21','09:00:00 PM');
INSERT INTO Showing VALUES (10,5,'2017-03-04','09:00:00 PM');
INSERT INTO Showing VALUES (10,1,'2013-04-06','09:00:00 PM');
INSERT INTO Showing VALUES (10,3,'2016-07-07','08:45:00 PM');

/* Ticket INSERTS */
INSERT INTO Ticket VALUES (35,4,4.50);
INSERT INTO Ticket VALUES (37,3,10.00);
INSERT INTO Ticket VALUES (27,3,10.00);
INSERT INTO Ticket VALUES (29,4,4.50);
INSERT INTO Ticket VALUES (28,3,11.00);
INSERT INTO Ticket VALUES (45,3,11.00);
INSERT INTO Ticket VALUES (36,4,4.50);
INSERT INTO Ticket VALUES (1,1,9.00);
INSERT INTO Ticket VALUES (2,2,9.00);
INSERT INTO Ticket VALUES (4,2,11.00);
INSERT INTO Ticket VALUES (4,5,9.00);
INSERT INTO Ticket VALUES (5,1,9.00);
INSERT INTO Ticket VALUES (38,2,11.00);
INSERT INTO Ticket VALUES (1,2,9.00);
INSERT INTO Ticket VALUES (2,2,11.00);
INSERT INTO Ticket VALUES (3,5,9.00);
INSERT INTO Ticket VALUES (4,2,10.00);
INSERT INTO Ticket VALUES (5,2,11.00);
INSERT INTO Ticket VALUES (6,2,10.00);
INSERT INTO Ticket VALUES (7,1,9.00);
INSERT INTO Ticket VALUES (8,2,9.00);
INSERT INTO Ticket VALUES (9,5,9.00);
INSERT INTO Ticket VALUES (10,5,9.00);
INSERT INTO Ticket VALUES (11,2,11.00);
INSERT INTO Ticket VALUES (12,5,4.50);
INSERT INTO Ticket VALUES (13,5,4.50);
INSERT INTO Ticket VALUES (15,2,11.00);
INSERT INTO Ticket VALUES (16,2,11.00);
INSERT INTO Ticket VALUES (17,2,9.00);
INSERT INTO Ticket VALUES (18,2,10.00);
INSERT INTO Ticket VALUES (21,2,11.00);
INSERT INTO Ticket VALUES (14,2,9.00);

/* Customer INSERTS */
INSERT INTO Customer VALUES
(
	'Erik',
	'Jacobson',
	'M',
	'1997-03-06',
	'erik@example.com'
);
INSERT INTO Customer VALUES 
(
	'Chas',
	'Bassett',
	'M',
	'1995-11-14', /* I just guessed */
	'chas@example.com'
);
INSERT INTO Customer VALUES 
(
	'Rick',
	'Sanchez',
	'M',
	'1957-04-19',
	'rick@example.com'
);
INSERT INTO Customer VALUES 
(
	'Adam',
	'Smith',
	'M',
	'1984-12-11',
	'adam@example.com'
);
INSERT INTO Customer VALUES 
(
	'Mary',
	'Smith',
	'F',
	'1988-04-12',
	'mary@example.com'
);
INSERT INTO Customer VALUES 
(
	'Laurel',
	'Jacobson',
	'F',
	'1992-04-17',
	'laurel@example.com'
);

/* Order INSERTS */
SELECT * FROM Customer;
INSERT INTO [Order] VALUES (1,'2017-03-06');
INSERT INTO [Order] VALUES (1,'2017-02-04');
INSERT INTO [Order] VALUES (1,'2015-11-19');
INSERT INTO [Order] VALUES (1,'2015-12-21');
INSERT INTO [Order] VALUES (1,'2016-01-22');
INSERT INTO [Order] VALUES (6,'2015-05-06');
INSERT INTO [Order] VALUES (6,'2013-04-06');
INSERT INTO [Order] VALUES (6,'2014-02-06');
INSERT INTO [Order] VALUES (2,'2017-02-06');
INSERT INTO [Order] VALUES (2,'2017-03-04');
INSERT INTO [Order] VALUES (2,'2017-04-12');
INSERT INTO [Order] VALUES (3,'2017-03-06');
INSERT INTO [Order] VALUES (3,'2017-02-04');
INSERT INTO [Order] VALUES (3,'2016-08-14');
INSERT INTO [Order] VALUES (3,'2012-03-10');
INSERT INTO [Order] VALUES (3,'2011-07-14');
INSERT INTO [Order] VALUES (3,'2011-05-14');
INSERT INTO [Order] VALUES (3,'2012-07-11');
INSERT INTO [Order] VALUES (4,'2010-03-14');
INSERT INTO [Order] VALUES (5,'2012-07-14');
INSERT INTO [Order] VALUES (5,'2013-08-31');
INSERT INTO [Order] VALUES (5,'2016-07-07');
INSERT INTO [Order] VALUES (5,'2013-02-12');

/* OrderDetail INSERTS */
INSERT INTO OrderDetail VALUES(1,1,2);
INSERT INTO OrderDetail VALUES(2,2,4);
INSERT INTO OrderDetail VALUES(3,3,2);
INSERT INTO OrderDetail VALUES(4,4,2);
INSERT INTO OrderDetail VALUES(6,6,2);
INSERT INTO OrderDetail VALUES(7,7,2);
INSERT INTO OrderDetail VALUES(8,8,3);
INSERT INTO OrderDetail VALUES(9,9,2);
INSERT INTO OrderDetail VALUES(11,11,2);
INSERT INTO OrderDetail VALUES(12,12,4);
INSERT INTO OrderDetail VALUES(13,13,2);
INSERT INTO OrderDetail VALUES(14,14,5);
INSERT INTO OrderDetail VALUES(15,15,6);
INSERT INTO OrderDetail VALUES(16,16,8);
INSERT INTO OrderDetail VALUES(17,17,5);
INSERT INTO OrderDetail VALUES(18,20,4);
INSERT INTO OrderDetail VALUES(19,25,3);
INSERT INTO OrderDetail VALUES(20,21,3);
INSERT INTO OrderDetail VALUES(21,23,2);
INSERT INTO OrderDetail VALUES(22,24,1);
INSERT INTO OrderDetail VALUES(23,22,5);