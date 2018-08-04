SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [ods].[SeniorSystems_schoolCurrentAcademicYear]
AS

SELECT DISTINCT
	--ETL__insert_datetime	ETL__multi_query_value_for_audit	json_payload
	CAST((SELECT TOP 1 value FROM STRING_SPLIT( a.ETL__multi_query_value_for_audit,'|') ) AS VARCHAR(50)) CurrentSchool
	, CAST(SUBSTRING(a.json_payload,CHARINDEX('=',a.json_payload)+2,4) AS INT) CurrentYear
	,CAST(a.ETL__insert_datetime AS DATE) Pull_Date
FROM [stg].[SeniorSystems_schoolCurrentAcademicYear] a WITH (NOLOCK)

GO
