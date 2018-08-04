CREATE TABLE [ods].[Schoology_grades_FinalGrades]
(
[section_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[enrollment_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[final_grade_scale_id] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[period_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[grade] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[comment] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[final_grade_period_comment_status] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[total_points_possible] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[total_points_awarded] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[override_numeric] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[exception] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_CreatedOn] [datetime] NOT NULL CONSTRAINT [DF__Schoology__ETL_C__3C26A122] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__Schoology__ETL_C__3D1AC55B] DEFAULT (suser_sname()),
[ETL_UpdatedOn] [datetime] NOT NULL CONSTRAINT [DF__Schoology__ETL_U__3E0EE994] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__Schoology__ETL_U__3F030DCD] DEFAULT (suser_sname())
)
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

----------- CREATE TRIGGER -----------
CREATE TRIGGER [ods].[Snapshot_Schoology_grades_FinalGradesUpdate] ON [ods].[Schoology_grades_FinalGrades]
AFTER UPDATE, DELETE

AS
BEGIN

DECLARE @ETL_UpdatedOn DATETIME = (SELECT [etl].[ConvertToLocalTime](CAST(GETDATE() AS DATETIME2(0))))
DECLARE @ETL_UpdatedBy NVARCHAR(400) = (SELECT SYSTEM_USER)

UPDATE t SET
[ETL_UpdatedOn] = @ETL_UpdatedOn
,[ETL_UpdatedBy] = @ETL_UpdatedBy
FROM [ods].[Schoology_grades_FinalGrades] t
	JOIN inserted i ON  t.[section_id] = i.[section_id] AND t.[enrollment_id] = i.[enrollment_id] AND t.[period_id] = i.[period_id]

INSERT INTO [ods].[Snapshot_Schoology_grades_FinalGrades] ([section_id],[enrollment_id],[final_grade_scale_id],[period_id],[grade],[comment],[final_grade_period_comment_status],[total_points_possible],[total_points_awarded],[override_numeric],[exception],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate])
SELECT a.*,dateadd(s,-1,@ETL_UpdatedOn)
FROM deleted a

END
GO
ALTER TABLE [ods].[Schoology_grades_FinalGrades] ADD CONSTRAINT [PK__Schoolog__0BB30E233FD95019] PRIMARY KEY CLUSTERED  ([section_id], [enrollment_id], [period_id])
GO
