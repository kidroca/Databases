/* Define a function in the database TelerikAcademy that returns 
all Employee's names (first or middle or last name) and 
all town's names that are comprised of given set of letters. 
	Example: 'oistmiahf' will return 
	'Sofia', 'Smith', … but not 'Rob' and 'Guy'.*/
USE TelerikAcademy
Go

CREATE FUNCTION ufn_IsCharInWord(
	@char nchar(1), @word nvarchar(254))
	RETURNS BIT 
AS 
BEGIN
	IF (CHARINDEX(@char, @word) > 0)
		RETURN 1
	RETURN 0
END
GO

CREATE FUNCTION ufn_WordMatchesLetters(
	@word nvarchar(254), @letters nvarchar(254))
	RETURNS BIT
AS
BEGIN
	IF @word IS NULL 
		RETURN 0
	DECLARE @counter int = 1, @currentChar nchar(1)
	WHILE @counter <= LEN(@word)
		BEGIN
			SET @currentChar = SUBSTRING(@word, @counter, 1)
			IF dbo.ufn_IsCharInWord(@currentChar, @letters) = 0
				RETURN 0
			SET @counter += 1
		END	
	RETURN 1 -- If the loop ends naturally the word is a match
END
GO

CREATE FUNCTION ufn_GetNames(@letters nvarchar(256)) 
	RETURNS @MatchingNames TABLE
	(
		[Matching Names] nvarchar(256)
	)
AS 
BEGIN	
	INSERT INTO @MatchingNames
		SELECT FirstName FROM Employees
		WHERE dbo.ufn_WordMatchesLetters(FirstName, @letters) = 1
	INSERT INTO @MatchingNames 
		SELECT LastName FROM Employees
		WHERE dbo.ufn_WordMatchesLetters(LastName, @letters) = 1
	INSERT INTO @MatchingNames 
		SELECT MiddleName FROM Employees
		WHERE dbo.ufn_WordMatchesLetters(MiddleName, @letters) = 1
	INSERT INTO @MatchingNames
		SELECT Name FROM Towns
		WHERE dbo.ufn_WordMatchesLetters(Name, @letters) = 1
	RETURN
END
GO

SELECT [Matching Names] FROM ufn_GetNames('oistmiahf')
ORDER BY LEN([Matching Names]) DESC
GO

-- I'll probably facepalm myself when I see how easily/shorter others
-- solved this asignment