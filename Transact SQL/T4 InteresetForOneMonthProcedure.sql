/* Create a stored procedure that uses the function from the 
previous example to give an interest to a person's account 
for one month.
	It should take the AccountId and the interest rate as 
	parameters. */
CREATE PROC usp_GetInteresetForOneMonth(
	@accountId int, @interesetRate float)
AS 
	SELECT Id, Balance, 
		dbo.ufn_CalculateSumWithAppliedInterest(
			Balance, @interesetRate, 1) AS [With Interest For One Month]
	FROM Accounts
	WHERE Id = @accountId
GO

EXEC usp_GetInteresetForOneMonth 1, 0.02