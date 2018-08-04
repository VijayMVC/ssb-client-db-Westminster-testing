CREATE TABLE [src].[BlackBaud_constituents_phone]
(
[SK] [bigint] NULL,
[ETL__multi_query_value_for_audit] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[phone_id] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[constituent_id] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[phone_type] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[phone_number] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[phone_do-not-call] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[phone_primary] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
