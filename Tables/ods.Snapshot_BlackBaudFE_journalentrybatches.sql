CREATE TABLE [ods].[Snapshot_BlackBaudFE_journalentrybatches]
(
[BlackBaudFE_journalentrybatchesSK] [int] NOT NULL IDENTITY(1, 1),
[batch_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ui_batch_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[description] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[batch-status] [nvarchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[create_interfund_sets] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[create_bank_account_adjustments] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[date_added] [datetime2] NULL,
[added_by] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[date_modified] [datetime2] NULL,
[modified_by] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_CreatedOn] [datetime] NULL,
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_UpdatedOn] [datetime] NULL,
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RecordEndDate] [datetime] NULL
)
GO
ALTER TABLE [ods].[Snapshot_BlackBaudFE_journalentrybatches] ADD CONSTRAINT [PK__Snapshot__42E52D5F56BC9A99] PRIMARY KEY CLUSTERED  ([BlackBaudFE_journalentrybatchesSK])
GO
