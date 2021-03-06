SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
--UPDATE dbo.BizRule_Header SET ProcName = '[dbo].[ValidateCurrentStudents_Suffix_SS_to_RE] ' WHERE BizRuleSK = 12
--SELECT * FROM dbo.BizRule_Header a JOIN dbo.BizRule_Subscription b ON b.BizRuleSK = a.BizRuleSK WHERE a.BizRuleSK = 12

CREATE PROC [dbo].[ValidateCurrentStudents_Suffix_SS_to_RE] 
	@BizRuleSK	INT 
	AS
--[dbo].[ValidateCurrentStudents_Suffix_SS_to_RE]  12

DECLARE @BizRuleSubscriptionSK INT
SET @BizRuleSubscriptionSK = ISNULL((SELECT BizRuleSubscriptionSK FROM dbo.BizRule_Subscription WHERE BizRuleSK = @BizRuleSK),-1);

WITH xx AS  (
SELECT * FROM (
SELECT DISTINCT
a.SSB_CRMSYSTEM_CONTACT_ID
,a.SSID
,a.DimCustomerId
,a.SourceSystem
, a.FirstName
,a.LastName
,a.Suffix
,a.EmailPrimary
,a.AddressPrimaryStreet
,a.Birthday
,a.ExtAttribute1 Gradyear
,SS_Current_Student
,RE_Current_Student
,SUM(CASE WHEN a.SourceSystem = 'RaisersEdge' THEN 1 ELSE 0 END) OVER(PARTITION BY SSB_CRMSYSTEM_CONTACT_ID) RE_COUNT
, SUM(CASE WHEN a.SourceSystem = 'SeniorSystems' THEN 1 ELSE 0 END) OVER(PARTITION BY SSB_CRMSYSTEM_CONTACT_ID) SS_COUNT
FROM dbo.vwDimCustomer_ModAcctId a
JOIN dbo.vwConstituent_Tagging b ON b.SSID = a.SSID AND b.SourceSystem = a.SourceSystem
WHERE SS_Current_Student = 1 OR RE_Current_Student = 1
)z
WHERE NOT (z.RE_COUNT = 1 AND z.SS_COUNT = 1)
)
, suff AS (
		SELECT DISTINCT Suffix
		,CASE WHEN Suffix IN('Jr','Jr.','junior') THEN ', Jr.'
		WHEN Suffix IN ('CPA','D.D.S.','DMD','Esq.','JD','M.D.','Ph.D.','Sr.') THEN ', ' + Suffix
		WHEN Suffix = 'D. Min'THEN ', DMin'
		WHEN Suffix = 'Esq'THEN ', Esq.'
		WHEN Suffix = 'J.D.'THEN ', JD'
		WHEN Suffix IN('MD','M.D','M.D., F.A.C.S.') THEN ', M.D.'
		WHEN Suffix IN('PhD','Ph.D') THEN ', Ph.D.'
		WHEN Suffix = 'Sr'THEN ', Sr.'
		WHEN Suffix IN('II','III','IV','V') THEN Suffix
			END SuffixClean
		 FROM ods.SeniorSystems_persons)

SELECT 
	SSID
	,SourceSystem
	,@BizRuleSK
	,@BizRuleSubscriptionSK
	,'Fail'
	, CASE WHEN a.SourceSystem = 'RaisersEdge' THEN SSID END constituent_id
	, CASE WHEN a.SourceSystem = 'SeniorSystems' THEN SSID END EntityNo
	, CASE WHEN a.SourceSystem = 'Schoology' THEN SSID END UID
	, SS_DimCustomerId
	, NULL
	, HASHBYTES('sha2_256', CONCAT(a.FirstName,a.LastName,a.SS_Suffix) ) 
FROM (SELECT  xx.FirstName, xx.LastName, COUNT(1) xc 
, MAX(CASE WHEN xx.SourceSystem = 'RaisersEdge' THEN SSID END)				SSID
, MAX(CASE WHEN xx.SourceSystem = 'SeniorSystems' THEN DimCustomerId END)				SS_DimCustomerId
, 'RaisersEdge' SourceSystem
, MAX(CASE WHEN xx.SourceSystem = 'RaisersEdge' THEN Suffix END)					RE_Suffix
, MAX(CASE WHEN xx.SourceSystem = 'SeniorSystems' THEN Suffix END)					SS_Suffix
, MAX(CASE WHEN xx.SourceSystem = 'RaisersEdge' THEN EmailPrimary END)				RE_EmailPrimary
, MAX(CASE WHEN xx.SourceSystem = 'SeniorSystems' THEN EmailPrimary END)			SS_EmailPrimary
, MAX(CASE WHEN xx.SourceSystem = 'RaisersEdge' THEN AddressPrimaryStreet END)		RE_AddressPrimaryStreet
, MAX(CASE WHEN xx.SourceSystem = 'SeniorSystems' THEN AddressPrimaryStreet END)	SS_AddressPrimaryStreet
, MAX(CASE WHEN xx.SourceSystem = 'RaisersEdge' THEN Birthday END)					RE_Birthday
, MAX(CASE WHEN xx.SourceSystem = 'SeniorSystems' THEN Birthday END)				SS_Birthday
, MAX(CASE WHEN xx.SourceSystem = 'RaisersEdge' THEN Gradyear END)					RE_Gradyear
, MAX(CASE WHEN xx.SourceSystem = 'SeniorSystems' THEN Gradyear END)				SS_Gradyear
	FROM xx 
	GROUP BY  xx.FirstName, xx.LastName
	HAVING COUNT(1) = 2) a
	WHERE (RE_EmailPrimary = SS_EmailPrimary
	OR RE_AddressPrimaryStreet = SS_AddressPrimaryStreet
	OR RE_Birthday = SS_Birthday
	OR RE_Gradyear = SS_Gradyear)
	AND NOT (ISNULL(RE_Birthday,'1900-01-01') <> ISNULL(SS_Birthday,'1900-01-01')
		OR ISNULL(RE_Gradyear,'') <> ISNULL(SS_Gradyear,''))
	AND ISNULL(RE_Suffix,'') = '' AND ISNULL(SS_Suffix,'') <> ''
	AND a.SS_Suffix IN (SELECT suffix FROM suff WHERE suff.SuffixClean IS NOT NULL)
GO
