CREATE TABLE [src].[BlackBaud_actions]
(
[SK] [bigint] NULL,
[ETL__multi_query_value_for_audit] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ActionId] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[constituent-id] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[category] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[date] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[summary] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[type] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[description] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[completed] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[status] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[date-added] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[date-modified] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[completed-date] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[opportunity-id] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
