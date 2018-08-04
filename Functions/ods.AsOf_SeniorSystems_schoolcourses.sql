SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

/*
-- Get the status of your table 20 minutes ago...
DECLARE @AsOfDate DATETIME = (SELECT [etl].[ConvertToLocalTime](DATEADD(MINUTE,-20,GETDATE())))
SELECT * FROM [ods].[AsOf_SeniorSystems_schoolcourses] (@AsOfDate)
*/

CREATE FUNCTION [ods].[AsOf_SeniorSystems_schoolcourses] (@AsOfDate DATETIME)

RETURNS @Results TABLE
(
[SchoolID] [nvarchar](50) NULL,
[CourseID] [nvarchar](50) NULL,
[CourseName] [nvarchar](200) NULL,
[FullName] [nvarchar](200) NULL,
[Abbreviation] [nvarchar](50) NULL,
[Description] [nvarchar](max) NULL,
[GradeLevel] [nvarchar](50) NULL,
[DepartmentID] [nvarchar](50) NULL,
[Department_Name] [nvarchar](200) NULL,
[CurrentYear] [int] NULL,
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
SELECT [SchoolID],[CourseID],[CourseName],[FullName],[Abbreviation],[Description],[GradeLevel],[DepartmentID],[Department_Name],[CurrentYear],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy]
FROM
	(
	SELECT [SchoolID],[CourseID],[CourseName],[FullName],[Abbreviation],[Description],[GradeLevel],[DepartmentID],[Department_Name],[CurrentYear],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],@EndDate [RecordEndDate]
	FROM [ods].[SeniorSystems_schoolcourses] t
	UNION ALL
	SELECT [SchoolID],[CourseID],[CourseName],[FullName],[Abbreviation],[Description],[GradeLevel],[DepartmentID],[Department_Name],[CurrentYear],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate]
	FROM [ods].[Snapshot_SeniorSystems_schoolcourses]
	) a
WHERE
	@AsOfDate BETWEEN [ETL_UpdatedOn] AND [RecordEndDate]
	AND [ETL_CreatedOn] <= @AsOfDate

RETURN

END
GO
