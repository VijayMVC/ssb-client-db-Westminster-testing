CREATE TABLE [ods].[Snapshot_Schoology_courses]
(
[Schoology_coursesSK] [int] NOT NULL IDENTITY(1, 1),
[course_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[title] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[course-code] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[department] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[description] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[credits] [int] NULL,
[subject-area] [int] NULL,
[grade-level-range-start] [int] NULL,
[grade-level-range-end] [int] NULL,
[synced] [bit] NULL,
[building-id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_CreatedOn] [datetime] NULL,
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_UpdatedOn] [datetime] NULL,
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RecordEndDate] [datetime] NULL
)
GO
ALTER TABLE [ods].[Snapshot_Schoology_courses] ADD CONSTRAINT [PK__Snapshot__CEE947D7A9C746F1] PRIMARY KEY CLUSTERED  ([Schoology_coursesSK])
GO
