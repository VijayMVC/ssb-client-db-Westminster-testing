SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

/*
-- Get the status of your table 20 minutes ago...
DECLARE @AsOfDate DATETIME = (SELECT [etl].[ConvertToLocalTime](DATEADD(MINUTE,-20,GETDATE())))
SELECT * FROM [ods].[AsOf_SeniorSystems_persons_FacultyInfo] (@AsOfDate)
*/

CREATE FUNCTION [ods].[AsOf_SeniorSystems_persons_FacultyInfo] (@AsOfDate DATETIME)

RETURNS @Results TABLE
(
[EntityNo] [nvarchar](50) NULL,
[Faculty_ID] [nvarchar](50) NULL,
[DepartmentID] [nvarchar](50) NULL,
[DepartmentName] [nvarchar](200) NULL,
[JobTitle] [nvarchar](100) NULL,
[InternalTelNo] [nvarchar](50) NULL,
[HireDate] [datetime2](7) NULL,
[MajorTeachingArea] [nvarchar](100) NULL,
[MinorTeachingArea] [nvarchar](100) NULL,
[FacultyType] [nvarchar](100) NULL,
[FacultyStatus] [nvarchar](100) NULL,
[ExperienceLevel] [nvarchar](100) NULL,
[Location] [nvarchar](100) NULL,
[IsActive] [nvarchar](10) NULL,
[EMail] [nvarchar](250) NULL,
[DisplayInDirectory] [nvarchar](10) NULL,
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
SELECT [EntityNo],[Faculty_ID],[DepartmentID],[DepartmentName],[JobTitle],[InternalTelNo],[HireDate],[MajorTeachingArea],[MinorTeachingArea],[FacultyType],[FacultyStatus],[ExperienceLevel],[Location],[IsActive],[EMail],[DisplayInDirectory],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy]
FROM
	(
	SELECT [EntityNo],[Faculty_ID],[DepartmentID],[DepartmentName],[JobTitle],[InternalTelNo],[HireDate],[MajorTeachingArea],[MinorTeachingArea],[FacultyType],[FacultyStatus],[ExperienceLevel],[Location],[IsActive],[EMail],[DisplayInDirectory],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],@EndDate [RecordEndDate]
	FROM [ods].[SeniorSystems_persons_FacultyInfo] t
	UNION ALL
	SELECT [EntityNo],[Faculty_ID],[DepartmentID],[DepartmentName],[JobTitle],[InternalTelNo],[HireDate],[MajorTeachingArea],[MinorTeachingArea],[FacultyType],[FacultyStatus],[ExperienceLevel],[Location],[IsActive],[EMail],[DisplayInDirectory],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate]
	FROM [ods].[Snapshot_SeniorSystems_persons_FacultyInfo]
	) a
WHERE
	@AsOfDate BETWEEN [ETL_UpdatedOn] AND [RecordEndDate]
	AND [ETL_CreatedOn] <= @AsOfDate

RETURN

END
GO
