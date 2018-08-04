CREATE TABLE [ods].[Snapshot_BlackBaudFE_budgets_projects]
(
[BlackBaudFE_budgets_projectsSK] [int] NOT NULL IDENTITY(1, 1),
[Budget_scenario_ID] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[budget_category] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[account_number] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ui_project_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fiscal_year] [nvarchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[total_amount] [float] NULL,
[fiscal_period] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[period_amount] [float] NULL,
[period_percent] [float] NULL,
[ETL_CreatedOn] [datetime] NULL,
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_UpdatedOn] [datetime] NULL,
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RecordEndDate] [datetime] NULL
)
GO
ALTER TABLE [ods].[Snapshot_BlackBaudFE_budgets_projects] ADD CONSTRAINT [PK__Snapshot__378EC3F628E839D6] PRIMARY KEY CLUSTERED  ([BlackBaudFE_budgets_projectsSK])
GO
