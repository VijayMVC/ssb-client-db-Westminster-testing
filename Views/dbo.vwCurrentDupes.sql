SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [dbo].[vwCurrentDupes]
AS


WITH xx AS (SELECT SSB_CRMSYSTEM_CONTACT_ID FROM dbo.vwDimCustomer_ModAcctId WHERE SourceSystem = 'SeniorSystems' GROUP BY SSB_CRMSYSTEM_CONTACT_ID HAVING COUNT(1) > 1)
,yy AS (SELECT SSB_CRMSYSTEM_CONTACT_ID FROM dbo.vwDimCustomer_ModAcctId WHERE SourceSystem = 'RaisersEdge' GROUP BY SSB_CRMSYSTEM_CONTACT_ID HAVING COUNT(1) > 1)
,zz AS (SELECT SSB_CRMSYSTEM_CONTACT_ID FROM dbo.vwDimCustomer_ModAcctId WHERE SourceSystem = 'Schoology' GROUP BY SSB_CRMSYSTEM_CONTACT_ID HAVING COUNT(1) > 1)


SELECT 
		a.SSB_CRMSYSTEM_CONTACT_ID
		,a.SourceSystem
		,a.SSID		
		,a.Prefix
		,a.FirstName
		,a.SalutationName PreferredName
		,a.MiddleName
		,a.LastName
		,a.Suffix
		,a.FullName
		,a.ExtAttribute1 AS ClassYear
		,a.ExtAttribute8 ConCodes
		,a.Birthday
		,a.AddressPrimaryStreet
		,a.AddressPrimarySuite
		,a.AddressPrimaryCity
		,a.AddressPrimaryState
		,a.AddressPrimaryZip
		,a.AddressPrimaryCounty
		,a.AddressPrimaryCountry
		,a.AddressPrimaryIsCleanStatus
		,a.PhonePrimary
		,a.PhonePrimaryIsCleanStatus
		,a.EmailPrimary
		,a.EmailPrimaryIsCleanStatus 
	FROM dbo.vwDimCustomer_ModAcctID a JOIN (SELECT * FROM xx UNION SELECT * FROM yy UNION SELECT * FROM zz) xx ON xx.SSB_CRMSYSTEM_CONTACT_ID = a.SSB_CRMSYSTEM_CONTACT_ID
	WHERE SourceSystem IN( 'SeniorSystems','RaisersEdge','Schoology')
	--ORDER BY SSB_CRMSYSTEM_CONTACT_ID, sourcesystem
GO
