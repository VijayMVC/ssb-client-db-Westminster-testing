SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

/*
-- Get the status of your table 20 minutes ago...
DECLARE @AsOfDate DATETIME = (SELECT [etl].[ConvertToLocalTime](DATEADD(MINUTE,-20,GETDATE())))
SELECT * FROM [ods].[AsOf_Schoology_courses] (@AsOfDate)
*/

CREATE FUNCTION [ods].[AsOf_Schoology_courses] (@AsOfDate DATETIME)

RETURNS @Results TABLE
(
[course_id] [nvarchar](50) NULL,
[title] [nvarchar](250) NULL,
[course-code] [nvarchar](50) NULL,
[department] [nvarchar](50) NULL,
[description] [nvarchar](max) NULL,
[credits] [int] NULL,
[subject-area] [int] NULL,
[grade-level-range-start] [int] NULL,
[grade-level-range-end] [int] NULL,
[synced] [bit] NULL,
[building-id] [nvarchar](50) NULL,
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
SELECT [course_id],[title],[course-code],[department],[description],[credits],[subject-area],[grade-level-range-start],[grade-level-range-end],[synced],[building-id],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy]
FROM
	(
	SELECT [course_id],[title],[course-code],[department],[description],[credits],[subject-area],[grade-level-range-start],[grade-level-range-end],[synced],[building-id],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],@EndDate [RecordEndDate]
	FROM [ods].[Schoology_courses] t
	UNION ALL
	SELECT [course_id],[title],[course-code],[department],[description],[credits],[subject-area],[grade-level-range-start],[grade-level-range-end],[synced],[building-id],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate]
	FROM [ods].[Snapshot_Schoology_courses]
	) a
WHERE
	@AsOfDate BETWEEN [ETL_UpdatedOn] AND [RecordEndDate]
	AND [ETL_CreatedOn] <= @AsOfDate

RETURN

END
GO
