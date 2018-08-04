SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [rpt].[prompt_Name] (@TableName VARCHAR(255))
AS

--SELECT 'Select All' Name, '-1' Value
--UNION ALL
SELECT DISTINCT CASE WHEN LEN(CAST(a.PriorityOrder AS VARCHAR(5))) = 1 THEN '0' + CAST(a.PriorityOrder AS VARCHAR(5)) ELSE CAST(a.PriorityOrder AS VARCHAR(5)) END +'-' +a.Name AS Name, a.BizRuleSubscriptionSK Value

FROM dbo.BizRule_Subscription a
INNER JOIN dbo.BizRule_Issues_Logi b ON b.BizRuleSubscriptionSK = a.BizRuleSubscriptionSK
--WHERE TableName = @TableName
ORDER BY 1
GO
