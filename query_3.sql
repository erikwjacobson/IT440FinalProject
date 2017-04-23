use Cinema;

SELECT MovieID, Date, count(a.Available_Seats) as Available_Seats
FROM Showing s
	JOIN Auditorium a
		ON a.AuditoriumID = s.AuditoriumID
GROUP BY s.MovieID, s.Date;