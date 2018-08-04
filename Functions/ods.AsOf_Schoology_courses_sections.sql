SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

/*
-- Get the status of your table 20 minutes ago...
DECLARE @AsOfDate DATETIME = (SELECT [etl].[ConvertToLocalTime](DATEADD(MINUTE,-20,GETDATE())))
SELECT * FROM [ods].[AsOf_Schoology_courses_sections] (@AsOfDate)
*/

CREATE FUNCTION [ods].[AsOf_Schoology_courses_sections] (@AsOfDate DATETIME)

RETURNS @Results TABLE
(
[section_id] [nvarchar](50) NULL,
[course_title] [nvarchar](500) NULL,
[course_code] [nvarchar](50) NULL,
[course_id] [nvarchar](50) NULL,
[school_id] [nvarchar](50) NULL,
[access_code] [nvarchar](50) NULL,
[section_title] [nvarchar](250) NULL,
[section_code] [nvarchar](50) NULL,
[section_school_code] [nvarchar](50) NULL,
[synced] [bit] NULL,
[active] [bit] NULL,
[description] [nvarchar](max) NULL,
[parent_id] [nvarchar](50) NULL,
[profile_url] [nvarchar](2000) NULL,
[location] [nvarchar](200) NULL,
[start_time] [nvarchar](50) NULL,
[end_time] [nvarchar](50) NULL,
[weight] [nvarchar](10) NULL,
[admin] [nvarchar](10) NULL,
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
[ETL_CreatedOn] [datetime] NOT NULL,
[ETL_CreatedBy] NVARCHAR(400) NOT NULL,
[ETL_UpdatedOn] [datetime] NOT NULL,
[ETL_UpdatedBy] NVARCHAR(400) NOT NULL
)

AS
BEGIN

DECLARE @EndDate DATETIME = (SELECT [etl].[ConvertToLocalTime](CAST(GETDATE() AS datetime2(0))))
SET @AsOfDate = (SELECT CAST(@AsOfDate AS datetime2(0)))

INSERT INTO @Results
SELECT [section_id],[course_title],[course_code],[course_id],[school_id],[access_code],[section_title],[section_code],[section_school_code],[synced],[active],[description],[parent_id],[profile_url],[location],[start_time],[end_time],[weight],[admin],[options_weighted_grading_categories],[upload_documents],[create_discussion],[member_post],[member_post_comment],[default_grading_scale_id],[hide_overall_grade],[hide_grading_period_grade],[allow_custom_overall_grade],[allow_custom_overall_grade_text],[visibility_topics],[visibility_assignments],[visibility_assessments],[visibility_new_test_quiz],[visibility_common_assessments],[visibility_documents],[visibility_discussion],[visibility_album],[visibility_pages],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy]
FROM
	(
	SELECT [section_id],[course_title],[course_code],[course_id],[school_id],[access_code],[section_title],[section_code],[section_school_code],[synced],[active],[description],[parent_id],[profile_url],[location],[start_time],[end_time],[weight],[admin],[options_weighted_grading_categories],[upload_documents],[create_discussion],[member_post],[member_post_comment],[default_grading_scale_id],[hide_overall_grade],[hide_grading_period_grade],[allow_custom_overall_grade],[allow_custom_overall_grade_text],[visibility_topics],[visibility_assignments],[visibility_assessments],[visibility_new_test_quiz],[visibility_common_assessments],[visibility_documents],[visibility_discussion],[visibility_album],[visibility_pages],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],@EndDate [RecordEndDate]
	FROM [ods].[Schoology_courses_sections] t
	UNION ALL
	SELECT [section_id],[course_title],[course_code],[course_id],[school_id],[access_code],[section_title],[section_code],[section_school_code],[synced],[active],[description],[parent_id],[profile_url],[location],[start_time],[end_time],[weight],[admin],[options_weighted_grading_categories],[upload_documents],[create_discussion],[member_post],[member_post_comment],[default_grading_scale_id],[hide_overall_grade],[hide_grading_period_grade],[allow_custom_overall_grade],[allow_custom_overall_grade_text],[visibility_topics],[visibility_assignments],[visibility_assessments],[visibility_new_test_quiz],[visibility_common_assessments],[visibility_documents],[visibility_discussion],[visibility_album],[visibility_pages],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate]
	FROM [ods].[Snapshot_Schoology_courses_sections]
	) a
WHERE
	@AsOfDate BETWEEN [ETL_UpdatedOn] AND [RecordEndDate]
	AND [ETL_CreatedOn] <= @AsOfDate

RETURN

END
GO
