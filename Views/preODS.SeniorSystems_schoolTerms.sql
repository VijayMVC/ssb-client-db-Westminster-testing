SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [preODS].[SeniorSystems_schoolTerms]
AS

SELECT DISTINCT
	CONVERT(NVARCHAR(50),x.[Name]) [Name_K]
	,CONVERT(NVARCHAR(50),x.[TermID]) [TermID_K]
	,CONVERT(NVARCHAR(50),x.[Abbreviation]) [Abbreviation]
	,CONVERT(NVARCHAR(50),x.[SchoolID]) [SchoolID_K]
	,CONVERT(INT,CASE WHEN NextYear ='nextYear=False' THEN ISNULL(y.CurrentYear,2018) 
			WHEN NextYear ='nextYear=True' THEN ISNULL(y.CurrentYear + 1,2019) END) CurrentYear_K
	FROM (
		SELECT DISTINCT
			[Name]
			, [Abbreviation]
			, [TermID]
			, [SchoolID]
			,(SELECT TOP 1 * FROM STRING_SPLIT(a.[ETL__multi_query_value_for_audit],'|' ) WHERE value LIKE 'nextYear=%') NextYear
			,(SELECT TOP 1 * FROM STRING_SPLIT(a.[ETL__multi_query_value_for_audit],'|' ) WHERE ISDATE(TRY_CAST(value AS DATETIME))=1) PullDate
		FROM [src].SeniorSystems_schoolTerms A WITH (NOLOCK)
		) x
LEFT JOIN ods.SeniorSystems_schoolCurrentAcademicYear y
	ON x.PullDate = y.Pull_Date
GO
