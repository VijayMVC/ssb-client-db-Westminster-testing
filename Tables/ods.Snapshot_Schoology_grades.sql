CREATE TABLE [ods].[Snapshot_Schoology_grades]
(
[Schoology_gradesSK] [int] NOT NULL IDENTITY(1, 1),
[section_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[enrollment_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[assignment_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[grade] [float] NULL,
[grade_exception] [bit] NULL,
[grade_max_points] [float] NULL,
[grade_is_final] [bit] NULL,
[grade_timestamp] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[grade_comment] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[grade_comment_status] [int] NULL,
[grade_override] [bit] NULL,
[grade_calculated_grade] [float] NULL,
[grade_pending] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[grade_type] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[grade_location] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[grade_scale_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[grade_scale_type] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[grade_category_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[grade_school_uid] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_CreatedOn] [datetime] NULL,
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_UpdatedOn] [datetime] NULL,
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RecordEndDate] [datetime] NULL
)
GO
ALTER TABLE [ods].[Snapshot_Schoology_grades] ADD CONSTRAINT [PK__Snapshot__9BC790FCF725EA72] PRIMARY KEY CLUSTERED  ([Schoology_gradesSK])
GO
