SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [etl].[vwBusinessRules] --WHERE SSB_CRMSYSTEM_CONTACT_ID= '11435EED-3D92-4503-8753-BEB3582AA02DAS'
as
SELECT SSB_CRMSYSTEM_CONTACT_ID, COUNT(1) Internal_Total_Rec
,COUNT(DISTINCT SourceSystem) Internal_SourceSystem
,COUNT(CASE WHEN sourcesystem = 'RaisersEdge' THEN SSID END) RaisersEdge
,COUNT(CASE WHEN sourcesystem = 'SeniorSystems' THEN SSID END) SeniorSystems
,COUNT(CASE WHEN sourcesystem = 'Schoology' THEN SSID END) Schoology

,COUNT(DISTINCT NULLIF(CONCAT(FirstName, LastName,  Suffix),'')) NameCount_FLS
,COUNT(DISTINCT NULLIF(CONCAT(Prefix,FirstName, MiddleName, LastName,  Suffix),'')) NameCount_FMLPS
,COUNT(DISTINCT NULLIF(Prefix,'')) Prefix
,COUNT(DISTINCT NULLIF(FirstName,'')) FirstName
,COUNT(DISTINCT NULLIF(MiddleName,'')) MiddleName
,COUNT(DISTINCT NULLIF(LastName,'')) LastName
,COUNT(DISTINCT NULLIF(Suffix,'')) Suffix
,COUNT(DISTINCT NULLIF(PhonePrimary,'')) PhonePrimary
,COUNT(DISTINCT NULLIF(PhoneCell,'')) PhoneCell
,COUNT(DISTINCT NULLIF(PhoneHome,'')) PhoneHome
,COUNT(DISTINCT NULLIF(PhoneBusiness,'')) PhoneBusiness
,COUNT(DISTINCT NULLIF(PhoneFax,'')) PhoneFax

,COUNT(DISTINCT NULLIF(CONCAT(AddressPrimaryStreet,AddressPrimaryCity,AddressPrimaryState,AddressPrimaryZip,AddressPrimarySuite),'')) AddressPrimary
,COUNT(DISTINCT NULLIF(CONCAT(AddressOneStreet,AddressOneCity,AddressOneState,AddressOneZip,AddressOneSuite),'')) AddressOne
,COUNT(DISTINCT NULLIF(CONCAT(AddressTwoStreet,AddressTwoCity,AddressTwoState,AddressTwoZip,AddressTwoSuite),'')) AddressTwo
,COUNT(DISTINCT NULLIF(CONCAT(AddressThreeStreet,AddressThreeCity,AddressThreeState,AddressThreeZip,AddressThreeSuite),'')) AddressThree
,COUNT(DISTINCT NULLIF(EmailPrimary,'')) EmailPrimary
,COUNT(DISTINCT NULLIF(EmailOne,'')) EmailOne
,COUNT(DISTINCT NULLIF(Birthday,'')) Birthday
,COUNT(DISTINCT NULLIF(Gender,'')) Gender
,COUNT(DISTINCT NULLIF(a.ExtAttribute1,'')) GradYear
FROM dbo.vwDimCustomer_ModAcctId a
GROUP BY SSB_CRMSYSTEM_CONTACT_ID




GO
