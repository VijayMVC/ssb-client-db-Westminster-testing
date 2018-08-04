CREATE TABLE [src].[BlackBaud_constituents_email]
(
[SK] [bigint] NULL,
[ETL__multi_query_value_for_audit] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[email_id] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[constituent_id] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[email_type] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[email_address] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[email_do-not-email] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[email_primary] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
