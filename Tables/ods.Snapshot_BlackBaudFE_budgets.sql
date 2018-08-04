CREATE TABLE [ods].[Snapshot_BlackBaudFE_budgets]
(
[BlackBaudFE_budgetsSK] [int] NOT NULL IDENTITY(1, 1),
[budget_scenario_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[description] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[start-fiscal-year] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[end-fiscal-year] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[start-date] [datetime2] NULL,
[end-date] [datetime2] NULL,
[status] [nvarchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[budget-type] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[locked] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_CreatedOn] [datetime] NULL,
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_UpdatedOn] [datetime] NULL,
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RecordEndDate] [datetime] NULL
)
GO
ALTER TABLE [ods].[Snapshot_BlackBaudFE_budgets] ADD CONSTRAINT [PK__Snapshot__788EC059BFB4DB4D] PRIMARY KEY CLUSTERED  ([BlackBaudFE_budgetsSK])
GO
