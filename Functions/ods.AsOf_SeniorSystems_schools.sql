SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

/*
-- Get the status of your table 20 minutes ago...
DECLARE @AsOfDate DATETIME = (SELECT [etl].[ConvertToLocalTime](DATEADD(MINUTE,-20,GETDATE())))
SELECT * FROM [ods].[AsOf_SeniorSystems_schools] (@AsOfDate)
*/

CREATE FUNCTION [ods].[AsOf_SeniorSystems_schools] (@AsOfDate DATETIME)

RETURNS @Results TABLE
(
[SchoolID] [nvarchar](50) NULL,
[SchoolName] [nvarchar](100) NULL,
[IsAcademicSchool] [nvarchar](10) NULL,
[IsSummerSchool] [nvarchar](10) NULL,
[CurrentAcademicYear] [nvarchar](10) NULL,
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
SELECT [SchoolID],[SchoolName],[IsAcademicSchool],[IsSummerSchool],[CurrentAcademicYear],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy]
FROM
	(
	SELECT [SchoolID],[SchoolName],[IsAcademicSchool],[IsSummerSchool],[CurrentAcademicYear],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],@EndDate [RecordEndDate]
	FROM [ods].[SeniorSystems_schools] t
	UNION ALL
	SELECT [SchoolID],[SchoolName],[IsAcademicSchool],[IsSummerSchool],[CurrentAcademicYear],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate]
	FROM [ods].[Snapshot_SeniorSystems_schools]
	) a
WHERE
	@AsOfDate BETWEEN [ETL_UpdatedOn] AND [RecordEndDate]
	AND [ETL_CreatedOn] <= @AsOfDate

RETURN

END
GO
