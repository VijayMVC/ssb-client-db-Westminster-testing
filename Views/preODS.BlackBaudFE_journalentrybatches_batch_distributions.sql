SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [preODS].[BlackBaudFE_journalentrybatches_batch_distributions]
AS

SELECT DISTINCT
	 CONVERT(NVARCHAR(50),[journal-entry-id]) [journal_entry_id]
	,CONVERT(NVARCHAR(50),[distributions_distribution-id]) [distribution_id_K]
	,CONVERT(NVARCHAR(50),[distributions_ui-project-id]) [distributions_ui_project_id]
	,CONVERT(NVARCHAR(250),[distributions_account-class]) [distributions_account_class]
	,CONVERT(float,[distributions_amount]) [distributions_amount]
	,CONVERT(float,[distributions_percent]) [distributions_percent]
	,MAX(CONVERT(NVARCHAR(100),[distributions_transaction-code-values_name])) [distributions_transaction_code_values_name]
	,MAX(CONVERT(NVARCHAR(250),[distributions_transaction-code-values_value])) [distributions_transaction_code_values_value]
FROM [src].[BlackBaudFE_journalentrybatches_batch] WITH (NOLOCK)
where [distributions_distribution-id] is not null
GROUP BY 
	CONVERT(NVARCHAR(50),[journal-entry-id]) 
	,CONVERT(NVARCHAR(50),[distributions_distribution-id]) 
	,CONVERT(NVARCHAR(50),[distributions_ui-project-id]) 
	,CONVERT(NVARCHAR(250),[distributions_account-class]) 
	,CONVERT(float,[distributions_amount]) 
	,CONVERT(float,[distributions_percent])
GO
