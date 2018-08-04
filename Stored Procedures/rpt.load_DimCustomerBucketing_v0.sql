SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE proc [rpt].[load_DimCustomerBucketing_v0]
AS

IF OBJECT_ID('rpt.DimCustomerBucketing_v0', 'U') IS NOT NULL
	DROP TABLE rpt.DimCustomerBucketing_v0 

IF OBJECT_ID('tempdb.dbo.#Base','U') IS NOT NULL DROP TABLE #Base
		Select a.*
			, COUNT(1) over(Partition by SSB_CRMSYSTEM_CONTACT_ID) Total_Recs
			, COUNT(CASE WHEN sourcesystem = 'RaisersEdge' THEN SSID END ) over(Partition by SSB_CRMSYSTEM_CONTACT_ID) AS Total_RaisersEdge
			, COUNT(CASE WHEN sourcesystem = 'FinancialEdge' THEN SSID END ) over(Partition by SSB_CRMSYSTEM_CONTACT_ID) AS Total_FinancialEdge
			, COUNT(CASE WHEN sourcesystem = 'SeniorSystems' THEN SSID END ) over(Partition by SSB_CRMSYSTEM_CONTACT_ID) AS Total_SeniorSystems
			, COUNT(CASE WHEN sourcesystem = 'Schoology' THEN SSID END ) over(Partition by SSB_CRMSYSTEM_CONTACT_ID) AS Total_Schoology
			--
			, b.inactive AS RE_Inactive2
			, b.type AS RE_Type3
			, b.deceased AS RE_Deceased8			--
			, d.IsParent AS SS_IsParent12
			, d.IsStudent AS SS_IsStudent13
			, d.IsFaculty AS SS_IsFaculty14
			, c.[vendor-status] AS FE_Inactive32
			, c.[balance-due] AS FE_BalanceDue33
			--, cc.description AS RE_Description

			Into #Base
		FROM [dbo].[vwDimCustomer_ModAcctId] a
		LEFT JOIN ods.BlackBaud_constituents b on a.SSID = b.constituent_id and a.SourceSystem = 'RaisersEdge'
		--LEFT JOIN ods.BlackBaud_constituentcodes cc ON a.SSID = cc.[constituent-id]
		LEFT JOIN ods.BlackBaudFE_vendors c on a.SSID = c.vendor_id and a.SourceSystem = 'FinancialEdge'
		LEFT JOIN [ods].[SeniorSystems_persons] d on a.SSID = d.entityNo and a.SourceSystem = 'SeniorSystems'
		LEFT JOIN [ods].Schoology_users e on a.SSID = e.uid and a.SourceSystem = 'Schoology'

Select SSID, SourceSystem, CustomerType, Firstname, Middlename, Lastname, FullName, EmailPrimary,CONCAT(AddressPrimaryStreet,' ', AddressPrimaryCity, ' ', AddressPrimaryState, ' ', AddressPrimaryzip) AddressPrimary
, PhonePrimary, SSB_CRMSYSTEM_Contact_ID--, RE_Description
, CASE WHEN SourceSystem = 'RaisersEdge' THEN 1 ELSE 0 END RaisersEdgeCount100
--, CASE WHEN SourceSystem = 'RaisersEdge' AND NameIsCleanStatus <> 'valid' THEN 1 ELSE 0 END RE_NumInvalidNames
, CASE WHEN SourceSystem = 'RaisersEdge' AND NameIsCleanStatus LIKE '%Invalid%' AND FullName NOT LIKE '%[1-9]%[a-z]%' AND ISNUMERIC(FirstName) = 0 AND CustomerType <> 'Organization' AND LastName NOT LIKE 'Boys%' AND LastName NOT LIKE 'Girls%' AND FirstName NOT LIKE 'Class%' THEN 1 ELSE 0 END RE_NumInvalidNames
, CASE WHEN SourceSystem = 'RaisersEdge' AND NameIsCleanStatus = 'Valid' THEN 1 ELSE 0 END RE_NumValidNames
, CASE WHEN SourceSystem = 'RaisersEdge' AND EmailPrimaryIsCleanStatus <> 'Valid' THEN 1 ELSE 0 END RE_NumInvalidEmail
, CASE WHEN SourceSystem = 'RaisersEdge' AND EmailPrimaryIsCleanStatus = 'Valid' THEN 1 ELSE 0 END RE_NumValidEmail
, CASE WHEN SourceSystem = 'RaisersEdge' AND AddressPrimaryIsCleanStatus <> 'Valid' THEN 1 ELSE 0 END RE_NumInvalidAddress
, CASE WHEN SourceSystem = 'RaisersEdge' AND AddressPrimaryIsCleanStatus = 'Valid' THEN 1 ELSE 0 END RE_NumValidAddress
, CASE WHEN SourceSystem = 'RaisersEdge' AND PhonePrimary <> 'Valid' THEN 1 ELSE 0 END RE_NumInvalidPhone
, CASE WHEN SourceSystem = 'RaisersEdge' AND PhonePrimary = 'Valid' THEN 1 ELSE 0 END RE_NumValidPhone
, CASE WHEN SourceSystem = 'RaisersEdge' and RE_Inactive2 = 'true' THEN 1 ELSE 0 END RaisersEdgeInactiveCount9
, CASE WHEN SourceSystem = 'RaisersEdge' and RE_Deceased8 = 'true' THEN 1 ELSE 0 END RaisersEdgeDeceasedCount101
, CASE WHEN SourceSystem = 'RaisersEdge' and Total_RaisersEdge > 1 THEN 1 ELSE 0 END RaisersEdgeDupeCount1
, CASE WHEN SourceSystem = 'RaisersEdge' and RE_type3 = 'individual' THEN 1 ELSE 0 END RaisersEdgeTypeCountIndividual102
, CASE WHEN SourceSystem = 'RaisersEdge' and RE_type3 = 'organization' THEN 1 ELSE 0 END RaisersEdgeTypeCountOrganization103

--, CASE WHEN SourceSystem = 'RaisersEdge' and RE_Description = 'Foundation' THEN 1 ELSE 0 END RaisersEdgeDescCountFoundation
--, CASE WHEN SourceSystem = 'RaisersEdge' and RE_Description = 'Retired Faculty' THEN 1 ELSE 0 END RaisersEdgeDescCountRetiredFaculty
--, CASE WHEN SourceSystem = 'RaisersEdge' and RE_Description = 'Past Parent' THEN 1 ELSE 0 END RaisersEdgeDescCountPastParent
--, CASE WHEN SourceSystem = 'RaisersEdge' and RE_Description = 'Former Staff' THEN 1 ELSE 0 END RaisersEdgeDescCountFormerStaff
--, CASE WHEN SourceSystem = 'RaisersEdge' and RE_Description = 'Former Trustee' THEN 1 ELSE 0 END RaisersEdgeDescCountFormerTrustee
--, CASE WHEN SourceSystem = 'RaisersEdge' and RE_Description = 'Emeritus Trustee' THEN 1 ELSE 0 END RaisersEdgeDescCountEmeritusTrustee
--, CASE WHEN SourceSystem = 'RaisersEdge' and RE_Description = 'Current Parent' THEN 1 ELSE 0 END RaisersEdgeDescCountCurrentParent
--, CASE WHEN SourceSystem = 'RaisersEdge' and RE_Description = 'Organization' THEN 1 ELSE 0 END RaisersEdgeDescCountOrganization
--, CASE WHEN SourceSystem = 'RaisersEdge' and RE_Description = 'Former Grandparent' THEN 1 ELSE 0 END RaisersEdgeDescCountFormerGrandparent
--, CASE WHEN SourceSystem = 'RaisersEdge' and RE_Description = 'Past Parent Withdrawl' THEN 1 ELSE 0 END RaisersEdgeDescCountPastParentWithdrawl
--, CASE WHEN SourceSystem = 'RaisersEdge' and RE_Description = 'Faculty' THEN 1 ELSE 0 END RaisersEdgeDescCountFaculty
--, CASE WHEN SourceSystem = 'RaisersEdge' and RE_Description = 'Cornerstone Society' THEN 1 ELSE 0 END RaisersEdgeDescCountCornerstoneSociety
--, CASE WHEN SourceSystem = 'RaisersEdge' and RE_Description = 'Alumnus' THEN 1 ELSE 0 END RaisersEdgeDescCountAlumnus
--, CASE WHEN SourceSystem = 'RaisersEdge' and RE_Description = 'Friend' THEN 1 ELSE 0 END RaisersEdgeDescCountFriend
--, CASE WHEN SourceSystem = 'RaisersEdge' and RE_Description = 'Grandparent' THEN 1 ELSE 0 END RaisersEdgeDescCountGrandparent
--, CASE WHEN SourceSystem = 'RaisersEdge' and RE_Description = 'Retired Staff' THEN 1 ELSE 0 END RaisersEdgeDescCountRetiredStaff
--, CASE WHEN SourceSystem = 'RaisersEdge' and RE_Description = 'Student' THEN 1 ELSE 0 END RaisersEdgeDescCountStudent
--, CASE WHEN SourceSystem = 'RaisersEdge' and RE_Description = 'Promotion Record' THEN 1 ELSE 0 END RaisersEdgeDescCountPromotionRecord
--, CASE WHEN SourceSystem = 'RaisersEdge' and RE_Description = 'Trustee' THEN 1 ELSE 0 END RaisersEdgeDescCountTrustee
--, CASE WHEN SourceSystem = 'RaisersEdge' and RE_Description = 'New Parent' THEN 1 ELSE 0 END RaisersEdgeDescCountNewParent
--, CASE WHEN SourceSystem = 'RaisersEdge' and RE_Description = 'Staff' THEN 1 ELSE 0 END RaisersEdgeDescCountStaff
--, CASE WHEN SourceSystem = 'RaisersEdge' and RE_Description = 'Corporation' THEN 1 ELSE 0 END RaisersEdgeDescCountCorporation
--, CASE WHEN SourceSystem = 'RaisersEdge' and RE_Description = 'Former Faculty' THEN 1 ELSE 0 END RaisersEdgeDescCountFormerFaculty


, CASE WHEN SourceSystem = 'FinancialEdge' THEN 1 ELSE 0 END FinancialEdgeCount130
--, CASE WHEN SourceSystem = 'FinancialEdge' AND NameIsCleanStatus <> 'valid' THEN 1 ELSE 0 END FE_NumInvalidNames
, CASE WHEN SourceSystem = 'FinancialEdge' AND NameIsCleanStatus LIKE '%Invalid%' AND FullName NOT LIKE '%[1-9]%[a-z]%' AND ISNUMERIC(FirstName) = 0 AND CustomerType <> 'Organization' AND LastName NOT LIKE 'Boys%' AND LastName NOT LIKE 'Girls%' AND FirstName NOT LIKE 'Class%' THEN 1 ELSE 0 END FE_NumInvalidNames
, CASE WHEN SourceSystem = 'FinancialEdge' AND NameIsCleanStatus = 'Valid' THEN 1 ELSE 0 END FE_NumValidNames
, CASE WHEN SourceSystem = 'FinancialEdge' AND EmailPrimaryIsCleanStatus <> 'Valid' THEN 1 ELSE 0 END FE_NumInvalidEmail
, CASE WHEN SourceSystem = 'FinancialEdge' AND EmailPrimaryIsCleanStatus = 'Valid' THEN 1 ELSE 0 END FE_NumValidEmail
, CASE WHEN SourceSystem = 'FinancialEdge' AND AddressPrimaryIsCleanStatus <> 'Valid' THEN 1 ELSE 0 END FE_NumInvalidAddress
, CASE WHEN SourceSystem = 'FinancialEdge' AND AddressPrimaryIsCleanStatus = 'Valid' THEN 1 ELSE 0 END FE_NumValidAddress
, CASE WHEN SourceSystem = 'FinancialEdge' AND PhonePrimary <> 'Valid' THEN 1 ELSE 0 END FE_NumInvalidPhone
, CASE WHEN SourceSystem = 'FinancialEdge' AND PhonePrimary = 'Valid' THEN 1 ELSE 0 END FE_NumValidPhone
, CASE WHEN SourceSystem = 'FinancialEdge' and Total_FinancialEdge > 1 THEN 1 ELSE 0 END FinancialEdgeDupeCount31
, CASE WHEN SourceSystem = 'FinancialEdge' and FE_Inactive32 <> 'Active' THEN 1 ELSE 0 END FinancialEdgeInactiveCount38
, CASE WHEN SourceSystem = 'FinancialEdge' and CAST(FE_BalanceDue33 AS FLOAT) > 0 THEN 1 ELSE 0 END FinancialEdgeBalanceDueCount39


, CASE WHEN SourceSystem = 'SeniorSystems' THEN 1 ELSE 0 END SeniorSystemsCount110
--, CASE WHEN SourceSystem = 'SeniorSystems' AND NameIsCleanStatus <> 'valid' THEN 1 ELSE 0 END SS_NumInvalidNames
, CASE WHEN SourceSystem = 'SeniorSystems' AND NameIsCleanStatus LIKE '%Invalid%' AND FullName NOT LIKE '%[1-9]%[a-z]%' AND ISNUMERIC(FirstName) = 0 AND CustomerType <> 'Organization' AND LastName NOT LIKE 'Boys%' AND LastName NOT LIKE 'Girls%' AND FirstName NOT LIKE 'Class%' THEN 1 ELSE 0 END SS_NumInvalidNames
, CASE WHEN SourceSystem = 'SeniorSystems' AND NameIsCleanStatus = 'Valid' THEN 1 ELSE 0 END SS_NumValidNames
, CASE WHEN SourceSystem = 'SeniorSystems' AND EmailPrimaryIsCleanStatus <> 'Valid' THEN 1 ELSE 0 END SS_NumInvalidEmail
, CASE WHEN SourceSystem = 'SeniorSystems' AND EmailPrimaryIsCleanStatus = 'Valid' THEN 1 ELSE 0 END SS_NumValidEmail
, CASE WHEN SourceSystem = 'SeniorSystems' AND AddressPrimaryIsCleanStatus <> 'Valid' THEN 1 ELSE 0 END SS_NumInvalidAddress
, CASE WHEN SourceSystem = 'SeniorSystems' AND AddressPrimaryIsCleanStatus = 'Valid' THEN 1 ELSE 0 END SS_NumValidAddress
, CASE WHEN SourceSystem = 'SeniorSystems' AND PhonePrimary <> 'Valid' THEN 1 ELSE 0 END SS_NumInvalidPhone
, CASE WHEN SourceSystem = 'SeniorSystems' AND PhonePrimary = 'Valid' THEN 1 ELSE 0 END SS_NumValidPhone
, CASE WHEN SourceSystem = 'SeniorSystems' and Total_SeniorSystems > 1 THEN 1 ELSE 0 END SeniorSystemsDupeCount11
, CASE WHEN sourcesystem = 'SeniorSystems' AND MiddleName = 'Deceased'  THEN 1 ELSE 0 END SeniorSystemsDeceasedCount111
, CASE WHEN SourceSystem = 'SeniorSystems' and SS_IsParent12 = 'true' THEN 1 ELSE 0 END SeniorSystemsParentCount112
, CASE WHEN SourceSystem = 'SeniorSystems' and SS_IsStudent13 = 'true' THEN 1 ELSE 0 END SeniorSystemsStudentCount113
, CASE WHEN SourceSystem = 'SeniorSystems' and SS_IsFaculty14 = 'true' THEN 1 ELSE 0 END SeniorSystemsFacultyCount114

, CASE WHEN SourceSystem = 'Schoology' THEN 1 ELSE 0 END SchoologyCount120
--, CASE WHEN SourceSystem = 'Schoology' AND NameIsCleanStatus <> 'valid' THEN 1 ELSE 0 END Sch_NumInvalidNames
, CASE WHEN SourceSystem = 'Schoology' AND NameIsCleanStatus LIKE '%Invalid%' AND FullName NOT LIKE '%[1-9]%[a-z]%' AND ISNUMERIC(FirstName) = 0 AND CustomerType <> 'Organization' AND LastName NOT LIKE 'Boys%' AND LastName NOT LIKE 'Girls%' AND FirstName NOT LIKE 'Class%' THEN 1 ELSE 0 END Sch_NumInvalidNames
, CASE WHEN SourceSystem = 'Schoology' AND NameIsCleanStatus = 'Valid' THEN 1 ELSE 0 END Sch_NumValidNames
, CASE WHEN SourceSystem = 'Schoology' AND EmailPrimaryIsCleanStatus <> 'Valid' THEN 1 ELSE 0 END Sch_NumInvalidEmail
, CASE WHEN SourceSystem = 'Schoology' AND EmailPrimaryIsCleanStatus = 'Valid' THEN 1 ELSE 0 END Sch_NumValidEmail
, CASE WHEN SourceSystem = 'Schoology' AND AddressPrimaryIsCleanStatus <> 'Valid' THEN 1 ELSE 0 END Sch_NumInvalidAddress
, CASE WHEN SourceSystem = 'Schoology' AND AddressPrimaryIsCleanStatus = 'Valid' THEN 1 ELSE 0 END Sch_NumValidAddress
, CASE WHEN SourceSystem = 'Schoology' AND PhonePrimary <> 'Valid' THEN 1 ELSE 0 END Sch_NumInvalidPhone
, CASE WHEN SourceSystem = 'Schoology' AND PhonePrimary = 'Valid' THEN 1 ELSE 0 END Sch_NumValidPhone
, CASE WHEN SourceSystem = 'Schoology' and Total_Schoology > 1 THEN 1 ELSE 0 END SchoologyDupeCount21

, CASE WHEN Total_RaisersEdge > 0 AND Total_FinancialEdge = 0 AND Total_SeniorSystems = 0 AND Total_Schoology = 0 	THEN 1 ELSE 0 END InREOnlyCount41
, CASE WHEN Total_RaisersEdge = 0 AND Total_FinancialEdge = 0 AND Total_SeniorSystems > 0 AND Total_Schoology = 0 	THEN 1 ELSE 0 END InSSOnlyCount42	
, CASE WHEN Total_RaisersEdge = 0 AND Total_FinancialEdge = 0 AND Total_SeniorSystems = 0 AND Total_Schoology > 0 	THEN 1 ELSE 0 END InSchOnlyCount43
, CASE WHEN Total_RaisersEdge = 0 AND Total_FinancialEdge > 0 AND Total_SeniorSystems = 0 AND Total_Schoology = 0 	THEN 1 ELSE 0 END InFEOnlyCount44
, CASE WHEN Total_RaisersEdge > 0 AND Total_FinancialEdge = 0 AND Total_SeniorSystems > 0 AND Total_Schoology = 0 	THEN 1 ELSE 0 END InREAndSSOnlyCount45
, CASE WHEN Total_RaisersEdge > 0 AND Total_FinancialEdge = 0 AND Total_SeniorSystems = 0 AND Total_Schoology > 0 	THEN 1 ELSE 0 END InREAndSchOnlyCount46
, CASE WHEN Total_RaisersEdge > 0 AND Total_FinancialEdge > 0 AND Total_SeniorSystems = 0 AND Total_Schoology = 0 	THEN 1 ELSE 0 END InREAndFEOnlyCount47
, CASE WHEN Total_RaisersEdge > 0 AND Total_FinancialEdge = 0 AND Total_SeniorSystems > 0 AND Total_Schoology > 0 	THEN 1 ELSE 0 END InREAndSSAndSchOnlyCount48
, CASE WHEN Total_RaisersEdge > 0 AND Total_FinancialEdge > 0 AND Total_SeniorSystems > 0 AND Total_Schoology = 0 	THEN 1 ELSE 0 END InREAndFEAndSSOnlyCount49
, CASE WHEN Total_RaisersEdge > 0 AND Total_FinancialEdge > 0 AND Total_SeniorSystems = 0 AND Total_Schoology > 0 	THEN 1 ELSE 0 END InREAndFEAndSchOnlyCount141
, CASE WHEN Total_RaisersEdge = 0 AND Total_FinancialEdge = 0 AND Total_SeniorSystems > 0 AND Total_Schoology > 0 	THEN 1 ELSE 0 END InSSAndSchOnlyCount142
, CASE WHEN Total_RaisersEdge = 0 AND Total_FinancialEdge > 0 AND Total_SeniorSystems > 0 AND Total_Schoology = 0 	THEN 1 ELSE 0 END InSSAndFEOnlyCount143
, CASE WHEN Total_RaisersEdge = 0 AND Total_FinancialEdge > 0 AND Total_SeniorSystems = 0 AND Total_Schoology > 0 	THEN 1 ELSE 0 END InSchAndFEOnlyCount144
, CASE WHEN Total_RaisersEdge = 0 AND Total_FinancialEdge > 0 AND Total_SeniorSystems > 0 AND Total_Schoology > 0 	THEN 1 ELSE 0 END InSSAndSchAndFEOnlyCount145
, CASE WHEN Total_RaisersEdge > 0 AND Total_FinancialEdge > 0 AND Total_SeniorSystems > 0 AND Total_Schoology > 0 	THEN 1 ELSE 0 END InAllFourCount146
INTO rpt.DimCustomerBucketing_v0
FROM #base


--SELECT * -- COUNT(*)
--FROM rpt.DimCustomerBucketing
--WHERE RE_NumInvalidNames = 1;
GO
