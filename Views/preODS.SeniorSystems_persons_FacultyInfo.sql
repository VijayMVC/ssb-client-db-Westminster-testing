SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [preODS].[SeniorSystems_persons_FacultyInfo]
AS

SELECT DISTINCT
	CONVERT(NVARCHAR(50),[EntityNo]) [EntityNo]
	,CONVERT(NVARCHAR(50),FacultyInfo_ID) [Faculty_ID_K]
	,CONVERT(NVARCHAR(50),[FacultyInfo_DepartmentID]) [DepartmentID]
	,CONVERT(NVARCHAR(200),[FacultyInfo_DepartmentName]) [DepartmentName]
	,CONVERT(NVARCHAR(100),[FacultyInfo_JobTitle]) [JobTitle]
	,CONVERT(NVARCHAR(50),[FacultyInfo_InternalTelNo]) [InternalTelNo]
	,CONVERT(DATETIME2,[FacultyInfo_HireDate]) [HireDate]
	,CONVERT(NVARCHAR(100),[FacultyInfo_MajorTeachingArea]) [MajorTeachingArea]
	,CONVERT(NVARCHAR(100),[FacultyInfo_MinorTeachingArea]) [MinorTeachingArea]
	,CONVERT(NVARCHAR(100),[FacultyInfo_FacultyType]) [FacultyType]
	,CONVERT(NVARCHAR(100),[FacultyInfo_FacultyStatus]) [FacultyStatus]
	,CONVERT(NVARCHAR(100),[FacultyInfo_ExperienceLevel]) [ExperienceLevel]
	,CONVERT(NVARCHAR(100),[FacultyInfo_Location]) [Location]
	,CONVERT(NVARCHAR(10),[FacultyInfo_IsActive]) [IsActive]
	,CONVERT(NVARCHAR(250),[FacultyInfo_EMail]) [EMail]
	,CONVERT(NVARCHAR(10),[FacultyInfo_DisplayInDirectory]) [DisplayInDirectory]
FROM [src].[SeniorSystems_persons] WITH (NOLOCK)
WHERE ISNULL(FacultyInfo_ID,'') <> ''


GO
