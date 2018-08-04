SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

/*
-- Get the status of your table 20 minutes ago...
DECLARE @AsOfDate DATETIME = (SELECT [etl].[ConvertToLocalTime](DATEADD(MINUTE,-20,GETDATE())))
SELECT * FROM [ods].[AsOf_SeniorSystems_persons] (@AsOfDate)
*/

CREATE FUNCTION [ods].[AsOf_SeniorSystems_persons] (@AsOfDate DATETIME)

RETURNS @Results TABLE
(
[EntityNo] [nvarchar](50) NULL,
[Title] [nvarchar](50) NULL,
[FirstName] [nvarchar](100) NULL,
[MiddleName] [nvarchar](50) NULL,
[LastName] [nvarchar](100) NULL,
[Suffix] [nvarchar](50) NULL,
[PrefferedName] [nvarchar](100) NULL,
[FullName] [nvarchar](300) NULL,
[Gender] [nvarchar](10) NULL,
[IsParent] [nvarchar](10) NULL,
[FamilyID] [nvarchar](50) NULL,
[HouseholdID] [nvarchar](50) NULL,
[ParentType] [nvarchar](50) NULL,
[ParentNameGroup] [nvarchar](50) NULL,
[IsConstituent] [nvarchar](10) NULL,
[ConstituentRecordNo] [nvarchar](50) NULL,
[BirthDate] [datetime2](7) NULL,
[ConstituentClassYr] [nvarchar](50) NULL,
[IsFaculty] [nvarchar](10) NULL,
[FacultyID] [nvarchar](50) NULL,
[FacultyDeptID] [nvarchar](50) NULL,
[FacultyDepartment] [nvarchar](100) NULL,
[FacultyJobTitle] [nvarchar](100) NULL,
[FacultyInternalTelNo] [nvarchar](50) NULL,
[FacultyHireDate] [datetime2](7) NULL,
[IsStudent] [nvarchar](10) NULL,
[StudentEmail] [nvarchar](250) NULL,
[WebUserID] [nvarchar](100) NULL,
[WebUserNo] [nvarchar](50) NULL,
[IsLDAPAuthenticated] [nvarchar](10) NULL,
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
SELECT [EntityNo],[Title],[FirstName],[MiddleName],[LastName],[Suffix],[PrefferedName],[FullName],[Gender],[IsParent],[FamilyID],[HouseholdID],[ParentType],[ParentNameGroup],[IsConstituent],[ConstituentRecordNo],[BirthDate],[ConstituentClassYr],[IsFaculty],[FacultyID],[FacultyDeptID],[FacultyDepartment],[FacultyJobTitle],[FacultyInternalTelNo],[FacultyHireDate],[IsStudent],[StudentEmail],[WebUserID],[WebUserNo],[IsLDAPAuthenticated],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy]
FROM
	(
	SELECT [EntityNo],[Title],[FirstName],[MiddleName],[LastName],[Suffix],[PrefferedName],[FullName],[Gender],[IsParent],[FamilyID],[HouseholdID],[ParentType],[ParentNameGroup],[IsConstituent],[ConstituentRecordNo],[BirthDate],[ConstituentClassYr],[IsFaculty],[FacultyID],[FacultyDeptID],[FacultyDepartment],[FacultyJobTitle],[FacultyInternalTelNo],[FacultyHireDate],[IsStudent],[StudentEmail],[WebUserID],[WebUserNo],[IsLDAPAuthenticated],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],@EndDate [RecordEndDate]
	FROM [ods].[SeniorSystems_persons] t
	UNION ALL
	SELECT [EntityNo],[Title],[FirstName],[MiddleName],[LastName],[Suffix],[PrefferedName],[FullName],[Gender],[IsParent],[FamilyID],[HouseholdID],[ParentType],[ParentNameGroup],[IsConstituent],[ConstituentRecordNo],[BirthDate],[ConstituentClassYr],[IsFaculty],[FacultyID],[FacultyDeptID],[FacultyDepartment],[FacultyJobTitle],[FacultyInternalTelNo],[FacultyHireDate],[IsStudent],[StudentEmail],[WebUserID],[WebUserNo],[IsLDAPAuthenticated],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate]
	FROM [ods].[Snapshot_SeniorSystems_persons]
	) a
WHERE
	@AsOfDate BETWEEN [ETL_UpdatedOn] AND [RecordEndDate]
	AND [ETL_CreatedOn] <= @AsOfDate

RETURN

END
GO
