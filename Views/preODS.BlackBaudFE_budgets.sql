SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [preODS].[BlackBaudFE_budgets]
AS

SELECT DISTINCT
	CONVERT(NVARCHAR(50),[budget-scenario-id]) [budget_scenario_id_K]
	,CONVERT(NVARCHAR(MAX),[description]) [description]
	,CONVERT(NVARCHAR(10),[start-fiscal-year]) [start-fiscal-year]
	,CONVERT(NVARCHAR(10),[end-fiscal-year]) [end-fiscal-year]
	,CONVERT(datetime2,[start-date]) [start-date]
	,CONVERT(datetime2,[end-date]) [end-date]
	,CONVERT(NVARCHAR(25),[status]) [status]
	,CONVERT(NVARCHAR(50),[budget-type]) [budget-type]
	,CONVERT(NVARCHAR(10),[locked]) [locked]
FROM [src].[BlackBaudFE_budgets] WITH (NOLOCK)
GO
