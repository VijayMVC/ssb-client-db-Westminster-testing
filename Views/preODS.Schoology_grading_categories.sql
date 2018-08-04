SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE VIEW [preODS].[Schoology_grading_categories]
AS

SELECT DISTINCT
	CONVERT(NVARCHAR(50),[grading-category_id]) [grading_category_id_K]
	,CONVERT(NVARCHAR(100),[title]) [title]
	,CONVERT(NVARCHAR(50),[delta]) [delta]
	,CONVERT(NVARCHAR(50),[realm]) [realm]
	,CONVERT(NVARCHAR(50),[realm-id]) [section_id_K]
	,CONVERT(INT,[calculation-type]) [calculation_type]
	,CONVERT(FLOAT,[default-max-points]) [default_max_points]
	,CONVERT(NVARCHAR(50),[default-grading-scale-id]) [default_grading_scale_id]
	,CONVERT(INT,[drop-lowest]) [drop_lowest]
	,CONVERT(FLOAT,[weight]) [weight]
FROM [src].[Schoology_grading_categories] WITH (NOLOCK)
WHERE [grading-category_id] IS NOT NULL

GO
