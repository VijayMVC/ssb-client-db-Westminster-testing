SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE PROC [dbo].[ValidateCurrentStudents_RE_SS] 
	@BizRuleSK	INT 
	AS
--[dbo].[ValidateCurrentStudents_RE_SS]  9

DECLARE @BizRuleSubscriptionSK INT
SET @BizRuleSubscriptionSK = ISNULL((SELECT BizRuleSubscriptionSK FROM dbo.BizRule_Subscription WHERE BizRuleSK = @BizRuleSK),-1);

WITH xx AS  (
SELECT DISTINCT
a.SSB_CRMSYSTEM_CONTACT_ID 
,SUM(b.SS_Current_Student)  SS_Current_Student
,SUM(b.RE_Current_Student) RE_Current_Student
FROM dbo.dimcustomerssbid a
JOIN dbo.vwConstituent_Tagging b ON b.SSID = a.SSID AND b.SourceSystem = a.SourceSystem
WHERE a.SourceSystem IN ('RaisersEdge','SeniorSystems')
GROUP BY a.SSB_CRMSYSTEM_CONTACT_ID
HAVING NOT (COUNT(1) =2 AND COUNT(DISTINCT a.SourceSystem) = 2)
)

SELECT DISTINCT
	a.SSID
	,a.SourceSystem
	,@BizRuleSK
	,@BizRuleSubscriptionSK
	,'Fail'
	, CASE WHEN a.SourceSystem = 'RaisersEdge' THEN a.SSID END constituent_id
	, CASE WHEN a.SourceSystem = 'SeniorSystems' THEN a.SSID END EntityNo
	, CASE WHEN a.SourceSystem = 'Schoology' THEN a.SSID END UID
	, NULL
	, NULL
	, HASHBYTES('sha2_256', xx.SSB_CRMSYSTEM_CONTACT_ID ) 
FROM dbo.vwDimCustomer_ModAcctId a JOIN xx ON a.SSB_CRMSYSTEM_CONTACT_ID = xx.SSB_CRMSYSTEM_CONTACT_ID
INNER JOIN dbo.vwConstituent_Tagging b ON b.SSID = a.SSID AND b.SourceSystem = a.SourceSystem
LEFT JOIN (SELECT DISTINCT SSID,SourceSystem, OtherID FROM dbo.BizRule_Issues WHERE BizRuleSK IN (12,13,14,16) AND IssueIsCompleted = 0) chk
	ON ((a.SSID = chk.SSID AND a.SourceSystem = chk.SourceSystem) OR a.DimCustomerId = chk.OtherID) 
WHERE (xx.SS_Current_Student > 0 or xx.RE_Current_Student > 0)
AND NOT (xx.SS_Current_Student = 1 AND xx.RE_Current_Student = 1)
AND (b.SS_Current_Student > 0 OR b.RE_Current_Student > 0)
AND chk.ssid IS null
GO
