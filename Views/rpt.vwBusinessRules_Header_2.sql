SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [rpt].[vwBusinessRules_Header_2]
AS

SELECT 
a.SSB_CRMSYSTEM_CONTACT_ID
,a.SourceSystem Winning_source
,a.FirstName
,a.MiddleName
,a.LastName
,a.Prefix
,a.Suffix
,a.PhonePrimary
,a.PhoneCell
,a.PhoneHome
,a.PhoneBusiness
,a.PhoneFax
,CONCAT(a.AddressPrimaryStreet,' ', a.AddressPrimaryCity,' ', a.AddressPrimaryState,' ', a.AddressPrimaryZip,' ', a.AddressPrimarySuite) AddressPrimary
,CONCAT(a.AddressOneStreet,' ', a.AddressOneCity,' ', a.AddressOneState,' ', a.AddressOneZip,' ', a.AddressOneSuite) AddressOne
,CONCAT(a.AddressTwoStreet,' ', a.AddressTwoCity,' ', a.AddressTwoState,' ', a.AddressTwoZip,' ', a.AddressTwoSuite) AddressTwo
,CONCAT(a.AddressThreeStreet,' ', a.AddressThreeCity,' ', a.AddressThreeState,' ', a.AddressThreeZip,' ', a.AddressThreeSuite) AddressThree
,a.EmailPrimary
,a.EmailOne
,a.EmailTwo
,a.Birthday
,a.Gender
,d.Total_Weight
,c.BusinessRule
,c.BR_Weight
FROM dbo.vwCompositeRecord_ModAcctID a 
--INNER JOIN rpt.DimCustomerBucketing_v0 b
--	ON a.SSB_CRMSYSTEM_CONTACT_ID = b.SSB_CRMSYSTEM_CONTACT_ID
LEFT JOIN rpt.BusinessRulesBucketsOutput  c
	ON a.SSB_CRMSYSTEM_CONTACT_ID = c.SSB_CRMSYSTEM_CONTACT_ID
LEFT OUTER JOIN (SELECT SSB_CRMSYSTEM_CONTACT_ID, SUM(BR_Weight) Total_Weight FROM rpt.BusinessRulesBucketsOutput GROUP BY SSB_CRMSYSTEM_CONTACT_ID) d
	ON a.SSB_CRMSYSTEM_CONTACT_ID = d.SSB_CRMSYSTEM_CONTACT_ID

	--ORDER BY d.Total_Weight DESC 


	--SELECT DISTINCT businessrule
	--FROM rpt.BusinessRulesBucketsOutput 

GO
