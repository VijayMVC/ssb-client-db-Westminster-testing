SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[vwCurrentStudents_RE_SS]
as

SELECT * FROM (
SELECT DISTINCT
a.SSB_CRMSYSTEM_CONTACT_ID
,a.SSID
,a.DimCustomerId
,a.SourceSystem
, a.FirstName
,a.SalutationName PreferredName
, a.MiddleName
,a.LastName
,a.Suffix
,a.EmailPrimary
,a.EmailPrimaryIsCleanStatus
,a.AddressPrimaryStreet
,a.AddressPrimarySuite
,a.AddressPrimaryIsCleanStatus
,a.Birthday
,a.ExtAttribute1 Gradyear
,a.ExtAttribute8 ConCodes
,a.ExtAttribute9 StudentCode
,SS_Current_Student
,RE_Current_Student
,SUM(CASE WHEN a.SourceSystem = 'RaisersEdge' THEN 1 ELSE 0 END) OVER(PARTITION BY SSB_CRMSYSTEM_CONTACT_ID) RE_COUNT
, SUM(CASE WHEN a.SourceSystem = 'SeniorSystems' THEN 1 ELSE 0 END) OVER(PARTITION BY SSB_CRMSYSTEM_CONTACT_ID) SS_COUNT
FROM dbo.vwDimCustomer_ModAcctId a
JOIN dbo.vwConstituent_Tagging b ON b.SSID = a.SSID AND b.SourceSystem = a.SourceSystem
WHERE (SS_Current_Student = 1 OR RE_Current_Student = 1 ) --OR b.SS_Current_Parent = 1 OR b.SS_Current_FactStaff = 1 OR b.RE_Current_Parent = 1 OR b.RE_Current_FactStaff)
)z
WHERE NOT (z.RE_COUNT = 1 AND z.SS_COUNT = 1)
GO
