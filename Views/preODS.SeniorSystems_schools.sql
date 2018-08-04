SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [preODS].[SeniorSystems_schools]
AS

SELECT DISTINCT
	CONVERT(NVARCHAR(50),[SchoolID]) [SchoolID_K]
	,CONVERT(NVARCHAR(100),[SchoolName]) [SchoolName]
	,CONVERT(NVARCHAR(10),[IsAcademicSchool]) [IsAcademicSchool]
	,CONVERT(NVARCHAR(10),[IsSummerSchool]) [IsSummerSchool]
	,CONVERT(NVARCHAR(10),[CurrentAcademicYear]) [CurrentAcademicYear]
FROM [src].[SeniorSystems_schools] WITH (NOLOCK)
GO
