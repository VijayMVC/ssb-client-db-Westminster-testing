SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

--SELECT * FROM [rpt].[vwBusinessRules_Header]
CREATE VIEW [rpt].[vwBusinessRules_Header]
AS

SELECT 
a.SSB_CRMSYSTEM_CONTACT_ID
,a.SourceSystem [Winning Source]
,a.FirstName [First Name]
,a.MiddleName [Middle Name]
,a.LastName [Last Name]
,a.Prefix
,a.Suffix
,a.FullName [Full Name]
,a.PhonePrimary [Phone Primary]
,a.PhoneCell	[Phone Cell]
,a.PhoneHome	[Phone Home]
,a.PhoneBusiness	[Phone Business]
,a.PhoneFax	[Phone Fax]
,CONCAT(a.AddressPrimaryStreet,' ', a.AddressPrimaryCity,' ', a.AddressPrimaryState,' ', a.AddressPrimaryZip,' ', a.AddressPrimarySuite) [Address Primary]
--,a.AddressPrimaryNCOAStatus
,CONCAT(a.AddressOneStreet,' ', a.AddressOneCity,' ', a.AddressOneState,' ', a.AddressOneZip,' ', a.AddressOneSuite) [Address One]
,CONCAT(a.AddressTwoStreet,' ', a.AddressTwoCity,' ', a.AddressTwoState,' ', a.AddressTwoZip,' ', a.AddressTwoSuite) [Address Two]
,CONCAT(a.AddressThreeStreet,' ', a.AddressThreeCity,' ', a.AddressThreeState,' ', a.AddressThreeZip,' ', a.AddressThreeSuite) [Address Three]
,a.EmailPrimary	[Email Primary]
,a.EmailOne	[Email One]
,a.EmailTwo	[Email Two]
,a.Birthday
,a.Gender
,a.ExtAttribute1 [Grad Year]
,d.Total_Weight AS  [Non Matching Score]
,c.[RaisersEdge]		  AS 			[RaisersEdge NumIssue]	
,c.[SeniorSystems]		  AS 			[SeniorSystems NumIssue]	
,c.[Schoology]			  AS 			[Schoology NumIssue]		
,c.[NameCount_FLS]		  AS 			[First Last Suffix NumIssue]	
,c.[NameCount_FMLPS]	  AS 			[NameCount FMLPS NumIssue]
,c.[FirstName]			  AS 			[First Name NumIssue]		
,c.[MiddleName]			  AS 			[Middle Name NumIssue]		
,c.[LastName]			  AS 			[Last Name NumIssue]		
,c.[Prefix]				  AS 			[Prefix NumIssue]			
,c.[Suffix]				  AS 			[Suffix NumIssue]			
,c.[Gender]				  AS 			[Gender NumIssue]			
,c.[Birthday]			  AS 			[Birthday NumIssue]		
,c.[AddressPrimary]		  AS 			[Address Primary NumIssue]	
,c.[EmailPrimary]		  AS 			[Email Primary NumIssue]	
,c.[EmailOne]			  AS 			[Email One NumIssue]		
,c.[EmailTwo]			  AS 			[Email Two NumIssue]		
,c.[PhonePrimary]		  AS 			[Phone Primary NumIssue]	
,c.[PhoneCell]			  AS 			[Phone Cell NumIssue]		
,c.[PhoneHome]			  AS 			[Phone Home NumIssue]		
,c.[PhoneBusiness]		  AS 			[PhoneB usiness NumIssue]	
,c.[PhoneFax]			  AS 			[Phone Fax NumIssue]	
,c.[GradYear]			  AS			[Grad Year NumIssue]	
, CASE WHEN ISNULL(d.Total_Weight,0) = 0 THEN 'Clean' 
WHEN d.Total_Weight < 101 THEN 'Low' WHEN d.Total_Weight < 201 THEN 'Medium' ELSE 'High' END [Non Matching Bucket]
FROM dbo.vwCompositeRecord_ModAcctID a 
--INNER JOIN rpt.DimCustomerBucketing_v0 b
--	ON a.SSB_CRMSYSTEM_CONTACT_ID = b.SSB_CRMSYSTEM_CONTACT_ID
LEFT JOIN
		(SELECT *
		FROM
		(SELECT SSB_CRMSYSTEM_CONTACT_ID, BusinessRule, BR_Count
			FROM rpt.BusinessRulesBucketsOutput ) AS SourceTable
		PIVOT
		(
		MAX(BR_Count)
		FOR BusinessRule IN (
		[RaisersEdge]
		,[SeniorSystems]
		,[Schoology]
		,[NameCount_FLS]
		,[NameCount_FMLPS]
		,[FirstName]
		,[MiddleName]
		,[LastName]
		,[Prefix]		
		,[Suffix]
		,[Gender]
		,[Birthday]
		,[AddressPrimary]
		,[EmailPrimary]		
		,[EmailOne]
		,[EmailTwo]
		,[PhonePrimary]
		,[PhoneCell]
		,[PhoneHome]
		,[PhoneBusiness]		
		,[PhoneFax]
		,[GradYear])
		) AS PivotTable
		) c
	ON a.SSB_CRMSYSTEM_CONTACT_ID = c.SSB_CRMSYSTEM_CONTACT_ID
LEFT OUTER JOIN (SELECT SSB_CRMSYSTEM_CONTACT_ID, SUM(BR_Weight) Total_Weight FROM rpt.BusinessRulesBucketsOutput GROUP BY SSB_CRMSYSTEM_CONTACT_ID) d
	ON a.SSB_CRMSYSTEM_CONTACT_ID = d.SSB_CRMSYSTEM_CONTACT_ID

	--ORDER BY d.Total_Weight DESC 


	--SELECT DISTINCT businessrule
	--FROM rpt.BusinessRulesBucketsOutput 



GO
