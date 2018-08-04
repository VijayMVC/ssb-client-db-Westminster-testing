SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [preODS].[BlackBaudFE_budgets_projects]
AS

SELECT DISTINCT
	CONVERT(NVARCHAR(50),[ETL__multi_query_value_for_audit]) Budget_scenario_ID_K
	,CONVERT(NVARCHAR(50),[budget-category]) [budget_category_K]
	,CONVERT(NVARCHAR(50),[account-number]) [account_number_K]
	,CONVERT(NVARCHAR(50),[ui-project-id]) [ui_project_id_K]
	,CONVERT(NVARCHAR(25),[fiscal-year]) [fiscal_year_K]
	,CONVERT(float,[total-amount]) [total_amount]
	,CONVERT(NVARCHAR(10),[fiscal-period]) [fiscal_period_K]
	,CONVERT(float,[period-amount]) [period_amount]
	,CONVERT(float,[period-percent]) [period_percent]
FROM [src].[BlackBaudFE_budgets_projects] WITH (NOLOCK)
GO
