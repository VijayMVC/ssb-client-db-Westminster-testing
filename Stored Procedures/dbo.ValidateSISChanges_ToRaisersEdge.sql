SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



CREATE PROC [dbo].[ValidateSISChanges_ToRaisersEdge] 
@BizRuleSK INT
AS
--Exec [dbo].[ValidateSISChanges_ToRaisersEdge] 19

--EXEC dbo.Detect_SIS_DataChanges

--Declare @BizRuleSK INT = 19

	IF OBJECT_ID('tempdb..#Match') IS NOT NULL 
			DROP TABLE #Match  
		SELECT SSB_CRMSYSTEM_CONTACT_ID INTO #Match FROM dbo.dimcustomerssbid 
				WHERE SourceSystem IN ('RaisersEdge','SeniorSystems')
		GROUP BY SSB_CRMSYSTEM_CONTACT_ID HAVING COUNT(1) = 2 AND COUNT(DISTINCT SourceSystem) =2 
		--#Match WHERE SSB_CRMSYSTEM_CONTACT_ID ='22BB70A8-398C-42D5-98D6-FEFEB8108A98'

	IF OBJECT_ID('tempdb..#UpperMiddle') IS NOT NULL 
			DROP TABLE #UpperMiddle  

SELECT a.EntityNo, 'Student' ConstitType INTO #UpperMiddle FROM ods.SeniorSystems_persons a JOIN ods.SeniorSystems_persons_student b ON b.EntityNo = a.EntityNo
WHERE a.IsDeleted = 0 AND StudentCurrentSchool IN ('US','MS')
UNION
SELECT c.EntityNo, 'Parent' ConstitType FROM ods.SeniorSystems_persons a JOIN ods.SeniorSystems_persons_student b ON b.EntityNo = a.EntityNo JOIN ods.SeniorSystems_persons c ON c.FamilyID = a.FamilyID OR c.HouseholdID = a.HouseholdID
WHERE a.IsDeleted = 0 AND StudentCurrentSchool IN ('US','MS') AND c.EntityNo NOT IN (SELECT EntityNo FROM ods.SeniorSystems_persons_student)

	IF OBJECT_ID('tempdb..#changes') IS NOT NULL 
			DROP TABLE #changes  

SELECT DataChangeID, SSID,ChangeDate,FieldName,Current_Value,Previous_Value,ChangeType,ParentSSID 
INTO #changes FROM (SELECT *, ROW_NUMBER() OVER(PARTITION BY SSID, CASE WHEN fieldname LIKE 'othernum%' THEN 'Phone' ELSE fieldname end ORDER BY ChangeDate DESC, LEN(Current_Value)) RN FROM dbo.SIS_DataChanges )x WHERE rn = 1


INSERT INTO dbo.BizRule_SingleValidationResults
	(SSID
	,SourceSystem
	,BizRuleSK
	,BizRuleSubscriptionSK
	,RESULT
	,Constituent_ID
	,EntityNo
	,UID
	,OtherID
	,FieldHash)
SELECT DISTINCT a.SSID,'SeniorSystems' SourceSystem, @BizRuleSK BizRuleSK
,bs.BizRuleSubscriptionSK,'n/a' Result,ssb.SSID Constituent_ID,a.SSID,NULL UID
	,CASE 
	WHEN bs.KeyFieldName IN ( 'Address', 'BusinessAddress') THEN ad.address_id
	WHEN bs.KeyFieldName = 'Email' THEN em.Email_id
	WHEN bs.KeyFieldName = 'Phone' THEN pho.Phoneid
	WHEN bs.KeyFieldName = 'CompanyName' THEN re.relation_id
	WHEN bs.KeyFieldName = 'JobTitle' THEN re.Relationship_id END OtherID , HASHBYTES('sha2_256', CAST(DataChangeID AS VARCHAR(20)) )   FieldHash
--SELECT DISTINCT a.ssid
FROM #changes a
JOIN ods.SeniorSystems_persons p ON a.SSID = p.EntityNo
LEFT JOIN  #UpperMiddle up ON a.SSID = up.EntityNo
JOIN dbo.BizRule_Subscription bs
	ON bs.BizRuleSK = @BizRuleSK
	AND (a.FieldName = bs.KeyFieldName OR ((a.FieldName LIKE '%email%' AND bs.KeyFieldName ='Email') OR ((a.FieldName LIKE '%phone%' OR a.FieldName LIKE 'othernumber%') AND bs.KeyFieldName ='Phone')))
JOIN dbo.dimcustomerssbid dcs ON dcs.SSID = a.SSID AND dcs.SourceSystem = 'SeniorSystems'
JOIN #Match m  ON m.SSB_CRMSYSTEM_CONTACT_ID = dcs.SSB_CRMSYSTEM_CONTACT_ID
INNER JOIN dbo.vwDimCustomer_ModAcctId ssb 
	ON ssb.SSB_CRMSYSTEM_CONTACT_ID = m.SSB_CRMSYSTEM_CONTACT_ID AND  ssb.SourceSystem ='RaisersEdge'
LEFT JOIN ods.BlackBaud_constituents con
	ON con.constituent_id = ssb.SSID
LEFT JOIN ods.BlackBaud_addresses AD	
	ON AD.address_id = con.address_id
LEFT JOIN ods.BlackBaud_emailaddresses em
	ON em.Email_id = con.email_id
LEFT JOIN ods.BlackBaud_phones pho
	ON con.phone_id = pho.Phoneid
LEFT JOIN ods.BlackBaud_relationships re
	ON con.constituent_id = re.constituent_id
	AND re.type ='Employer'
	AND re.is_primary_business = 'true'
WHERE a.ChangeDate > = '1/1/18'
AND a.ParentSSID IS NULL 
AND a.Current_Value <> ISNULL(CASE WHEN bs.KeyFieldName = 'PreferredName' THEN con.preferred_name
	WHEN bs.KeyFieldName = 'FirstName' THEN con.firstname
	WHEN bs.KeyFieldName = 'MiddleName' THEN con.MiddleName
	WHEN bs.KeyFieldName = 'LastName' THEN con.LastName
	WHEN bs.KeyFieldName = 'Title' THEN con.Title
	WHEN bs.KeyFieldName = 'Address' THEN ad.formatted_address
	WHEN bs.KeyFieldName = 'Email' THEN em.address
	WHEN bs.KeyFieldName = 'Phone' THEN pho.number
	WHEN bs.KeyFieldName = 'CompanyName' THEN re.name
	WHEN bs.KeyFieldName = 'JobTitle' THEN re.position
	END, '')
AND ((bs.KeyFieldName = 'Phone' AND  a.Current_Value NOT IN (SELECT number FROM ods.BlackBaud_phones zz WHERE zz.constituent_id = con.constituent_id))
	OR (bs.KeyFieldName = 'email' AND a.Current_Value NOT IN (SELECT zz.address FROM ods.BlackBaud_emailaddresses zz WHERE zz.constituent_id = con.constituent_id))
	OR (bs.KeyFieldName = 'BusinessAddress' AND a.Current_Value NOT IN (SELECT zz.formatted_address FROM ods.BlackBaud_addresses zz WHERE zz.constituent_id = con.constituent_id))
	OR bs.KeyFieldName NOT IN ('Phone','Email','BusinessAddress'))
AND ((bs.KeyFieldName = 'JobTitle' AND re.position IS NOT NULL)
		OR bs.KeyFieldName <> 'JobTitle')

--AND m.SSB_CRMSYSTEM_CONTACT_ID IS null
--	SELECT DISTINCT fieldname FROM dbo.SIS_DataChanges



GO
