IF NOT EXISTS(SELECT * FROM sys.databases WHERE name = 'DatabasePerformanceHW')
BEGIN
	CREATE DATABASE DatabasePerformanceHW
END

BEGIN TRAN
GO

USE [DatabasePerformanceHW]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

IF OBJECT_ID('dbo.Logs', 'U') IS NULL
BEGIN
	CREATE TABLE [Logs](
		[Id] [int] NOT NULL IDENTITY,
		[Text] [nvarchar](500) NOT NULL,
		[Date] [date] NOT NULL,
	 CONSTRAINT [PK_Logs] PRIMARY KEY CLUSTERED ([Id] ASC))
 END
GO

COMMIT TRAN;
GO

INSERT INTO [Logs]([Text], [Date])
VALUES
	('String s edinichni kavichki', '1901-11-11'),
	('Don''t call us we''ll call you', '1985-7-8'),
	('Random danni ot 99ta', '2001-1-3'),
	('Game of Thrones was here', '1986-11-2'),
	('Mambo No 5', '2205-12-31')
GO

-- Took me 8 minutes to create and around 3GB space on the HDD
WHILE (SELECT COUNT(Id) FROM Logs) <= 10000000 
BEGIN
DECLARE @days int = RAND() * 1000
	INSERT INTO Logs(Text, Date)
	SELECT [Text] + CONVERT(nvarchar, @days),
		DATEADD(day, @days, [Date])
	FROM Logs
END



