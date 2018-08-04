SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



CREATE PROC [dbo].[ValidateCurrentParents_RE_SS] 
	@BizRuleSK	INT 
	AS
--[dbo].[ValidateCurrentParents_RE_SS]  10

DECLARE @BizRuleSubscriptionSK INT
SET @BizRuleSubscriptionSK = ISNULL((SELECT BizRuleSubscriptionSK FROM dbo.BizRule_Subscription WHERE BizRuleSK = @BizRuleSK),-1);

WITH deceased AS (SELECT constituent_id FROM ods.BlackBaud_constituents WHERE deceased = 'true'),
 xx AS  (
SELECT DISTINCT
a.SSB_CRMSYSTEM_CONTACT_ID 
,SUM(b.SS_Current_Parent)  SS_Current_Parent
,SUM(b.RE_Current_Parent) RE_Current_Parent
FROM dbo.dimcustomerssbid a
JOIN dbo.vwConstituent_Tagging b ON b.SSID = a.SSID AND b.SourceSystem = a.SourceSystem
WHERE a.SourceSystem IN ('RaisersEdge','SeniorSystems')
GROUP BY a.SSB_CRMSYSTEM_CONTACT_ID
HAVING NOT (COUNT(1) =2 AND COUNT(DISTINCT a.SourceSystem) = 2)
)

SELECT 
	SSID
	,SourceSystem
	,@BizRuleSK
	,@BizRuleSubscriptionSK
	,'Fail'
	, CASE WHEN a.SourceSystem = 'RaisersEdge' THEN SSID END constituent_id
	, CASE WHEN a.SourceSystem = 'SeniorSystems' THEN SSID END EntityNo
	, CASE WHEN a.SourceSystem = 'Schoology' THEN SSID END UID
	, NULL
	, NULL
	, HASHBYTES('sha2_256', xx.SSB_CRMSYSTEM_CONTACT_ID ) 
FROM dbo.vwDimCustomer_ModAcctId a JOIN xx ON a.SSB_CRMSYSTEM_CONTACT_ID = xx.SSB_CRMSYSTEM_CONTACT_ID
WHERE (xx.SS_Current_Parent > 0 or xx.RE_Current_Parent > 0)
AND NOT (xx.SS_Current_Parent = 1 AND xx.RE_Current_Parent = 1)
AND a.SourceSystem IN ('RaisersEdge','SeniorSystems')
AND NOT (a.SourceSystem = 'RaisersEdge' AND SSID IN (SELECT * FROM deceased))

GO
