SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE PROC [dbo].[OutputDownstreamChanges_RE] 
	@IssueID	INT 
	AS
--[dbo].[OutputDownstreamChanges_RE] 61157    11430
--SELECT * FROM dbo.BizRule_Issues WHERE bizrulesk = 19 and IssueIsCompleted = 0

SELECT 
'Senior Systems Change' Field
,CASE WHEN p.IsStudent = 'true' THEN 'Student' WHEN p.IsFaculty = 'true' AND p.IsParent = 'true' THEN 'Faculty/Staff & Parent'  WHEN p.IsFaculty = 'true' THEN 'Faculty/Staff' ELSE 'Parent'  END [Constituent Type]
, p.FullName [Full Name]
,bri.EntityNo SSID
,sis.FieldName [Field Name]
,sis.Current_Value [Current Value]
,sis.Previous_Value [Previous Value]
, CASE WHEN sis.ParentSSID IS NOT NULL THEN 'True' ELSE 'False' END [Is Parent Related]
,ISNULL(pp.FullName,'') [Related Parent Name]
FROM dbo.BizRule_Issues bri
INNER JOIN dbo.BizRule_Subscription bs ON bs.BizRuleSubscriptionSK = bri.BizRuleSubscriptionSK
INNER JOIN (SELECT *,ROW_NUMBER() OVER(PARTITION BY SSID, FieldName ORDER BY ChangeDate DESC) RN
			FROM dbo.SIS_DataChanges) sis 
	ON sis.SSID = bri.ssid
	AND sis.FieldName = bs.KeyFieldName
	AND sis.rn = 1	
INNER JOIN ods.SeniorSystems_persons p
	ON SIS.SSID = p.EntityNo
LEFT JOIN ods.SeniorSystems_persons pp
	ON sis.ParentSSID = pp.EntityNo 
WHERE bri.IssueID = @IssueID

UNION ALL

SELECT 
'Raisers Edge Data' Field
,ssb.ExtAttribute8   [Constituent Type]
,ssb.FullName [Full Name]
,con.constituent_id SSID
,COALESCE(CASE WHEN bs.KeyFieldName = 'phone' THEN pho.type END
			,CASE WHEN bs.KeyFieldName = 'email'THEN em.type END 
			,CASE WHEN bs.KeyFieldName = 'Address'THEN ad.type END 
			,CASE WHEN bs.KeyFieldName = 'businessAddress'THEN AD_bus.type END 
			,sis.FieldName) [Field Name]
,CASE WHEN bs.KeyFieldName = 'PreferredName' THEN con.preferred_name
	WHEN bs.KeyFieldName = 'FirstName' THEN con.firstname
	WHEN bs.KeyFieldName = 'MiddleName' THEN con.MiddleName
	WHEN bs.KeyFieldName = 'LastName' THEN con.LastName
	WHEN bs.KeyFieldName = 'Title' THEN con.Title
	WHEN bs.KeyFieldName ='Address' THEN ad.formatted_address
	WHEN bs.KeyFieldName ='BusinessAddress' THEN AD_bus.formatted_address
	WHEN bs.KeyFieldName = 'Email' THEN em.address
	WHEN bs.KeyFieldName = 'Phone' THEN pho.number
	WHEN bs.KeyFieldName = 'CompanyName' THEN re.name
	WHEN bs.KeyFieldName = 'JobTitle' THEN re.position
	END [Current Value]
,'n/a' [Previous Value]
,'n/a' [Is Parent Related]
,'n/a' [Related Parent Name]
FROM dbo.BizRule_Issues bri
INNER JOIN dbo.BizRule_Subscription bs ON bs.BizRuleSubscriptionSK = bri.BizRuleSubscriptionSK
INNER JOIN (SELECT *,ROW_NUMBER() OVER(PARTITION BY SSID, FieldName ORDER BY ChangeDate DESC) RN
			FROM dbo.SIS_DataChanges) sis 
	ON sis.SSID = bri.ssid
	AND sis.FieldName = bs.KeyFieldName
	AND sis.rn = 1	
INNER JOIN dbo.dimcustomerssbid x ON bri.SSID = x.SSID AND x.SourceSystem ='SeniorSystems'
INNER JOIN dbo.vwDimCustomer_ModAcctId ssb 
	ON ssb.SSB_CRMSYSTEM_CONTACT_ID = x.SSB_CRMSYSTEM_CONTACT_ID AND  ssb.SourceSystem ='RaisersEdge'
LEFT JOIN ods.BlackBaud_constituents con
	ON con.constituent_id = ssb.SSID
LEFT JOIN ods.BlackBaud_addresses AD	
	ON AD.address_id = con.address_id
LEFT JOIN ods.BlackBaud_addresses AD_bus	
	ON AD_bus.constituent_id = con.constituent_id AND bs.KeyFieldName = 'BusinessAddress' AND AD_bus.type = 'Business'
LEFT JOIN ods.BlackBaud_emailaddresses em
	ON em.Email_id = con.email_id
	AND bs.KeyFieldName = 'email'
LEFT JOIN ods.BlackBaud_phones pho
	ON con.constituent_id = pho.constituent_id
	AND bs.KeyFieldName = 'phone'
LEFT JOIN ods.BlackBaud_relationships re
	ON con.constituent_id = re.constituent_id
	AND re.type ='Employer'
WHERE bri.IssueID = @IssueID 

--DELETE dbo.BizRule_Issues_Notes WHERE IssueID IN (SELECT IssueID FROM dbo.BizRule_Issues WHERE BizRuleSK = 18)
--DELETE FROM dbo.BizRule_Issues WHERE issueid = 61157  
--DELETE dbo.BizRule_Issues_Logi WHERE IssueID IN (SELECT IssueID FROM dbo.BizRule_Issues WHERE BizRuleSK = 18)
--EXEC dbo.BizRuleMaster


--UPDATE dbo.BizRule_Subscription
--SET SourceKeyFieldName = 
--	CASE WHEN KeyFieldName = 'Address' THEN 'AddressPrimaryStreet'
--	WHEN KeyFieldName = 'Email' THEN 'EmailPrimary'
--	WHEN KeyFieldName = 'PreferredName' THEN 'SalutationName'
--	WHEN KeyFieldName = 'Title' THEN 'Prefix'
--	ELSE KeyFieldName end
-- WHERE bizrulesk = 19
--SELECT * FROM ods.BlackBaud_addresses WHERE constituent_id = 120972

-- dbo.BizRule_Subscription WHERE bizrulesk = 19


--SELECT * FROM ods.BlackBaud_relationships WHERE constituent_id = 160752
GO
