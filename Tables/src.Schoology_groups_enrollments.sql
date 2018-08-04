CREATE TABLE [src].[Schoology_groups_enrollments]
(
[SK] [bigint] NULL,
[ETL__multi_query_value_for_audit] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[enrollment_id] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[uid] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[school-uid] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[name-title] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[name-title-show] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[name-first] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[name-first-preferred] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[use-preferred-first-name] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[name-middle] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[name-middle-show] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[name-last] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[name-display] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[admin] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[status] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[picture-url] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[links_self] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
