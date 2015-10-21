/* Write a T-SQL script that shows for each town a list of all 
employees that live in it. */
USE TelerikAcademy
GO

CREATE FUNCTION ufn_EmployeesFromTowns() 
	RETURNS @TownAndEmployees TABLE 
	(
		Town nvarchar(50) NOT NULL,
		Employees nvarchar(MAX)
	)
AS 
BEGIN
	DECLARE @TownsAndEmployeesAll TABLE
	(
		FullName nvarchar(150),
		Town nvarchar(100)
	)

	INSERT INTO @TownsAndEmployeesAll 
		SELECT e.FirstName + ' ' + e.LastName AS FullName, 
			t.Name AS Town
			FROM Employees e
			JOIN Addresses a ON e.AddressID = a.AddressID
			JOIN Towns t ON a.TownID = t.TownID
			ORDER BY Town, FullName
		
	DECLARE Towns_Cursor CURSOR READ_ONLY
		FOR SELECT DISTINCT Town FROM @TownsAndEmployeesAll			
	OPEN Towns_Cursor
	DECLARE @town nvarchar(100)
	FETCH NEXT FROM Towns_Cursor INTO @town

		WHILE @@FETCH_STATUS = 0
		BEGIN
			DECLARE @employees nvarchar(MAX) = ''
			SELECT @employees += FullName + ', ' 
				FROM @TownsAndEmployeesAll
				WHERE Town = @town

			INSERT INTO @TownAndEmployees
			VALUES (@town, @employees)

			FETCH NEXT FROM Towns_Cursor INTO @town
		END
	CLOSE Towns_Cursor
	DEALLOCATE Towns_Cursor
	RETURN
END
GO

SELECT * FROM ufn_EmployeesFromTowns()

DROP FUNCTION ufn_EmployeesFromTowns
GO