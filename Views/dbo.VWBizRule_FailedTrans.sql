SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[VWBizRule_FailedTrans]

AS

SELECT a.* FROM [dbo].[BizRule_FailedTrans] a
LEFT JOIN [dbo].BizRule_PassedTrans b
	ON a.SSID = b.SSID
	AND a.SourceSystem = b.SourceSystem
	AND a.BizRuleSK = b.BizRuleSK
WHERE a.BatchSK < ISNULL(b.BatchSK,999999999)
GO
