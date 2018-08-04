CREATE TABLE [src].[Schoology_gradingperiods]
(
[SK] [bigint] NULL,
[ETL__multi_query_value_for_audit] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[gradingperiod_id] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[title] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[start] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[end] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[active] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[has-children] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[parentid] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
