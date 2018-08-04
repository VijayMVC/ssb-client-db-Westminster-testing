SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

/*
-- Get the status of your table 20 minutes ago...
DECLARE @AsOfDate DATETIME = (SELECT [etl].[ConvertToLocalTime](DATEADD(MINUTE,-20,GETDATE())))
SELECT * FROM [ods].[AsOf_Schoology_grading_categories] (@AsOfDate)
*/

CREATE FUNCTION [ods].[AsOf_Schoology_grading_categories] (@AsOfDate DATETIME)

RETURNS @Results TABLE
(
[grading_category_id] [nvarchar](50) NULL,
[title] [nvarchar](100) NULL,
[delta] [nvarchar](50) NULL,
[realm] [nvarchar](50) NULL,
[section_id] [nvarchar](50) NULL,
[calculation_type] [int] NULL,
[default_max_points] [float] NULL,
[default_grading_scale_id] [nvarchar](50) NULL,
[drop_lowest] [int] NULL,
[weight] [float] NULL,
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
SELECT [grading_category_id],[title],[delta],[realm],[section_id],[calculation_type],[default_max_points],[default_grading_scale_id],[drop_lowest],[weight],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy]
FROM
	(
	SELECT [grading_category_id],[title],[delta],[realm],[section_id],[calculation_type],[default_max_points],[default_grading_scale_id],[drop_lowest],[weight],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],@EndDate [RecordEndDate]
	FROM [ods].[Schoology_grading_categories] t
	UNION ALL
	SELECT [grading_category_id],[title],[delta],[realm],[section_id],[calculation_type],[default_max_points],[default_grading_scale_id],[drop_lowest],[weight],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate]
	FROM [ods].[Snapshot_Schoology_grading_categories]
	) a
WHERE
	@AsOfDate BETWEEN [ETL_UpdatedOn] AND [RecordEndDate]
	AND [ETL_CreatedOn] <= @AsOfDate

RETURN

END
GO
