use Cinema;

SELECT DATEPART(year, s.Date) as Year, c.Name, count(*) as Tickets
FROM Ticket t
	JOIN Showing s
		ON t.ShowingID = s.ShowingID
	JOIN  Category c
		ON c.CategoryID = t.CategoryID
GROUP BY DATEPART(year, s.Date), c.Name;
