CREATE TABLE [src].[BlackBaudFE_budgets_projects]
(
[SK] [bigint] NULL,
[ETL__multi_query_value_for_audit] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[budget-category] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[account-number] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ui-project-id] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fiscal-year] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[total-amount] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fiscal-period] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[period-amount] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[period-percent] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
