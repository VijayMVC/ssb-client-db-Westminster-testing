CREATE TABLE [src].[BlackBaudFE_budgets]
(
[SK] [bigint] NULL,
[ETL__multi_query_value_for_audit] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[budget-scenario-id] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[description] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[start-fiscal-year] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[end-fiscal-year] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[start-date] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[end-date] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[status] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[budget-type] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[locked] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
