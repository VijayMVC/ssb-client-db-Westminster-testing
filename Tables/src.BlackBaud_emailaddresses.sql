CREATE TABLE [src].[BlackBaud_emailaddresses]
(
[SK] [bigint] NULL,
[ETL__multi_query_value_for_audit] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Email_id] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[constituent_id] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[type] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[do-not-email] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[primary] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[inactive] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[date-added] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[date-modified] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
