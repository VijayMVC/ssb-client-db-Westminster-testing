CREATE TABLE [ods].[Snapshot_BlackBaud_customfields]
(
[BlackBaud_customfieldsSK] [int] NOT NULL IDENTITY(1, 1),
[CustomField_id] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[parent_id] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[category] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[type] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[date] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[comment] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[customvalue] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[date-added] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[date-modified] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_CreatedOn] [datetime] NULL,
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_UpdatedOn] [datetime] NULL,
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RecordEndDate] [datetime] NULL
)
GO
ALTER TABLE [ods].[Snapshot_BlackBaud_customfields] ADD CONSTRAINT [PK__Snapshot__E5DD02E89297A5AF] PRIMARY KEY CLUSTERED  ([BlackBaud_customfieldsSK])
GO
