CREATE TABLE [ods].[Snapshot_BlackBaudFE_journalentrybatches_batch_customfields]
(
[BlackBaudFE_journalentrybatches_batch_customfieldsSK] [int] NOT NULL IDENTITY(1, 1),
[journal_entry_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[custom_fields_custom_field_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[custom_fields_field_name] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[custom_fields_value] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[custom_fields_comments] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[custom_fields_type] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[custom_fields_date] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_CreatedOn] [datetime] NULL,
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_UpdatedOn] [datetime] NULL,
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RecordEndDate] [datetime] NULL
)
GO
ALTER TABLE [ods].[Snapshot_BlackBaudFE_journalentrybatches_batch_customfields] ADD CONSTRAINT [PK__Snapshot__1C079A2203198E1E] PRIMARY KEY CLUSTERED  ([BlackBaudFE_journalentrybatches_batch_customfieldsSK])
GO
