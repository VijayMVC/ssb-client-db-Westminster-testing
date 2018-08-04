SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [preODS].[BlackBaudFE_accounts_account_CustomFields]
AS

SELECT DISTINCT
	CONVERT(NVARCHAR(50),[Account-id]) [Account_id]
	,CONVERT(NVARCHAR(50),[custom-fields_custom-field-id]) [custom_fields_custom_field_id_K]
	,CONVERT(NVARCHAR(500),[custom-fields_field-name]) [custom_fields_field_name]
	,CONVERT(NVARCHAR(500),[custom-fields_value]) [custom_fields_value]
	,CONVERT(NVARCHAR(MAX),[custom-fields_comments]) [custom_fields_comments]
	,CONVERT(NVARCHAR(50),[custom-fields_type]) [custom_fields_type]
	,CONVERT(NVARCHAR(50),[custom-fields_date]) [custom_fields_date]
FROM [src].[BlackBaudFE_accounts_account] WITH (NOLOCK)
where [custom-fields_custom-field-id] IS NOT NULL

GO
