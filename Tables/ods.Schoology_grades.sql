CREATE TABLE [ods].[Schoology_grades]
(
[section_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[enrollment_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[assignment_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
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
[ETL_CreatedOn] [datetime] NOT NULL CONSTRAINT [DF__Schoology__ETL_C__329D36E8] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__Schoology__ETL_C__33915B21] DEFAULT (suser_sname()),
[ETL_UpdatedOn] [datetime] NOT NULL CONSTRAINT [DF__Schoology__ETL_U__34857F5A] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__Schoology__ETL_U__3579A393] DEFAULT (suser_sname())
)
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

----------- CREATE TRIGGER -----------
CREATE TRIGGER [ods].[Snapshot_Schoology_gradesUpdate] ON [ods].[Schoology_grades]
AFTER UPDATE, DELETE

AS
BEGIN

DECLARE @ETL_UpdatedOn DATETIME = (SELECT [etl].[ConvertToLocalTime](CAST(GETDATE() AS DATETIME2(0))))
DECLARE @ETL_UpdatedBy NVARCHAR(400) = (SELECT SYSTEM_USER)

UPDATE t SET
[ETL_UpdatedOn] = @ETL_UpdatedOn
,[ETL_UpdatedBy] = @ETL_UpdatedBy
FROM [ods].[Schoology_grades] t
	JOIN inserted i ON  t.[section_id] = i.[section_id] AND t.[enrollment_id] = i.[enrollment_id] AND t.[assignment_id] = i.[assignment_id]

INSERT INTO [ods].[Snapshot_Schoology_grades] ([section_id],[enrollment_id],[assignment_id],[grade],[grade_exception],[grade_max_points],[grade_is_final],[grade_timestamp],[grade_comment],[grade_comment_status],[grade_override],[grade_calculated_grade],[grade_pending],[grade_type],[grade_location],[grade_scale_id],[grade_scale_type],[grade_category_id],[grade_school_uid],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate])
SELECT a.*,dateadd(s,-1,@ETL_UpdatedOn)
FROM deleted a

END
GO
ALTER TABLE [ods].[Schoology_grades] ADD CONSTRAINT [PK__Schoolog__5B4AA4D59214557A] PRIMARY KEY CLUSTERED  ([section_id], [enrollment_id], [assignment_id])
GO
