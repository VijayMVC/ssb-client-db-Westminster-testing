SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[ExportRulesOutput] 
@BizRuleSubSK INT 
AS
-- ExportRulesOutput 12


DECLARE @max INT 
DECLARE @count INT= 1
DECLARE @issueID NVARCHAR(10)
DECLARE @proc NVARCHAR(max)
DECLARE @sql NVARCHAR(max)

DECLARE @table TABLE (issueid INT, ID INT IDENTITY(1,1) NOT NULL)

INSERT INTO @table (issueid)
SELECT DISTINCT IssueID FROM dbo.BizRule_Issues WHERE BizRuleSubscriptionSK = @BizRuleSubSK

SET @proc = (SELECT OutputProcedure FROM dbo.BizRule_Subscription WHERE BizRuleSubscriptionSK = @BizRuleSubSK)

SET @max =(SELECT MAX(ID) FROM @table)

WHILE @count <= @max
	BEGIN
    
	SET @sql = 'Exec ' + @proc + ' ' + CAST((SELECT issueID FROM @table WHERE ID = @count) AS NVARCHAR(10))

	EXEC(@sql)

	End

GO
