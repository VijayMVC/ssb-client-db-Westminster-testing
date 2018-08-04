SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




CREATE PROC [dbo].[Queue_RE_Address]
	@IssueID	INT 
AS
-- [Queue_RE_Address] 11786

DECLARE @AddressPrimaryStreet		 VARCHAR(1000)
DECLARE @city						 VARCHAR(400)
DECLARE @state						 VARCHAR(400)
DECLARE @county						 VARCHAR(400)
DECLARE @zipcode					 VARCHAR(50)
DECLARE @Country					 VARCHAR(400)
DECLARE @SourceID					 VARCHAR(50)
DECLARE @type						 VARCHAR(50)
DECLARE @constituentID					 VARCHAR(10)

SELECT
	@AddressPrimaryStreet = dc.AddressPrimaryStreet  
	,@city = dc.AddressPrimaryCity
	,@state = dc.AddressPrimaryState
	,@Country = dc.AddressPrimaryCountry
	,@county = dc.AddressPrimaryCounty
	,@zipcode = dc.AddressPrimaryZip
	,@SourceID =  con.address_id
	,@type = ad.type
	,@constituentID = con.constituent_id
FROM dbo.BizRule_Issues i
JOIN dbo.DimCustomer dc ON i.EntityNo =dc.SSID AND dc.SourceSystem = 'SeniorSystems'
JOIN dbo.dimcustomerssbid ssb ON dc.DimCustomerId = ssb.DimCustomerId
JOIN dbo.dimcustomerssbid ssb2 ON ssb.SSB_CRMSYSTEM_CONTACT_ID = ssb2.SSB_CRMSYSTEM_CONTACT_ID AND ssb2.SourceSystem = 'RaisersEdge'
LEFT JOIN ods.BlackBaud_constituents con ON ssb2.SSID = con.constituent_id 
LEFT JOIN ods.BlackBaud_addresses ad ON ad.address_id = con.address_id
WHERE i.IssueID = @IssueID



SELECT  'RaisersEdge' APIName, 'Constituent' APIEntity, 'Addresses' EndpointName,''--' @SourceID 
				,( SELECT 
						@constituentID [constituent_id]
						,CASE WHEN @type = 'Former Home' THEN 'Home' ELSE @type END [type]
						,'true' [preferred]
						, @AddressPrimaryStreet [address_lines]
						, @city [city]
						, @state [state]
						, @zipcode [postal_code]
						, CASE WHEN @Country = 'US' THEN 'United States' ELSE @Country END [country]
				FOR JSON PATH, WITHOUT_ARRAY_WRAPPER) json_payload
	,'post' httpAction 
	,'Add new preferred address' Description
	,@IssueID



IF @SourceID IS NOT NULL
BEGIN
SELECT  'RaisersEdge' APIName, 'Constituent' APIEntity, 'Addresses' EndpointName, @SourceID 
				,( SELECT 
						CASE WHEN @type = 'Home' THEN 'Former Home' ELSE @type END type
						,CAST(CAST(GETDATE() - 1 AS DATE) AS DATETIME2) [end] 
						,address_lines
						,city
						,ISNULL(country,'United States') country
						,county
						,do_not_mail
						,postal_code
						,state
						FROM ods.BlackBaud_addresses WHERE address_id  = @SourceID
				FOR JSON PATH, WITHOUT_ARRAY_WRAPPER) json_payload
	,'patch' htmlAction 
	,'Update old address' Description
	,@IssueID
END


GO
