# Final Project for IT 440

## IT440/540 Final Project – Cinema Database

### Data Model

![Data Model Image](https://i.gyazo.com/984611cf7638dcf7c5ce71ed7dcd240b.png)

DDL & DML

1. ~~Implement the Cinema database and create the database in SQL Server. Don’t forget to implement the primary and foreign keys.~~
2. ~~Add records to each table. Make sure that each table has at least 5 records and the table Showing, Ticket and Order need to have at least 15 records. Write the insert statements, execute them and make sure all data is entered correctly.~~
 
### Extra Constraints 
Write procedures, triggers or functions to handle the constraints listed below. It does not matter how you solve the problem but I want you to write at least 2 triggers and 2 stored procedures. For every procedure, trigger or function that you write make sure you use correct error handling with TRY/CATCH and implement the transaction logic like we discussed in class. 
- ~~Only ‘M’ or ‘F’ can be entered as a gender for a customer.~~
- ~~Every Order needs to have at least one OrderDetail record.~~
- ~~Ticket: the combination of ShowingID and CategoryID needs to be unique.~~
- Only one movie can be displayed at a time in an auditorium.
- It is not allowed sell more tickets than there are seats available for a showing. 
- If a customer has ordered a ticket it is not allowed to change any information for that showing. 
- ~~A movie needs to be released before it can be shown to the customers.~~
- A Customer needs to be older than 13 to order a ticket.
- A Customer that is younger than 17 is not allowed to purchase a ticket for an R-rated movie.
- ~~A movie is required to have at least one genre.~~  
    - Write code to test your logic for each constraint to show that your logic is working correctly.

### Queries
- ~~Return all movies that have not sold any tickets.~~
- ~~Return the total sales per movie per year.~~
- ~~Return the number of available seats for each movie per showing date.~~
- ~~Return the number of tickets sold per year per category.~~
- ~~Return all the movies that have had sold out showings.~~
- ~~Return per category the number of moviegoers.~~
- ~~What’s the average age of the moviegoers per movie.~~

---
Created by:
- Chas Bassett
- Erik Jacobson
