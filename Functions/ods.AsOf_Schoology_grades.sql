SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

/*
-- Get the status of your table 20 minutes ago...
DECLARE @AsOfDate DATETIME = (SELECT [etl].[ConvertToLocalTime](DATEADD(MINUTE,-20,GETDATE())))
SELECT * FROM [ods].[AsOf_Schoology_grades] (@AsOfDate)
*/

CREATE FUNCTION [ods].[AsOf_Schoology_grades] (@AsOfDate DATETIME)

RETURNS @Results TABLE
(
[section_id] [nvarchar](50) NULL,
[enrollment_id] [nvarchar](50) NULL,
[assignment_id] [nvarchar](50) NULL,
[grade] [float] NULL,
[grade_exception] [bit] NULL,
[grade_max_points] [float] NULL,
[grade_is_final] [bit] NULL,
[grade_timestamp] [nvarchar](50) NULL,
[grade_comment] [nvarchar](max) NULL,
[grade_comment_status] [int] NULL,
[grade_override] [bit] NULL,
[grade_calculated_grade] [float] NULL,
[grade_pending] [nvarchar](50) NULL,
[grade_type] [nvarchar](50) NULL,
[grade_location] [nvarchar](500) NULL,
[grade_scale_id] [nvarchar](50) NULL,
[grade_scale_type] [nvarchar](50) NULL,
[grade_category_id] [nvarchar](50) NULL,
[grade_school_uid] [nvarchar](50) NULL,
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
SELECT [section_id],[enrollment_id],[assignment_id],[grade],[grade_exception],[grade_max_points],[grade_is_final],[grade_timestamp],[grade_comment],[grade_comment_status],[grade_override],[grade_calculated_grade],[grade_pending],[grade_type],[grade_location],[grade_scale_id],[grade_scale_type],[grade_category_id],[grade_school_uid],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy]
FROM
	(
	SELECT [section_id],[enrollment_id],[assignment_id],[grade],[grade_exception],[grade_max_points],[grade_is_final],[grade_timestamp],[grade_comment],[grade_comment_status],[grade_override],[grade_calculated_grade],[grade_pending],[grade_type],[grade_location],[grade_scale_id],[grade_scale_type],[grade_category_id],[grade_school_uid],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],@EndDate [RecordEndDate]
	FROM [ods].[Schoology_grades] t
	UNION ALL
	SELECT [section_id],[enrollment_id],[assignment_id],[grade],[grade_exception],[grade_max_points],[grade_is_final],[grade_timestamp],[grade_comment],[grade_comment_status],[grade_override],[grade_calculated_grade],[grade_pending],[grade_type],[grade_location],[grade_scale_id],[grade_scale_type],[grade_category_id],[grade_school_uid],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate]
	FROM [ods].[Snapshot_Schoology_grades]
	) a
WHERE
	@AsOfDate BETWEEN [ETL_UpdatedOn] AND [RecordEndDate]
	AND [ETL_CreatedOn] <= @AsOfDate

RETURN

END
GO
