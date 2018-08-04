CREATE TABLE [src].[Schoology_users_inactive]
(
[SK] [bigint] NULL,
[ETL__multi_query_value_for_audit] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[uid] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[name] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[school-uid] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[synced] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[inactive-timestamp] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[modified-by-uid] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
