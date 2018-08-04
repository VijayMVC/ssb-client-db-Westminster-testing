SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

/*
-- Get the status of your table 20 minutes ago...
DECLARE @AsOfDate DATETIME = (SELECT [etl].[ConvertToLocalTime](DATEADD(MINUTE,-20,GETDATE())))
SELECT * FROM [ods].[AsOf_SeniorSystems_schoolsections] (@AsOfDate)
*/

CREATE FUNCTION [ods].[AsOf_SeniorSystems_schoolsections] (@AsOfDate DATETIME)

RETURNS @Results TABLE
(
[SectionID] [nvarchar](50) NULL,
[MeetsPeriod] [nvarchar](50) NULL,
[MeetsLength] [nvarchar](10) NULL,
[MeetsGradeSeq] [nvarchar](10) NULL,
[SchoolID] [nvarchar](10) NULL,
[SchoolName] [nvarchar](50) NULL,
[CourseID] [nvarchar](50) NULL,
[CourseName] [nvarchar](250) NULL,
[FullName] [nvarchar](500) NULL,
[Abbreviation] [nvarchar](50) NULL,
[Description] [nvarchar](max) NULL,
[GradeLevel] [nvarchar](10) NULL,
[Department_DepartmentID] [nvarchar](50) NULL,
[Department_Name] [nvarchar](250) NULL,
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
SELECT [SectionID],[MeetsPeriod],[MeetsLength],[MeetsGradeSeq],[SchoolID],[SchoolName],[CourseID],[CourseName],[FullName],[Abbreviation],[Description],[GradeLevel],[Department_DepartmentID],[Department_Name],[CurrentYear],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy]
FROM
	(
	SELECT [SectionID],[MeetsPeriod],[MeetsLength],[MeetsGradeSeq],[SchoolID],[SchoolName],[CourseID],[CourseName],[FullName],[Abbreviation],[Description],[GradeLevel],[Department_DepartmentID],[Department_Name],[CurrentYear],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],@EndDate [RecordEndDate]
	FROM [ods].[SeniorSystems_schoolsections] t
	UNION ALL
	SELECT [SectionID],[MeetsPeriod],[MeetsLength],[MeetsGradeSeq],[SchoolID],[SchoolName],[CourseID],[CourseName],[FullName],[Abbreviation],[Description],[GradeLevel],[Department_DepartmentID],[Department_Name],[CurrentYear],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate]
	FROM [ods].[Snapshot_SeniorSystems_schoolsections]
	) a
WHERE
	@AsOfDate BETWEEN [ETL_UpdatedOn] AND [RecordEndDate]
	AND [ETL_CreatedOn] <= @AsOfDate

RETURN

END
GO
