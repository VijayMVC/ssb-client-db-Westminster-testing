CREATE TABLE [ods].[Snapshot_BlackBaud_phones]
(
[BlackBaud_phonesSK] [int] NOT NULL IDENTITY(1, 1),
[Phoneid] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[constituent_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[type] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[number] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[do_not_call] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[primary] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[inactive] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[date_added] [datetime2] NULL,
[date_modified] [datetime2] NULL,
[ETL_CreatedOn] [datetime] NULL,
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_UpdatedOn] [datetime] NULL,
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RecordEndDate] [datetime] NULL
)
GO
ALTER TABLE [ods].[Snapshot_BlackBaud_phones] ADD CONSTRAINT [PK__Snapshot__25A67B0E1915554A] PRIMARY KEY CLUSTERED  ([BlackBaud_phonesSK])
GO
