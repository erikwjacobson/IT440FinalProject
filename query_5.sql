use Cinema;

SELECT m.MovieID, m.Title
FROM Movie m
WHERE (SELECT a.Available_Seats - (SELECT count(*) FROM Ticket WHERE ShowingID = s.ShowingID)
		FROM Showing s
			JOIN Auditorium a
				ON s.AuditoriumID = a.AuditoriumID
		WHERE s.MovieID = m.MovieID) <= 0;