CREATE TABLE [ods].[Snapshot_Schoology_grades_FinalGrades]
(
[Schoology_grades_FinalGradesSK] [int] NOT NULL IDENTITY(1, 1),
[section_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[enrollment_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[final_grade_scale_id] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[period_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[grade] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[comment] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[final_grade_period_comment_status] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[total_points_possible] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[total_points_awarded] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[override_numeric] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[exception] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_CreatedOn] [datetime] NULL,
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_UpdatedOn] [datetime] NULL,
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RecordEndDate] [datetime] NULL
)
GO
ALTER TABLE [ods].[Snapshot_Schoology_grades_FinalGrades] ADD CONSTRAINT [PK__Snapshot__75111A986D60D2C9] PRIMARY KEY CLUSTERED  ([Schoology_grades_FinalGradesSK])
GO
