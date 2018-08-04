SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [preODS].[BlackBaudFE_journalentrybatches_batch]
AS

SELECT DISTINCT
	 CONVERT(NVARCHAR(50),ISNULL([journal-entry-id],CONCAT([batch-id],'-Deleted'))) [journal_entry_id_K]
	,CONVERT(NVARCHAR(50),[batch-id]) [batch_id]
	,CONVERT(NVARCHAR(50),[ui-batch-id]) [ui_batch_id]
	,CONVERT(NVARCHAR(50),[type-code]) [type_code]
	,CONVERT(INT,[line-number]) [line_number]
	,CONVERT(NVARCHAR(50),[account-number]) [account_number]
	,CONVERT(DATETIME2,[post-date]) [post_date]
	,CONVERT(NVARCHAR(50),[encumbrance]) [encumbrance]
	,CONVERT(NVARCHAR(50),[journal]) [journal]
	,CONVERT(NVARCHAR(MAX),[reference]) [reference]
	,CONVERT(FLOAT,[amount]) [amount]
	,CONVERT(NVARCHAR(MAX),[notes]) [notes]
	--,CONVERT(NVARCHAR(MAX),[distributions_]) [distributions_]
	--,CONVERT(NVARCHAR(MAX),[distributions_distribution-id]) [distributions_distribution_id]
	--,CONVERT(NVARCHAR(MAX),[distributions_ui-project-id]) [distributions_ui_project_id]
	--,CONVERT(NVARCHAR(MAX),[distributions_account-class]) [distributions_account_class]
	--,CONVERT(NVARCHAR(MAX),[distributions_amount]) [distributions_amount]
	--,CONVERT(NVARCHAR(MAX),[distributions_percent]) [distributions_percent]
	--,CONVERT(NVARCHAR(MAX),[custom-fields_custom-field-id]) [custom_fields_custom_field_id]
	--,CONVERT(NVARCHAR(MAX),[custom-fields_field-name]) [custom_fields_field_name]
	--,CONVERT(NVARCHAR(MAX),[custom-fields_value]) [custom_fields_value]
	--,CONVERT(NVARCHAR(MAX),[custom-fields_comments]) [custom_fields_comments]
	--,CONVERT(NVARCHAR(MAX),[custom-fields_type]) [custom_fields_type]
	--,CONVERT(NVARCHAR(MAX),[custom-fields_date]) [custom_fields_date]
	--,CONVERT(NVARCHAR(MAX),[distributions_transaction-code-values_]) [distributions_transaction_code_values_]
	--,CONVERT(NVARCHAR(MAX),[distributions_transaction-code-values_name]) [distributions_transaction_code_values_name]
	--,CONVERT(NVARCHAR(MAX),[distributions_transaction-code-values_value]) [distributions_transaction_code_values_value]
FROM [src].[BlackBaudFE_journalentrybatches_batch] WITH (NOLOCK)
--WHERE [journal-entry-id] IS null

GO
