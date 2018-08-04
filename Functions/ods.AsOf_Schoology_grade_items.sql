SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

/*
-- Get the status of your table 20 minutes ago...
DECLARE @AsOfDate DATETIME = (SELECT [etl].[ConvertToLocalTime](DATEADD(MINUTE,-20,GETDATE())))
SELECT * FROM [ods].[AsOf_Schoology_grade_items] (@AsOfDate)
*/

CREATE FUNCTION [ods].[AsOf_Schoology_grade_items] (@AsOfDate DATETIME)

RETURNS @Results TABLE
(
[section_id] [nvarchar](50) NULL,
[assignment_id] [nvarchar](50) NULL,
[title] [nvarchar](250) NULL,
[description] [nvarchar](max) NULL,
[due] [nvarchar](50) NULL,
[grading_scale] [nvarchar](50) NULL,
[grading_period] [nvarchar](50) NULL,
[grading_category] [nvarchar](50) NULL,
[max_points] [float] NULL,
[factor] [int] NULL,
[is_final] [bit] NULL,
[show_comments] [bit] NULL,
[grade_stats] [bit] NULL,
[allow_dropbox] [bit] NULL,
[allow_discussion] [bit] NULL,
[published] [bit] NULL,
[type] [nvarchar](50) NULL,
[grade_item_id] [nvarchar](50) NULL,
[available] [bit] NULL,
[completed] [bit] NULL,
[dropbox_locked] [bit] NULL,
[grading_scale_type] [int] NULL,
[show_rubric] [nvarchar](10) NULL,
[display_weight] [int] NULL,
[folder_id] [nvarchar](50) NULL,
[num_assignees] [int] NULL,
[last_updated] [nvarchar](50) NULL,
[completion_status] [nvarchar](50) NULL,
[topic_id] [nvarchar](50) NULL,
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
SELECT [section_id],[assignment_id],[title],[description],[due],[grading_scale],[grading_period],[grading_category],[max_points],[factor],[is_final],[show_comments],[grade_stats],[allow_dropbox],[allow_discussion],[published],[type],[grade_item_id],[available],[completed],[dropbox_locked],[grading_scale_type],[show_rubric],[display_weight],[folder_id],[num_assignees],[last_updated],[completion_status],[topic_id],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy]
FROM
	(
	SELECT [section_id],[assignment_id],[title],[description],[due],[grading_scale],[grading_period],[grading_category],[max_points],[factor],[is_final],[show_comments],[grade_stats],[allow_dropbox],[allow_discussion],[published],[type],[grade_item_id],[available],[completed],[dropbox_locked],[grading_scale_type],[show_rubric],[display_weight],[folder_id],[num_assignees],[last_updated],[completion_status],[topic_id],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],@EndDate [RecordEndDate]
	FROM [ods].[Schoology_grade_items] t
	UNION ALL
	SELECT [section_id],[assignment_id],[title],[description],[due],[grading_scale],[grading_period],[grading_category],[max_points],[factor],[is_final],[show_comments],[grade_stats],[allow_dropbox],[allow_discussion],[published],[type],[grade_item_id],[available],[completed],[dropbox_locked],[grading_scale_type],[show_rubric],[display_weight],[folder_id],[num_assignees],[last_updated],[completion_status],[topic_id],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate]
	FROM [ods].[Snapshot_Schoology_grade_items]
	) a
WHERE
	@AsOfDate BETWEEN [ETL_UpdatedOn] AND [RecordEndDate]
	AND [ETL_CreatedOn] <= @AsOfDate

RETURN

END
GO
