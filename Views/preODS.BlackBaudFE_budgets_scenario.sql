SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [preODS].[BlackBaudFE_budgets_scenario]
AS

SELECT DISTINCT
	CONVERT(NVARCHAR(50),[ETL__multi_query_value_for_audit]) Budget_Scenario_ID_K
	,CONVERT(NVARCHAR(50),[fiscal-year]) [fiscal_year_K]
	,CONVERT(NVARCHAR(10),[fiscal-period]) [fiscal_period_K]
	,CONVERT(NVARCHAR(50),[category]) [category_K]	
	,CONVERT(float,[total-amount]) [total_amount]	
	,CONVERT(float,[period-amount]) [period_amount]
FROM [src].[BlackBaudFE_budgets_scenario] WITH (NOLOCK)
GO
