CREATE TABLE [ods].[Schoology_courses_sections]
(
[section_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[course_title] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[course_code] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[course_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[school_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[access_code] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[section_title] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[section_code] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[section_school_code] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[synced] [bit] NULL,
[active] [bit] NULL,
[description] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[parent_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[profile_url] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[location] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[start_time] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[end_time] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[weight] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[admin] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[options_weighted_grading_categories] [bit] NULL,
[upload_documents] [bit] NULL,
[create_discussion] [bit] NULL,
[member_post] [bit] NULL,
[member_post_comment] [bit] NULL,
[default_grading_scale_id] [bit] NULL,
[hide_overall_grade] [bit] NULL,
[hide_grading_period_grade] [bit] NULL,
[allow_custom_overall_grade] [bit] NULL,
[allow_custom_overall_grade_text] [bit] NULL,
[visibility_topics] [bit] NULL,
[visibility_assignments] [bit] NULL,
[visibility_assessments] [bit] NULL,
[visibility_new_test_quiz] [bit] NULL,
[visibility_common_assessments] [bit] NULL,
[visibility_documents] [bit] NULL,
[visibility_discussion] [bit] NULL,
[visibility_album] [bit] NULL,
[visibility_pages] [bit] NULL,
[ETL_CreatedOn] [datetime] NOT NULL CONSTRAINT [DF__Schoology__ETL_C__1F14FD94] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__Schoology__ETL_C__200921CD] DEFAULT (suser_sname()),
[ETL_UpdatedOn] [datetime] NOT NULL CONSTRAINT [DF__Schoology__ETL_U__20FD4606] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__Schoology__ETL_U__21F16A3F] DEFAULT (suser_sname())
)
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

----------- CREATE TRIGGER -----------
CREATE TRIGGER [ods].[Snapshot_Schoology_courses_sectionsUpdate] ON [ods].[Schoology_courses_sections]
AFTER UPDATE, DELETE

AS
BEGIN

DECLARE @ETL_UpdatedOn DATETIME = (SELECT [etl].[ConvertToLocalTime](CAST(GETDATE() AS DATETIME2(0))))
DECLARE @ETL_UpdatedBy NVARCHAR(400) = (SELECT SYSTEM_USER)

UPDATE t SET
[ETL_UpdatedOn] = @ETL_UpdatedOn
,[ETL_UpdatedBy] = @ETL_UpdatedBy
FROM [ods].[Schoology_courses_sections] t
	JOIN inserted i ON  t.[section_id] = i.[section_id]

INSERT INTO [ods].[Snapshot_Schoology_courses_sections] ([section_id],[course_title],[course_code],[course_id],[school_id],[access_code],[section_title],[section_code],[section_school_code],[synced],[active],[description],[parent_id],[profile_url],[location],[start_time],[end_time],[weight],[admin],[options_weighted_grading_categories],[upload_documents],[create_discussion],[member_post],[member_post_comment],[default_grading_scale_id],[hide_overall_grade],[hide_grading_period_grade],[allow_custom_overall_grade],[allow_custom_overall_grade_text],[visibility_topics],[visibility_assignments],[visibility_assessments],[visibility_new_test_quiz],[visibility_common_assessments],[visibility_documents],[visibility_discussion],[visibility_album],[visibility_pages],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate])
SELECT a.*,dateadd(s,-1,@ETL_UpdatedOn)
FROM deleted a

END
GO
ALTER TABLE [ods].[Schoology_courses_sections] ADD CONSTRAINT [PK__Schoolog__F842676AE5F6929B] PRIMARY KEY CLUSTERED  ([section_id])
GO
