CREATE TABLE [ods].[Snapshot_BlackBaud_emailaddresses]
(
[BlackBaud_emailaddressesSK] [int] NOT NULL IDENTITY(1, 1),
[Email_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[constituent_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[type] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[do_not_email] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
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
ALTER TABLE [ods].[Snapshot_BlackBaud_emailaddresses] ADD CONSTRAINT [PK__Snapshot__6103A024E39C1B1D] PRIMARY KEY CLUSTERED  ([BlackBaud_emailaddressesSK])
GO
