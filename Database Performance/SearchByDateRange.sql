/* 1. Create a table in SQL Server with 10 000 000 log entries (date + text).
		Search in the table by date range. Check the speed (without caching). */

USE DatabasePerformanceHW
GO

SELECT *
  FROM [Logs]
  WHERE [Date] BETWEEN '2001-10-11' AND '2010-10-13'
GO

SELECT * 
	FROM [Logs]
	WHERE YEAR([Date]) = 1999
GO

/* 2. Add an index to speed-up the search by date. */

IF NOT EXISTS(SELECT * FROM sys.indexes WHERE name='IX_LogsDate' AND object_id = OBJECT_ID('Logs'))
BEGIN
	CREATE INDEX IX_LogsDate ON dbo.Logs([Date])
END
GO

CHECKPOINT; 
GO 
DBCC DROPCLEANBUFFERS; 
GO

SELECT *
  FROM [Logs]
  WHERE [Date] BETWEEN '2001-10-11' AND '2010-10-13'
GO
