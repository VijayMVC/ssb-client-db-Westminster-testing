SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [etl].[Load_rptBusinessRulesBucketsOutput]
AS 

DECLARE @fTable TABLE (ID INT IDENTITY(1,1), COLUMN_NAME VARCHAR(100))
INSERT INTO @fTable (COLUMN_NAME)
SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_NAME = 'vwBusinessRules' AND TABLE_SCHEMA = 'etl'
AND COLUMN_NAME <> 'SSB_CRMSYSTEM_CONTACT_ID'
AND COLUMN_NAME NOT LIKE 'Internal%'



DECLARE @count INT = 1
DECLARE @maxCount INT
DECLARE @RunTime DATETIME = GETDATE()
DECLARE @sql NVARCHAR(MAX)
DECLARE @Column VARCHAR(100)

SET @maxCount = (SELECT MAX(ID) FROM @fTable)

IF OBJECT_ID('tempdb.dbo.#BusinessRules','U') IS NOT NULL DROP TABLE #BusinessRules
SELECT * INTO #BusinessRules FROM etl.vwBusinessRules 

TRUNCATE TABLE rpt.BusinessRulesBucketsOutput

MERGE rpt.BusinessRuleWeights t
USING @fTable s
	ON t.BusinessRule = s.COLUMN_NAME
WHEN NOT MATCHED
	THEN INSERT
		(BusinessRule)
	VALUES (
		S.COLUMN_NAME)
WHEN NOT MATCHED BY SOURCE	
	THEN UPDATE
		SET IsDeleted = 1;


WHILE @count <= @maxCount
BEGIN
	SET @Column = (SELECT COLUMN_NAME FROM @fTable WHERE ID = @count)
	SET @sql = '

	INSERT INTO rpt.BusinessRulesBucketsOutput (SSB_CRMSYSTEM_CONTACT_ID, BusinessRule, BR_Count,AsOfDate)

	SELECT SSB_CRMSYSTEM_CONTACT_ID, '''+ @Column+''', ' + @Column + ','''+ CAST(@RunTime AS VARCHAR(50)) +''' FROM #BusinessRules
	WHERE ' + @Column + ' > 1 '

	PRINT @sql
	EXEC(@sql)

	SET @count +=1


END

UPDATE a
SET BR_Weight = b.Weight
FROM rpt.BusinessRulesBucketsOutput a
JOIN rpt.BusinessRuleWeights b
	ON a.BusinessRule = b.BusinessRule
WHERE a.BR_Weight IS NULL


--truncate table rpt.BusinessRulesBucketsOutput

EXEC [rpt].[load_DimCustomerBucketing_v0]

GO
