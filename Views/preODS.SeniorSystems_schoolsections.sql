SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE VIEW [preODS].[SeniorSystems_schoolsections]
AS

SELECT 
	SectionID SectionID_K
	,MeetsPeriod
	,MeetsLength
	,MeetsGradeSeq
	,SchoolID
	,SchoolName
	,CourseID
	,CourseName
	,FullName
	,Abbreviation
	,Description
	,GradeLevel
	,Department_DepartmentID
	,Department_Name	
		,CONVERT(INT,CASE WHEN NextYear ='nextYear=False' THEN ISNULL(y.CurrentYear,2018) 
			WHEN NextYear ='nextYear=True' THEN ISNULL(y.CurrentYear + 1,2019) END) CurrentYear_K
FROM (
		SELECT 
			CONVERT(NVARCHAR(50),[SectionID]) [SectionID]
			,CONVERT(NVARCHAR(50),[MeetsPeriod]) [MeetsPeriod]
			,CONVERT(NVARCHAR(10),[MeetsLength]) [MeetsLength]
			,CONVERT(NVARCHAR(10),[MeetsGradeSeq]) [MeetsGradeSeq]
			,CONVERT(NVARCHAR(10),[SchoolID]) [SchoolID]
			,CONVERT(NVARCHAR(50),[SchoolName]) [SchoolName]
			,CONVERT(NVARCHAR(50),[CourseID]) [CourseID]
			,CONVERT(NVARCHAR(250),[CourseName]) [CourseName]
			,CONVERT(NVARCHAR(500),[FullName]) [FullName]
			,CONVERT(NVARCHAR(50),[Abbreviation]) [Abbreviation]
			,CONVERT(NVARCHAR(MAX),[Description]) [Description]
			,CONVERT(NVARCHAR(10),[GradeLevel]) [GradeLevel]
			,MAX(CONVERT(NVARCHAR(50),[Department_DepartmentID])) [Department_DepartmentID]
			,MAX(CONVERT(NVARCHAR(250),[Department_Name])) [Department_Name]
			--,CONVERT(NVARCHAR(MAX),[MeetTerms_TermID]) [MeetTerms_TermID]
			--,CONVERT(NVARCHAR(MAX),[MeetTerms_Name]) [MeetTerms_Name]
			--,CONVERT(NVARCHAR(MAX),[MeetTerms_Abbreviation]) [MeetTerms_Abbreviation]
			--,CONVERT(NVARCHAR(MAX),[MeetTerms_SchoolID]) [MeetTerms_SchoolID]
			,(SELECT TOP 1 * FROM STRING_SPLIT(a.[ETL__multi_query_value_for_audit],'|' ) WHERE value LIKE 'nextYear=%') NextYear
			,(SELECT TOP 1 * FROM STRING_SPLIT(a.[ETL__multi_query_value_for_audit],'|' ) WHERE ISDATE(TRY_CAST(value AS DATETIME))=1) PullDate
			--select distinct [MeetTerms_Name]
		FROM [src].[SeniorSystems_schoolsections] a WITH (NOLOCK)
		GROUP BY 
			CONVERT(NVARCHAR(50),[SectionID]) 
			,CONVERT(NVARCHAR(50),[MeetsPeriod]) 
			,CONVERT(NVARCHAR(10),[MeetsLength]) 
			,CONVERT(NVARCHAR(10),[MeetsGradeSeq]) 
			,CONVERT(NVARCHAR(10),[SchoolID]) 
			,CONVERT(NVARCHAR(50),[SchoolName]) 
			,CONVERT(NVARCHAR(50),[CourseID]) 
			,CONVERT(NVARCHAR(250),[CourseName]) 
			,CONVERT(NVARCHAR(500),[FullName]) 
			,CONVERT(NVARCHAR(50),[Abbreviation]) 
			,CONVERT(NVARCHAR(MAX),[Description]) 
			,CONVERT(NVARCHAR(10),[GradeLevel]) 
			,[ETL__multi_query_value_for_audit]
		) x
LEFT JOIN ods.SeniorSystems_schoolCurrentAcademicYear y
	ON x.PullDate = y.Pull_Date
	AND x.SchoolID = y.CurrentSchool
GO
