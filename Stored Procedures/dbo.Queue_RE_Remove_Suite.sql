SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE PROC [dbo].[Queue_RE_Remove_Suite]
	@IssueID	INT 
AS
-- [Queue_RE_Remove_Suite] 6514

DECLARE @AddressPrimaryStreet		 VARCHAR(1000)
DECLARE @city						 VARCHAR(400)
DECLARE @state						 VARCHAR(400)
DECLARE @county						 VARCHAR(400)
DECLARE @zipcode					 VARCHAR(50)
DECLARE @Country					 VARCHAR(400)
DECLARE @SourceID					 VARCHAR(50)
DECLARE @type						 VARCHAR(50)
DECLARE @do_not_mail					 VARCHAR(10)

SELECT
	@AddressPrimaryStreet = dc.AddressPrimaryStreet  
	,@city = dc.AddressPrimaryCity
	,@state = ISNULL(dc.AddressPrimaryState, ad.state)
	,@Country = ISNULL(dc.AddressPrimaryCountry, ad.country)
	,@county = ISNULL(dc.AddressPrimaryCounty, ad.county)
	,@zipcode = ISNULL(dc.AddressPrimaryZip, ad.postal_code)
	,@SourceID =  bc.address_id 
	,@type = ad.type
	,@do_not_mail = ad.do_not_mail
FROM dbo.BizRule_Issues i
JOIN dbo.DimCustomer dc ON i.OtherID = dc.DimCustomerId
JOIN ods.BlackBaud_constituents bc ON bc.constituent_id = i.Constituent_ID
JOIN ods.BlackBaud_addresses ad ON bc.address_id = ad.address_id
WHERE i.IssueID = @IssueID



SELECT  'RaisersEdge' APIName, 'Constituent' APIEntity, 'Addresses' EndpointName,''--' @SourceID 
				,( SELECT 
						@type [type]
						,'true' [preferred]
						, @do_not_mail [do_not_mail]
						, @AddressPrimaryStreet [address_lines]
						, @city [city]
						, @state [state]
						, @zipcode [postal_code]
						, CASE WHEN @Country = 'US' THEN 'United States' ELSE @Country END [country]
				FOR JSON PATH, WITHOUT_ARRAY_WRAPPER) json_payload
	,'post' htmlAction 
	,'Remove Address Suite -- add new preferred address' Description
	,@IssueID




SELECT  'RaisersEdge' APIName, 'Constituent' APIEntity, 'Addresses' EndpointName, @SourceID 
				,( SELECT 
						CASE WHEN @type = 'Home' THEN 'Former Home' ELSE @type END type
						,CAST(CAST(GETDATE() - 1 AS DATE) AS DATETIME2) [end] 
				FOR JSON PATH, WITHOUT_ARRAY_WRAPPER) json_payload
	,'patch' htmlAction 
	,'Remove Address Suite -- update old address' Description
	,@IssueID


GO
