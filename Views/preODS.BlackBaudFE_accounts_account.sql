SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [preODS].[BlackBaudFE_accounts_account]
AS

SELECT 
	CONVERT(NVARCHAR(50),[Account-id]) [Account_id_K]
	,CONVERT(NVARCHAR(50),[account-number]) [account_number]
	,CONVERT(NVARCHAR(500),[description]) [description]
	,CONVERT(NVARCHAR(10),[prevent-data-entry]) [prevent_data_entry]
	,CONVERT(NVARCHAR(50),[prevent-posting-date]) [prevent_posting_date]
	,CONVERT(NVARCHAR(100),[class]) [class]
	,CONVERT(NVARCHAR(500),[cashflow]) [cashflow]
	,CONVERT(NVARCHAR(50),[working-capital]) [working_capital]
	--,CONVERT(NVARCHAR(MAX),[custom-fields_]) [custom_fields_]
	--,CONVERT(NVARCHAR(MAX),[custom-fields_custom-field-id]) [custom_fields_custom_field_id]
	--,CONVERT(NVARCHAR(MAX),[custom-fields_field-name]) [custom_fields_field_name]
	--,CONVERT(NVARCHAR(MAX),[custom-fields_value]) [custom_fields_value]
	--,CONVERT(NVARCHAR(MAX),[custom-fields_comments]) [custom_fields_comments]
	--,CONVERT(NVARCHAR(MAX),[custom-fields_type]) [custom_fields_type]
	--,CONVERT(NVARCHAR(MAX),[custom-fields_date]) [custom_fields_date]
	,MAX(CONVERT(NVARCHAR(250),[default-transaction-codes_name])) [default_transaction_codes_name]
	,MAX(CONVERT(NVARCHAR(250),[default-transaction-codes_value])) [default_transaction_codes_value]
FROM [src].[BlackBaudFE_accounts_account] WITH (NOLOCK)
GROUP BY
	CONVERT(NVARCHAR(50),[Account-id])
	,CONVERT(NVARCHAR(50),[account-number])
	,CONVERT(NVARCHAR(500),[description])
	,CONVERT(NVARCHAR(10),[prevent-data-entry])
	,CONVERT(NVARCHAR(50),[prevent-posting-date])
	,CONVERT(NVARCHAR(100),[class]) 
	,CONVERT(NVARCHAR(500),[cashflow])
	,CONVERT(NVARCHAR(50),[working-capital])
GO
