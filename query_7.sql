use Cinema;

SELECT m.Title, AVG(DATEDIFF(year, DOB, GETDATE())) as Age
FROM Ticket t
	LEFT JOIN Showing s
		ON t.ShowingID = s.ShowingID
	LEFT JOIN Movie m
		ON s.MovieID = m.MovieID
	JOIN OrderDetail od
		ON t.TicketID = od.TicketID
	LEFT JOIN [Order] o
		ON od.OrderID = o.OrderID
	LEFT JOIN Customer c
		ON o.CustomerID = c.CustomerID
GROUP BY m.MovieID, m.Title;