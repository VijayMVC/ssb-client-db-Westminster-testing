CREATE TABLE [src].[BlackBaud_addresses]
(
[SK] [bigint] NULL,
[ETL__multi_query_value_for_audit] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Address_id] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[constituent_id] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[type] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[formatted-address] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[preferred] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[inactive] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[do-not-mail] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address-lines] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[city] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[date-added] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[date-modified] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[state] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[postal-code] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[county] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[country] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
