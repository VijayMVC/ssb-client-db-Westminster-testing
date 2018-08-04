SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



create PROC [dbo].[ValidateCurrentFacStaff_RE_SS] 
	@BizRuleSK	INT 
	AS
--[dbo].[ValidateCurrentFacStaff_RE_SS]  11

DECLARE @BizRuleSubscriptionSK INT
SET @BizRuleSubscriptionSK = ISNULL((SELECT BizRuleSubscriptionSK FROM dbo.BizRule_Subscription WHERE BizRuleSK = @BizRuleSK),-1);

WITH xx AS  (
SELECT DISTINCT
a.SSB_CRMSYSTEM_CONTACT_ID 
,SUM(b.SS_Current_FactStaff)  SS_Current_FactStaff
,SUM(b.RE_Current_FactStaff) RE_Current_FactStaff
FROM dbo.dimcustomerssbid a
JOIN dbo.vwConstituent_Tagging b ON b.SSID = a.SSID AND b.SourceSystem = a.SourceSystem
GROUP BY a.SSB_CRMSYSTEM_CONTACT_ID
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
WHERE (xx.SS_Current_FactStaff > 0 or xx.RE_Current_FactStaff > 0)
AND NOT (xx.SS_Current_FactStaff = 1 AND xx.RE_Current_FactStaff = 1)

GO
