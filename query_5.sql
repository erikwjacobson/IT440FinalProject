use Cinema;

SELECT m.MovieID, m.Title
FROM Movie m
WHERE (SELECT a.Available_Seats - ((SELECT t.ShowingID, SUM(od.No_of_Tickets) as No_of_Tickets
			FROM OrderDetail od
				JOIN [Order] o
					ON od.OrderID = o.OrderID
				JOIN Ticket t
					ON t.TicketID = od.TicketID
			WHERE t.ShowingID = s.ShowingID
			GROUP BY t.ShowingID))
		FROM Showing s
			JOIN Auditorium a
				ON s.AuditoriumID = a.AuditoriumID
		WHERE s.MovieID = m.MovieID) <= 0;