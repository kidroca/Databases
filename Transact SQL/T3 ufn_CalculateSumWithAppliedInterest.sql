/* Create a function that accepts as parameters – sum, yearly 
interest rate and number of months. 
	It should calculate and return the new sum.
	Write a SELECT to test whether the function works as 
	expected.*/

CREATE FUNCTION ufn_CalculateSumWithAppliedInterest(
	@sum money, @yearlyInterest float, @numberOfMonths int)
RETURNS money 
AS 
BEGIN
	RETURN (@sum + (@sum * @yearlyInterest * @numberOfMonths))
END
GO

SELECT 
	FirstName, 
	LastName, 
	dbo.ufn_CalculateSumWithAppliedInterest(a.Balance, 0.03, 5)
		AS [Expected New Ballance]
FROM Persons p JOIN Accounts a 
	ON p.Id = a.PersonId