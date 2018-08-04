CREATE TABLE [src].[Schoology_grading_scales]
(
[SK] [bigint] NULL,
[ETL__multi_query_value_for_audit] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[gradingscale_id] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[title] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[type] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[auto-averaging] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[hide-numeric] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Grandingscale_level] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[level_] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[grade] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[cutoff] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[average] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[points] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[description] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
