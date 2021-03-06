CREATE TABLE [audit].[BlackBaud_constituents_API]
(
[constituent_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
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
[ETL_CreatedOn] [datetime] NOT NULL,
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ETL_UpdatedOn] [datetime] NOT NULL,
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
GO
