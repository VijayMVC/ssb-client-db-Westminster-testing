CREATE TABLE [src].[Schoology_courses]
(
[SK] [bigint] NULL,
[ETL__multi_query_value_for_audit] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[course_id] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[title] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[course-code] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[department] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[description] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[credits] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[subject-area] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[grade-level-range-start] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[grade-level-range-end] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[synced] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[building-id] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
