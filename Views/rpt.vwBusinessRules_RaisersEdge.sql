SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW 
[rpt].[vwBusinessRules_RaisersEdge]

AS

 SELECT 
		c.constituent_id	[Constituent ID]
        ,c.Type
        , c.Inactive
        , TRY_CAST(CONCAT(c.birthdate_year,'-',c.birthdate_month,'-',c.birthdate_day) AS DATE) AS [Birthday] 
        , c.gender AS [Gender]
                                       
        , c.fullname  [Full Name]
        , c.Title 
        , c.firstname [First Name]
        , c.middlename	[Middle Name]
        , c.lastname	[Last Name]
        , c.suffix AS [Suffix] 
        , ad.[address_lines]	[Address Lines]
        , ad.city				[Address City]
        , ad.state  			[Address State]
        , ad.postal_code  	[Address Postal]
        , ad.[county] 			[Address County]
        , ad.country  			[Address Country]
        , pho.number		[Phone Number]
        , em.address	[Email Address]
        , class.Class_of	[Class Of]
        , CAST(c.[date_added] AS DATE)	[Date Added]
        , CAST(c.[date_modified] AS DATE)		[Date Modified]

		,cc.description [Consituent Code]
		,CAST(cc.[date_added] AS DATE) [CC Added]
		,cc.inactive	[CC Intactive]

		,r.relation_id [Relation ID]
		,r.name [RelationShip Name]
		,r.type [Relationship Type]
		,r.reciprocal_type [Relationship Reciprocal Type]
		,r.position
		,r.is_spouse
		,r.is_organization_contact
		,r.is_primary_business

		, ssb.SSB_CRMSYSTEM_CONTACT_ID
FROM ODS.BlackBaud_constituents   c
JOIN dbo.dimcustomerssbid ssb ON c.constituent_id = ssb.SSID AND ssb.SourceSystem = 'RaisersEdge'
LEFT JOIN  ODS.BlackBaud_addresses ad
	ON c.address_id    = ad.address_id
LEFT JOIN  ODS.BlackBaud_emailaddresses em
	ON c.email_id    = em.Email_id
LEFT JOIN  ODS.BlackBaud_phones pho
	ON c.phone_id    = pho.Phoneid  
LEFT JOIN 
	(SELECT constituent_id, MAX(class_of) Class_of FROM [ods].[BlackBaud_education] WHERE school = 'Westminster Schools'  GROUP BY constituent_id) class
		ON c.constituent_id = class.constituent_id
LEFT JOIN ods.BlackBaud_constituentcodes cc
	ON c.constituent_id = cc.[constituent_id]
LEFT JOIN ods.BlackBaud_relationships r
	ON c.constituent_id = r.constituent_id



GO
