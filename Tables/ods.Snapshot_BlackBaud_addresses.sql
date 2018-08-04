CREATE TABLE [ods].[Snapshot_BlackBaud_addresses]
(
[BlackBaud_addressesSK] [int] NOT NULL IDENTITY(1, 1),
[address_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[constituent_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[type] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[formatted_address] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[preferred] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[inactive] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[do_not_mail] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address_lines] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[city] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[date_added] [datetime2] NULL,
[date_modified] [datetime2] NULL,
[state] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[postal_code] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[county] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[country] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_CreatedOn] [datetime] NULL,
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_UpdatedOn] [datetime] NULL,
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RecordEndDate] [datetime] NULL
)
GO
ALTER TABLE [ods].[Snapshot_BlackBaud_addresses] ADD CONSTRAINT [PK__Snapshot__B6F1CE7A0A457FE6] PRIMARY KEY CLUSTERED  ([BlackBaud_addressesSK])
GO
