SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
--UPDATE dbo.BizRule_Subscription SET OutputProcedure = '[dbo].[OutputCurrentStudents_Suffix_RE_to_SS] ' WHERE BizRuleSK = 12
--SELECT b.* FROM dbo.BizRule_Header a JOIN dbo.BizRule_Subscription b ON b.BizRuleSK = a.BizRuleSK WHERE a.BizRuleSK = 12


CREATE PROC [dbo].[ValidateCurrentStudents_AdditionalSuiteNo_RE_to_SS] 
	@BizRuleSK	INT 
	AS
--[dbo].[ValidateCurrentStudents_Suffix_RE_to_SS]  13

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
,a.AddressPrimarySuite
,a.Birthday
,a.ExtAttribute1 Gradyear
,SS_Current_Student
,RE_Current_Student
,SUM(CASE WHEN a.SourceSystem = 'RaisersEdge' THEN 1 ELSE 0 END) OVER(PARTITION BY SSB_CRMSYSTEM_CONTACT_ID) RE_COUNT
, SUM(CASE WHEN a.SourceSystem = 'SeniorSystems' THEN 1 ELSE 0 END) OVER(PARTITION BY SSB_CRMSYSTEM_CONTACT_ID) SS_COUNT
FROM dbo.vwDimCustomer_ModAcctId a
JOIN dbo.vwConstituent_Tagging b ON b.SSID = a.SSID AND b.SourceSystem = a.SourceSystem
WHERE (SS_Current_Student = 1 OR RE_Current_Student = 1 ) --OR b.SS_Current_Parent = 1 OR b.SS_Current_FactStaff = 1 OR b.RE_Current_Parent = 1 OR b.RE_Current_FactStaff)
)z
WHERE NOT (z.RE_COUNT = 1 AND z.SS_COUNT = 1)
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
	, RE_dimcust
	, NULL
	, HASHBYTES('sha2_256', CONCAT(a.FirstName,a.LastName,a.AddressPrimaryStreet,RE_AddressPrimarySuite) ) 
FROM (SELECT  xx.FirstName, xx.LastName, AddressPrimaryStreet, COUNT(1) xc 
, MAX(CASE WHEN xx.SourceSystem = 'SeniorSystems' THEN SSID END)				SSID
, MAX(CASE WHEN xx.SourceSystem = 'RaisersEdge' THEN DimCustomerId END)				RE_dimcust
, 'SeniorSystems' SourceSystem
, MAX(CASE WHEN xx.SourceSystem = 'RaisersEdge' THEN AddressPrimarySuite END)					RE_AddressPrimarySuite
, MAX(CASE WHEN xx.SourceSystem = 'SeniorSystems' THEN AddressPrimarySuite END)					SS_AddressPrimarySuite
, MAX(CASE WHEN xx.SourceSystem = 'RaisersEdge' THEN Birthday END)					RE_Birthday
, MAX(CASE WHEN xx.SourceSystem = 'SeniorSystems' THEN Birthday END)				SS_Birthday
, MAX(CASE WHEN xx.SourceSystem = 'RaisersEdge' THEN Gradyear END)					RE_Gradyear
, MAX(CASE WHEN xx.SourceSystem = 'SeniorSystems' THEN Gradyear END)				SS_Gradyear
	FROM xx 
	GROUP BY  xx.FirstName, xx.LastName, AddressPrimaryStreet
	HAVING COUNT(1) = 2) a
	WHERE ISNULL(RE_AddressPrimarySuite,'') <> ISNULL(SS_AddressPrimarySuite,'')
	AND NOT (ISNULL(RE_Birthday,'1900-01-01') <> ISNULL(SS_Birthday,'1900-01-01')
		OR ISNULL(RE_Gradyear,'') <> ISNULL(SS_Gradyear,''))
	AND ISNULL(RE_AddressPrimarySuite,'') = ''



GO
