CREATE TABLE [ods].[Snapshot_BlackBaudFE_budgets_scenario]
(
[BlackBaudFE_budgets_scenarioSK] [int] NOT NULL IDENTITY(1, 1),
[Budget_Scenario_ID] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fiscal_year] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fiscal_period] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[category] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[total_amount] [float] NULL,
[period_amount] [float] NULL,
[ETL_CreatedOn] [datetime] NULL,
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_UpdatedOn] [datetime] NULL,
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RecordEndDate] [datetime] NULL
)
GO
ALTER TABLE [ods].[Snapshot_BlackBaudFE_budgets_scenario] ADD CONSTRAINT [PK__Snapshot__239A04580CFD1E26] PRIMARY KEY CLUSTERED  ([BlackBaudFE_budgets_scenarioSK])
GO
