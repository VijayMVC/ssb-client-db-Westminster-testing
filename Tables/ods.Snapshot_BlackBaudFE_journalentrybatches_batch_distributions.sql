CREATE TABLE [ods].[Snapshot_BlackBaudFE_journalentrybatches_batch_distributions]
(
[BlackBaudFE_journalentrybatches_batch_distributionsSK] [int] NOT NULL IDENTITY(1, 1),
[journal_entry_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[distribution_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[distributions_ui_project_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[distributions_account_class] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[distributions_amount] [float] NULL,
[distributions_percent] [float] NULL,
[distributions_transaction_code_values_name] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[distributions_transaction_code_values_value] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_CreatedOn] [datetime] NULL,
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_UpdatedOn] [datetime] NULL,
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RecordEndDate] [datetime] NULL
)
GO
ALTER TABLE [ods].[Snapshot_BlackBaudFE_journalentrybatches_batch_distributions] ADD CONSTRAINT [PK__Snapshot__4786283691A7B155] PRIMARY KEY CLUSTERED  ([BlackBaudFE_journalentrybatches_batch_distributionsSK])
GO
