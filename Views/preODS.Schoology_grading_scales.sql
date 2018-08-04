SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [preODS].[Schoology_grading_scales]
AS

SELECT DISTINCT
	CONVERT(NVARCHAR(50),[ETL__multi_query_value_for_audit]) Section_ID_K
	,CONVERT(NVARCHAR(50),[gradingscale_id]) [gradingscale_id_k]
	,CONVERT(NVARCHAR(100),[title]) [title_K]
	,CONVERT(NVARCHAR(50),[type]) [type]
	,CONVERT(BIT,[auto-averaging]) [auto_averaging]
	,CONVERT(BIT,[hide-numeric]) [hide_numeric]
	,CONVERT(NVARCHAR(50),[Grandingscale_level]) [Grandingscale_level]
	,CONVERT(NVARCHAR(50),COALESCE([grade],points)) [grade_K]
	,CONVERT(FLOAT,[cutoff]) [cutoff]
	,CONVERT(FLOAT,[average]) [average]
	--,CONVERT(float,[points]) [points_K]
	,CONVERT(NVARCHAR(500),[description]) [description]
FROM [src].[Schoology_grading_scales] WITH (NOLOCK)
WHERE [title] IS NOT NULL


GO
