CREATE TABLE [ods].[Snapshot_BlackBaud_constituents]
(
[BlackBaud_constituentsSK] [int] NOT NULL IDENTITY(1, 1),
[constituent_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[type] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[lookup_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[inactive] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fullname] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[gender] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[deceased] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[date_added] [datetime2] NULL,
[date_modified] [datetime2] NULL,
[gives_anonymously] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[lastname] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[firstname] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[middlename] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[preferred_name] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[title] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[marital_status] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[age] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[suffix] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[phone_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[email_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[birthdate_year] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[birthdate_month] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[birthdate_day] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[spouse_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[online_presence_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_CreatedOn] [datetime] NULL,
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_UpdatedOn] [datetime] NULL,
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RecordEndDate] [datetime] NULL
)
GO
ALTER TABLE [ods].[Snapshot_BlackBaud_constituents] ADD CONSTRAINT [PK__Snapshot__F67615DAA3C67FA2] PRIMARY KEY CLUSTERED  ([BlackBaud_constituentsSK])
GO
