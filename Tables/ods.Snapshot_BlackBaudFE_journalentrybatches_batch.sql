CREATE TABLE [ods].[Snapshot_BlackBaudFE_journalentrybatches_batch]
(
[BlackBaudFE_journalentrybatches_batchSK] [int] NOT NULL IDENTITY(1, 1),
[journal_entry_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[batch_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ui_batch_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[type_code] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[line_number] [int] NULL,
[account_number] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[post_date] [datetime2] NULL,
[encumbrance] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[journal] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[reference] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[amount] [float] NULL,
[notes] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_CreatedOn] [datetime] NULL,
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_UpdatedOn] [datetime] NULL,
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RecordEndDate] [datetime] NULL
)
GO
ALTER TABLE [ods].[Snapshot_BlackBaudFE_journalentrybatches_batch] ADD CONSTRAINT [PK__Snapshot__359ACBF4B95CA0DD] PRIMARY KEY CLUSTERED  ([BlackBaudFE_journalentrybatches_batchSK])
GO
