SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [preODS].[SeniorSystems_facultySectionsByEntityNo] --where EntityNo_K = 10762
AS

SELECT DISTINCT
	CONVERT(NVARCHAR(50),[ETL__multi_query_value_for_audit]) EntityNo_K
	,CONVERT(INT,[FacultyHierarcy]) [FacultyHierarcy_K]
	,CONVERT(NVARCHAR(50),[SectionID]) [SectionID_K]
	,CAST(ISNULL(y.CurrentYear, 2018)  AS INT) CurrentYear
FROM [src].[SeniorSystems_facultySectionsByEntityNo] a WITH (NOLOCK)
CROSS JOIN (SELECT MAX(ETL__insert_datetime) DT FROM  working.SeniorSystems_facultySectionsByEntityNo ) x
LEFT JOIN ods.SeniorSystems_schoolCurrentAcademicYear y
	ON x.DT = y.Pull_Date
GO
