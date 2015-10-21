/* Create a stored procedure that accepts a number as a 
parameter and returns all persons who have more money in 
their accounts than the supplied number. */

CREATE PROC usp_PeopleWithHigherBalance(
@balance money)
AS 
	SELECT p.FirstName, p.LastName, a.Balance 
	FROM Persons p JOIN Accounts a ON p.Id = a.PersonId
	WHERE a.Balance > @balance
GO