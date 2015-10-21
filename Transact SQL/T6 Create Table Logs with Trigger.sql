/* Create another table – Logs(LogID, AccountID, OldSum, NewSum). 
	Add a trigger to the Accounts table that enters a new entry 
	into the Logs table every time the sum on an account changes.
 */
IF OBJECT_ID('Logs', 'U') IS NULL
BEGIN
CREATE TABLE Logs(
	Id int IDENTITY,
	AccountId int NOT NULL,
	OldSum money,
	NewSum money,
	[Date] DATETIME NOT NULL,
	CONSTRAINT PK_Logs PRIMARY KEY(Id),
	CONSTRAINT FK_Logs_Accounts FOREIGN KEY(AccountId)
	REFERENCES Accounts(Id))
END
GO

IF OBJECT_ID('tr_LogBallanceChanges') IS NOT NULL
DROP TRIGGER tr_LogBallanceChanges
GO

CREATE TRIGGER tr_LogBallanceChanges ON Accounts
	FOR UPDATE, INSERT 
AS 
BEGIN
	DECLARE @account int, @old money, @new money
	IF ((SELECT Id FROM DELETED) IS NOT NULL)
		BEGIN
			SELECT 
				@account = d.Id, 
				@old = d.Balance,
				@new = a.Balance 
			FROM DELETED d JOIN Accounts a
				ON d.Id = a.Id
		END
	ELSE 
		BEGIN
			SELECT 
				@account = Id,
				@old = NULL,
				@new = Balance 
			FROM INSERTED					
		END		 
	INSERT INTO Logs(AccountId, OldSum, NewSum, [Date])
	VALUES(@account, @old, @new, GETDATE()) 
END
GO

-- Tests
EXEC usp_Deposit 1, 5
GO

EXEC usp_Withdraw 6, 4
GO

EXEC usp_Deposit 2, 2
GO

INSERT INTO Persons(FirstName, LastName, SSN)
VALUES('Goiko', 'Bate', 987654322)
GO 

INSERT INTO Accounts(PersonId, Balance)
VALUES((SELECT Id FROM Persons 
	WHERE SSN = 987654322), 500000)
GO

SELECT * FROM Logs
GO