use Cinema;

SELECT c.Name, Year, SUM(No_of_Tickets) as No_of_Tickets
FROM Ticket t
	JOIN (SELECT od.TicketID, DATEPART(year, o.OrderDate) as Year, SUM(od.No_of_Tickets) as No_of_Tickets
			FROM OrderDetail od
				JOIN [Order] o
					ON od.OrderID = o.OrderID
			GROUP BY od.TicketID, DATEPART(year, o.OrderDate)) od
		ON t.TicketID = od.TicketID
	JOIN Category c
		ON c.CategoryID = t.CategoryID
GROUP BY Year, c.Name;