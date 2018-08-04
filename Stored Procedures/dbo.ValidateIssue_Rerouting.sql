SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROC [dbo].[ValidateIssue_Rerouting] 
	@BizRuleSK	INT 
	AS
--[dbo].[ValidateIssue_Rerouting]  20

DECLARE @BizRuleSubscriptionSK INT
SET @BizRuleSubscriptionSK = ISNULL((SELECT BizRuleSubscriptionSK FROM dbo.BizRule_Subscription WHERE BizRuleSK = @BizRuleSK),-1);



WITH base AS (
SELECT a.IssueID,a.SSID,a.SourceSystem,a.Constituent_ID,a.EntityNo FROM dbo.BizRule_Issues a JOIN dbo.BizRule_Issues_Notes b ON b.IssueID = a.IssueID
WHERE b.IsIgnore = 1 AND b.NoteText LIKE 'Re-route%'
)

SELECT 
	base.IssueID SSID
	,'BizRuleIssue'
	,@BizRuleSK
	,@BizRuleSubscriptionSK
	,'Fail'
	, base.constituent_id
	, ISNULL(base.EntityNo, CASE WHEN base.SourceSystem = 'SeniorSystems' THEN SSID END)  EntityNo
	, NULL UID
	, IssueID
	, NULL
	, HASHBYTES('sha2_256', CAST(IssueID AS VARCHAR(10)) ) 
FROM base
GO
