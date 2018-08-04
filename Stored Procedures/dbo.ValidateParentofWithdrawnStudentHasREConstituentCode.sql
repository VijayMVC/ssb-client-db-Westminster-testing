SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE PROC [dbo].[ValidateParentofWithdrawnStudentHasREConstituentCode] 
	@BizRuleSK	INT 
	AS
--[dbo].[ValidateParentofWithdrawnStudentHasREConstituentCode]  7

DECLARE @BizRuleSubscriptionSK INT
SET @BizRuleSubscriptionSK = ISNULL((SELECT BizRuleSubscriptionSK FROM dbo.BizRule_Subscription WHERE BizRuleSK = @BizRuleSK),-1);

WITH xx AS  (
SELECT DISTINCT dm2.SSB_CRMSYSTEM_CONTACT_ID, dm2.SSID constituent_id ,
dm.SSID AS EntityNo,
cc.constiuent_code_id
,ROW_NUMBER() OVER(PARTITION BY dm.DimCustomerId ORDER BY dm.SSID DESC) rn
FROM ods.SeniorSystems_persons a
JOIN
	(SELECT FamilyID, HouseholdID FROM ods.SeniorSystems_persons 
	WHERE EntityNo IN (SELECT EntityNo FROM ods.SeniorSystems_persons_student
			WHERE AcademicGroup = 'Withdrawn')) x
		ON (a.HouseholdID = x.HouseholdID
		OR a.FamilyID = x.FamilyID)
		AND a.IsParent = 'true'
JOIN dbo.dimcustomerssbid dm
	ON a.EntityNo = dm.SSID AND dm.SourceSystem = 'SeniorSystems'
JOIN dbo.dimcustomerssbid dm2
	ON dm.SSB_CRMSYSTEM_CONTACT_ID = dm2.SSB_CRMSYSTEM_CONTACT_ID AND dm2.SourceSystem = 'RaisersEdge'
LEFT JOIN (SELECT DISTINCT constituent_id, constiuent_code_id FROM ods.BlackBaud_constituentcodes WHERE description = 'Past Parent Withdrawl' AND inactive ='false') cc 
	ON dm2.SSID = cc.constituent_id	
WHERE cc.constituent_id IS NULL
)

SELECT 
	SSID
	,SourceSystem
	,@BizRuleSK
	,@BizRuleSubscriptionSK
	,'Fail'
	, xx.constituent_id
	, xx.EntityNo
	, NULL UID
	, xx.constiuent_code_id
	, NULL
	, HASHBYTES('sha2_256', ISNULL(RTRIM(CONCAT(xx.constituent_id,xx.EntityNo,xx.constiuent_code_id)),'DBNULL_TEXT') ) 
FROM dbo.vwDimCustomer_ModAcctId a JOIN xx ON a.SSB_CRMSYSTEM_CONTACT_ID = xx.SSB_CRMSYSTEM_CONTACT_ID
AND a.SourceSystem = 'RaisersEdge'
--WHERE xx.RE_Add <> xx.SS_ADD
--AND xx.AddressNumber IS NOT NULL 
WHERE rn = 1
GO
