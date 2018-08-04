CREATE TABLE [src].[Schoology_grading_categories]
(
[SK] [bigint] NULL,
[ETL__multi_query_value_for_audit] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[grading-category_id] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[title] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[delta] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[realm] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[realm-id] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[calculation-type] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[default-max-points] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[default-grading-scale-id] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[drop-lowest] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[weight] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
