SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE 
VIEW [rpt].[vwBusinessRules_Child] 
AS

SELECT 
a.SSB_CRMSYSTEM_CONTACT_ID
,a.SourceSystem [Source System]
,A.SSID
,a.FirstName	[First Name]
,a.MiddleName	[Middle Name]
,a.LastName		[Last Name]
,a.Prefix
,a.Suffix
,a.FullName		[Full Name]
,a.PhonePrimary	[Phone Primary]
,a.PhoneCell	[Phone Cell]
,a.PhoneHome	[Phone Home]
,a.PhoneBusiness	[Phone Business]
,a.PhoneFax		[Phone Fax]
,CONCAT(a.AddressPrimaryStreet,' ', a.AddressPrimaryCity,' ', a.AddressPrimaryState,' ', a.AddressPrimaryZip,' ', a.AddressPrimarySuite) [Address Primary]
,a.AddressPrimaryNCOAStatus [Address Primary NCOA Status]
,CONCAT(a.AddressOneStreet,' ', a.AddressOneCity,' ', a.AddressOneState,' ', a.AddressOneZip,' ', a.AddressOneSuite) [Address One]
,CONCAT(a.AddressTwoStreet,' ', a.AddressTwoCity,' ', a.AddressTwoState,' ', a.AddressTwoZip,' ', a.AddressTwoSuite) [Address Two]
,CONCAT(a.AddressThreeStreet,' ', a.AddressThreeCity,' ', a.AddressThreeState,' ', a.AddressThreeZip,' ', a.AddressThreeSuite) [Address Three]
,a.EmailPrimary	[Email Primary]
,a.EmailOne		[Email One]
,a.EmailTwo		[Email Two]
,a.Birthday
,a.Gender	
,a.ExtAttribute1 [Grad Year]
FROM dbo.vwDimCustomer_ModAcctId a 




GO
