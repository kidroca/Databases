/* Add two more stored procedures that operate in transactions: 
	WithdrawMoney(AccountId, money) 
	DepositMoney(AccountId, money) */

-- Function as constant
CREATE FUNCTION ufn_ErrorMessageNegativeAmmount()
RETURNS nvarchar(100)
AS 
	BEGIN
		RETURN '@amount must be a positive number'
	END
GO

CREATE PROC usp_Withdraw(@accountId int, @amount money)
AS
IF @amount <= 0 
	BEGIN
		DECLARE @error nvarchar(100) = dbo.ufn_ErrorMessageNegativeAmmount()
		RAISERROR(@error, 16, 1)
	END
ELSE IF 
	(SELECT Balance FROM Accounts WHERE Id = @accountId) IS NULL
	RAISERROR('Cannot withdraw, the ballance is not setup', 16, 1)
ELSE 
	BEGIN
		UPDATE Accounts
		SET Balance -= @amount
		WHERE Id = @accountId
	END
GO

CREATE PROC usp_Deposit(@accountId int, @amount money)
AS
IF @amount <= 0
	BEGIN
		DECLARE @error nvarchar(100) = dbo.ufn_ErrorMessageNegativeAmmount()
		RAISERROR(@error, 16, 1)
	END 
ELSE IF
	(SELECT Balance FROM Accounts WHERE Id = @accountId) IS NULL
	UPDATE Accounts
	SET Balance = @amount
	WHERE Id = @accountId
ELSE 
	BEGIN
		UPDATE Accounts
		SET Balance += @amount
		WHERE Id = @accountId
	END
GO

EXEC usp_Withdraw 1, 999
GO

EXEC usp_Deposit 2, 1050
GO

EXEC usp_Deposit 4, 100

SELECT * FROM Accounts