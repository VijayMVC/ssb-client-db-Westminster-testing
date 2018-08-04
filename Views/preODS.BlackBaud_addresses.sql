SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [preODS].[BlackBaud_addresses]
AS

SELECT DISTINCT
	CONVERT(NVARCHAR(50),[Address_id]) [address_id_K]
	,CONVERT(NVARCHAR(50),[constituent_id]) [constituent_id]
	,CONVERT(NVARCHAR(50),[type]) [type]
	,CONVERT(NVARCHAR(max),[formatted-address]) [formatted_address]
	,CONVERT(NVARCHAR(10),[preferred]) [preferred]
	,CONVERT(NVARCHAR(10),[inactive]) [inactive]
	,CONVERT(NVARCHAR(10),[do-not-mail]) [do_not_mail]
	,CONVERT(NVARCHAR(2000),[address-lines]) [address_lines]
	,CONVERT(NVARCHAR(250),[city]) [city]
	,CONVERT(datetime2,[date-added]) [date_added]
	,CONVERT(datetime2,[date-modified]) [date_modified]
	,CONVERT(NVARCHAR(50),[state]) [state]
	,CONVERT(NVARCHAR(50),[postal-code]) [postal_code]
	,CONVERT(NVARCHAR(100),[county]) [county]
	,CONVERT(NVARCHAR(100),[country]) [country]
FROM [src].[BlackBaud_addresses] WITH (NOLOCK)

GO
