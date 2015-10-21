/* Create a database with two tables: Persons(Id(PK), FirstName, 
LastName, SSN) and Accounts(Id(PK), PersonId(FK), Balance). 

	Insert few records for testing.
	
	Write a stored procedure that selects the full names of 
	all persons. */

IF DB_ID('TransactPeopleDB') IS NULL
CREATE DATABASE TransactPeopleDB
GO

USE TransactPeopleDB

IF OBJECT_ID('Persons') IS NULL
BEGIN
	CREATE TABLE Persons(
		Id int IDENTITY,
		FirstName nvarchar(80) NOT NULL,
		LastName nvarchar(80) NOT NULL,
		SSN numeric(9) NOT NULL,
		CONSTRAINT PK_PersonId PRIMARY KEY(Id),
		CONSTRAINT UK_Persons_SSN UNIQUE(SSN)
	)
END
GO

IF OBJECT_ID('Accounts') IS NULL
BEGIN
	CREATE TABLE Accounts(
		Id int IDENTITY,
		PersonId int NOT NULL,
		Balance money,
		CONSTRAINT PK_AccountId PRIMARY KEY(Id),
		CONSTRAINT FK_Accounts_Persons_Id FOREIGN KEY(PersonId)
		REFERENCES Persons(Id)
	)
END
GO

CREATE PROC usp_SelectFullNames
AS
	SELECT FirstName + ' ' + LastName [Full Name]
	FROM Persons
GO

INSERT INTO Persons(FirstName, LastName, SSN)
VALUES
	('Bogdan', 'Telerikov', 123456789),
	('Rumyana', 'Telerikova', 987654321),
	('Skarledd', 'Yohansom', 111111111),
	('Batman', 'Ot Yambol', 999999999),
	('Grozdan', 'Ivanov', 898989898),
	('Penka', 'Petrova', 989898989)
GO

INSERT INTO Accounts(PersonId, Balance)
VALUES
	(1, 15000),
	(2, 12000),
	(3, 14000),
	(4, NULL),
	(5, 9000),
	(6, 90000)
GO