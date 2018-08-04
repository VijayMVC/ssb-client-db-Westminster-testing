SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




CREATE VIEW [preODS].[BlackBaud_constituents_address]
AS

SELECT DISTINCT
	CONVERT(NVARCHAR(50),[address_id]) [address_id_k]
	,CONVERT(NVARCHAR(50),[constituent_id]) [constituent_id]
	,CONVERT(NVARCHAR(20),[address_type]) [address_type]
	,CONVERT(NVARCHAR(500),[address_formatted-address]) [address_formatted_address]
	,CONVERT(NVARCHAR(10),[address_preferred]) [address_preferred]
	,CONVERT(NVARCHAR(10),[address_do-not-mail]) [address_do_not_mail]
	,CONVERT(NVARCHAR(500),[address_address-lines]) [address_address_lines]
	,CONVERT(NVARCHAR(100),[address_city]) [address_city]
	,CONVERT(NVARCHAR(100),[address_state]) [address_state]
	,CONVERT(NVARCHAR(50),[address_postal-code]) [address_postal_code]
	,CONVERT(NVARCHAR(50),[address_county]) [address_county]
	,CONVERT(NVARCHAR(50),[address_country]) [address_country]
FROM [src].[BlackBaud_constituents_address] WITH (NOLOCK)
WHERE [address_id] IS NOT NULL



GO
