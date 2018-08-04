SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE VIEW 
[rpt].[vwBusinessRules_SeniorSystems]

AS

SELECT DISTINCT
       p.EntityNo	[Entity No]
        , p.IsParent
		, p.IsFaculty
		, p.IsStudent
		, CASE WHEN p.IsParent = 'true' THEN 'Parent'
									WHEN p.IsFaculty = 'true' THEN 'Faculty'
									WHEN p.IsStudent = 'true' THEN 'Student'
									ELSE 'Other' END Type
		, p.Birthdate                   
        , p.FullName	[Full Name]
        , p.Title
        , p.FirstName	[First Name]
        , p.MiddleName	[Middle Name]
        , p.LastName		[Last Name]
        , p.Suffix
		, p.ConstituentClassYr	[Class Yr]
		, p.FamilyID
		, p.HouseholdID
		, p.ParentType
		, p.ParentNameGroup

		, res.AddressNumber				[AddressNumber]
		, res.AddressCode				[AddressCode]
		, res.Address1					[Address1]		
		, res.Address2					[Address2]
		, res.Address3					[Address3]
        , res.City						[City]
        , res.State						[State]
        , res.Zip						[Zip]
        , res.Country					[Country]
        , res.Phone						[Phone]
        , res.OtherNumber1				[Other Number1]
        , res.OtherNumber2				[Other Number2]
        , res.OtherNumber3				[Other Number3]
        , res.OtherNumber4 				[Other Number4]
		, res.Email1					[Email1]
		, res.Email2					[Email2]
		, CASE WHEN ad.AddressNumber = res.AddressNumber THEN 1 ELSE 0 END [SSb Primary Address]				

		, rel.StudentId
		, pp.FullName AS [Student Name]
		, rel.Relationship
		

		, ssb.SSB_CRMSYSTEM_CONTACT_ID
FROM [ods].[SeniorSystems_persons] p
JOIN dbo.dimcustomerssbid ssb ON p.EntityNo = ssb.SSID AND ssb.SourceSystem = 'SeniorSystems'
LEFT JOIN (SELECT *, ROW_NUMBER() OVER(PARTITION BY entityno ORDER BY isactive DESC
				, CASE AddressCode WHEN 'Faculty Primary' THEN 1 WHEN 'Residential' THEN 2 WHEN 'Work' THEN 3 WHEN 'Other' THEN 4 WHEN 'Additional Contact' THEN 5 ELSE 6 END
				,LEN(address1) DESC) RN   FROM ods.SeniorSystems_persons_address) ad
	ON p.EntityNo = ad.EntityNo
	AND rn=1
LEFT JOIN ods.SeniorSystems_persons_address res
	ON p.EntityNo = res.EntityNo
LEFT JOIN [ods].[SeniorSystems_persons_Relationships] rel
	ON p.EntityNo = rel.EntityNo
LEFT JOIN [ods].[SeniorSystems_persons] pp
	ON rel.StudentEntityNo = pp.EntityNo

GO
