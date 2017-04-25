use Cinema;

SELECT m.MovieID, m.Title, t.Year, SUM(t.No_of_Tickets) as No_of_Tickets
FROM Movie m
	JOIN Showing s
		ON m.MovieID = s.MovieID
	JOIN (SELECT t.ShowingID, DATEPART(year, o.OrderDate) as Year, SUM(od.No_of_Tickets) as No_of_Tickets
			FROM OrderDetail od
				JOIN [Order] o
					ON od.OrderID = o.OrderID
				JOIN Ticket t
					ON t.TicketID = od.TicketID
			GROUP BY t.ShowingID, DATEPART(year, o.OrderDate)) t
		ON t.ShowingID = s.ShowingID
GROUP BY m.MovieID, m.Title, t.Year
ORDER BY m.MovieID, t.Year;