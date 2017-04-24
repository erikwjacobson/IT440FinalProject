use Cinema;

SELECT MovieID, Date, SUM(a.Available_Seats) - SUM(t.No_of_Tickets) as Available_Seats
FROM Showing s
	JOIN Auditorium a
		ON a.AuditoriumID = s.AuditoriumID
	JOIN (SELECT t.ShowingID, DATEPART(year, o.OrderDate) as Year, SUM(od.No_of_Tickets) as No_of_Tickets
			FROM OrderDetail od
				JOIN [Order] o
					ON od.OrderID = o.OrderID
				JOIN Ticket t
					ON t.TicketID = od.TicketID
			GROUP BY t.ShowingID, DATEPART(year, o.OrderDate)) t
		ON t.ShowingID = s.ShowingID
GROUP BY s.MovieID, s.Date;