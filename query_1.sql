use Cinema;
use Music;

SELECT m.MovieID, m.Title
FROM Movie m
WHERE (SELECT SUM(t.No_of_Tickets) as No_of_Tickets 
	FROM Showing s
		JOIN (SELECT SUM(od.No_of_Tickets) as No_of_Tickets, t.ShowingID
				FROM Ticket t
					JOIN OrderDetail od
						ON t.TicketID = od.TicketID
				GROUP BY t.ShowingID) t
			ON t.ShowingID = s.ShowingID
	WHERE s.MovieID = m.MovieID) <= 0;