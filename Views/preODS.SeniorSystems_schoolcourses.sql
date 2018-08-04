SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE VIEW [preODS].[SeniorSystems_schoolcourses]
AS

SELECT 
	x.SchoolID_K
	,x.CourseID_K
	,x.CourseName
	,x.FullName
	,x.Abbreviation
	,x.Description
	,x.GradeLevel
	,x.DepartmentID
	,x.Department_Name
	,CONVERT(INT,CASE WHEN NextYear ='nextYear=False' THEN ISNULL(y.CurrentYear,2018) 
			WHEN NextYear ='nextYear=True' THEN ISNULL(y.CurrentYear + 1,2019) END) CurrentYear_K 
FROM
		(
		SELECT 
			CONVERT(NVARCHAR(50),[SchoolID]) [SchoolID_K]
			,CONVERT(NVARCHAR(50),[CourseID]) [CourseID_K]
			,CONVERT(NVARCHAR(200),[CourseName]) [CourseName]
			,CONVERT(NVARCHAR(200),[FullName]) [FullName]
			,CONVERT(NVARCHAR(50),[Abbreviation]) [Abbreviation]
			,CONVERT(NVARCHAR(MAX),[Description]) [Description]
			,CONVERT(NVARCHAR(50),[GradeLevel]) [GradeLevel]
			,CONVERT(NVARCHAR(50),[Department_DepartmentID]) [DepartmentID]
			,CONVERT(NVARCHAR(200),[Department_Name]) [Department_Name]
			,(SELECT TOP 1 * FROM STRING_SPLIT(a.[ETL__multi_query_value_for_audit],'|' ) WHERE value LIKE 'nextYear=%') NextYear
			,(SELECT TOP 1 * FROM STRING_SPLIT(a.[ETL__multi_query_value_for_audit],'|' ) WHERE ISDATE(TRY_CAST(value AS DATETIME))=1) PullDate
		FROM [src].[SeniorSystems_schoolcourses] a WITH (NOLOCK)
		)x
LEFT JOIN ods.SeniorSystems_schoolCurrentAcademicYear y
	ON x.PullDate = y.Pull_Date
	AND x.SchoolID_K = y.CurrentSchool

GO
