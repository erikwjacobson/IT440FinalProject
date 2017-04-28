use Cinema;

SELECT  
	CASE
		WHEN SUM(No_of_Tickets) > 0 THEN SUM(No_of_Tickets)
		ELSE 0
	END  as No_of_Tickets,
	c.Name
FROM Ticket t
	LEFT JOIN OrderDetail od
		ON t.TicketID = od.TicketID
	LEFT JOIN Category c
		ON t.CategoryID = c.CategoryID
GROUP BY c.CategoryID, c.Name;