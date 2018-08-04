CREATE TABLE [ods].[Snapshot_BlackBaud_gifts_customfields]
(
[BlackBaud_gifts_customfieldsSK] [int] NOT NULL IDENTITY(1, 1),
[GiftCustom_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[GIftCustomFieldCount] [int] NULL,
[Constituent_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[category] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[type] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[valuetext] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[date] [datetime2] NULL,
[comment] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_CreatedOn] [datetime] NULL,
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_UpdatedOn] [datetime] NULL,
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RecordEndDate] [datetime] NULL
)
GO
ALTER TABLE [ods].[Snapshot_BlackBaud_gifts_customfields] ADD CONSTRAINT [PK__Snapshot__CD4FA431A8EC52E2] PRIMARY KEY CLUSTERED  ([BlackBaud_gifts_customfieldsSK])
GO
