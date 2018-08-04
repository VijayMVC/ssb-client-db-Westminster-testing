SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

/*
-- Get the status of your table 20 minutes ago...
DECLARE @AsOfDate DATETIME = (SELECT [etl].[ConvertToLocalTime](DATEADD(MINUTE,-20,GETDATE())))
SELECT * FROM [ods].[AsOf_Schoology_grades_FinalGrades] (@AsOfDate)
*/

CREATE FUNCTION [ods].[AsOf_Schoology_grades_FinalGrades] (@AsOfDate DATETIME)

RETURNS @Results TABLE
(
[section_id] [nvarchar](50) NULL,
[enrollment_id] [nvarchar](50) NULL,
[final_grade_scale_id] [nvarchar](max) NULL,
[period_id] [nvarchar](50) NULL,
[grade] [nvarchar](50) NULL,
[comment] [nvarchar](max) NULL,
[final_grade_period_comment_status] [nvarchar](50) NULL,
[total_points_possible] [nvarchar](50) NULL,
[total_points_awarded] [nvarchar](50) NULL,
[override_numeric] [nvarchar](50) NULL,
[exception] [nvarchar](50) NULL,
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
SELECT [section_id],[enrollment_id],[final_grade_scale_id],[period_id],[grade],[comment],[final_grade_period_comment_status],[total_points_possible],[total_points_awarded],[override_numeric],[exception],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy]
FROM
	(
	SELECT [section_id],[enrollment_id],[final_grade_scale_id],[period_id],[grade],[comment],[final_grade_period_comment_status],[total_points_possible],[total_points_awarded],[override_numeric],[exception],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],@EndDate [RecordEndDate]
	FROM [ods].[Schoology_grades_FinalGrades] t
	UNION ALL
	SELECT [section_id],[enrollment_id],[final_grade_scale_id],[period_id],[grade],[comment],[final_grade_period_comment_status],[total_points_possible],[total_points_awarded],[override_numeric],[exception],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate]
	FROM [ods].[Snapshot_Schoology_grades_FinalGrades]
	) a
WHERE
	@AsOfDate BETWEEN [ETL_UpdatedOn] AND [RecordEndDate]
	AND [ETL_CreatedOn] <= @AsOfDate

RETURN

END
GO
