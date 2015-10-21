/* Using database cursor write a T-SQL script that scans all 
employees and their addresses and prints all pairs of employees 
that live in the same town. */
DECLARE sameTown_cursor CURSOR
	FOR SELECT e1.FirstName + ' ' + e1.LastName AS [Employee 1],
		e2.FirstName + ' ' + e2.LastName AS [Employee 2],
		t1.Name AS Town
		FROM Employees e1
	JOIN Addresses a ON e1.AddressID = a.AddressID
	JOIN Towns t1 ON a.TownID = t1.TownID,
		Employees e2 
			JOIN Addresses a2 ON e2.AddressID = a2.AddressID
			JOIN Towns t2 ON a2.TownId = t2.TownID
	WHERE t1.TownID = t2.TownId AND 
		e1.EmployeeID != e2.EmployeeID
	ORDER BY e1.EmployeeID, e2.EmployeeID
	
OPEN sameTown_cursor
FETCH NEXT FROM sameTown_cursor

-- execute actions on the current fetch
-- call FETCH NEXT FROM sameTown_cursor to get the next row

CLOSE sameTown_cursor
DEALLOCATE sameTown_cursor
GO
