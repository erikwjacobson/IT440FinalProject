SELECT Title, ReleaseDate, Runtime
FROM Movie m
WHERE (SELECT s.MovieID, count(*)
	   FROM Showing s
	       JOIN Ticket t
	           ON s.ShowingID = t.ShowingID
       WHERE s.MovieID = m.MovieID) = 0;