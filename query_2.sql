use Cinema;

SELECT s.MovieID as MovieID, DATEPART(year, s.Date) as Year, count(*) as Sales
FROM Showing s
	JOIN Ticket t
		ON s.ShowingID = t.ShowingID
GROUP BY s.MovieID, DATEPART(year, s.Date);