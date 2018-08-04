SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



CREATE VIEW [preODS].[SeniorSystems_persons]
AS

SELECT DISTINCT
	CONVERT(NVARCHAR(50),[EntityNo]) [EntityNo_K]
	,CONVERT(NVARCHAR(50),[Title]) [Title]
	,CONVERT(NVARCHAR(100),[FirstName]) [FirstName]
	,CONVERT(NVARCHAR(50),[MiddleName]) [MiddleName]
	,CONVERT(NVARCHAR(100),[LastName]) [LastName]
	,CONVERT(NVARCHAR(50),[Suffix]) [Suffix]
	,CONVERT(NVARCHAR(100),[PrefferedName]) [PrefferedName]
	,CONVERT(NVARCHAR(300),[FullName]) [FullName]
	,CONVERT(NVARCHAR(10),[Gender]) [Gender]
	,CONVERT(NVARCHAR(10),[IsParent]) [IsParent]
	,CONVERT(NVARCHAR(50),[FamilyID]) [FamilyID]
	,CONVERT(NVARCHAR(50),[HouseholdID]) [HouseholdID]
	,CONVERT(NVARCHAR(50),[ParentType]) [ParentType]
	,CONVERT(NVARCHAR(50),[ParentNameGroup]) [ParentNameGroup]
	,CONVERT(NVARCHAR(10),[IsConstituent]) [IsConstituent]
	,CONVERT(NVARCHAR(50),[ConstituentRecordNo]) [ConstituentRecordNo]
	,CONVERT(DATETIME2,[BirthDate]) [BirthDate]
	,CONVERT(NVARCHAR(50),[ConstituentClassYr]) [ConstituentClassYr]
	,CONVERT(NVARCHAR(10),[IsFaculty]) [IsFaculty]
	,CONVERT(NVARCHAR(50),[FacultyID]) [FacultyID]
	,CONVERT(NVARCHAR(50),[FacultyDeptID]) [FacultyDeptID]
	,CONVERT(NVARCHAR(100),[FacultyDepartment]) [FacultyDepartment]
	,CONVERT(NVARCHAR(100),[FacultyJobTitle]) [FacultyJobTitle]
	,CONVERT(NVARCHAR(50),[FacultyInternalTelNo]) [FacultyInternalTelNo]
	,CONVERT(DATETIME2,[FacultyHireDate]) [FacultyHireDate]
	,CONVERT(NVARCHAR(10),[IsStudent]) [IsStudent]
	,CONVERT(NVARCHAR(250),[StudentEmail]) [StudentEmail]
	,CONVERT(NVARCHAR(100),[WebUserID]) [WebUserID]
	,CONVERT(NVARCHAR(50),[WebUserNo]) [WebUserNo]
	,CONVERT(NVARCHAR(10),[IsLDAPAuthenticated]) [IsLDAPAuthenticated]
	, 0 IsDeleted
FROM [src].[SeniorSystems_persons] WITH (NOLOCK)


GO
