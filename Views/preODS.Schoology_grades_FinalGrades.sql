SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE VIEW [preODS].[Schoology_grades_FinalGrades]
AS

SELECT DISTINCT-- top 100
	CONVERT(NVARCHAR(50),[ETL__multi_query_value_for_audit]) section_id_K
	,CONVERT(NVARCHAR(50),[final-grade_enrollment-id]) [enrollment_id_K]
	,CONVERT(NVARCHAR(MAX),[final-grade_scale-id]) [final_grade_scale_id]
	--,CONVERT(NVARCHAR(MAX),[grade_enrollment-id]) [grade_enrollment_id]
	--,CONVERT(NVARCHAR(MAX),[grade_assignment-id]) [grade_assignment_id]
	--,CONVERT(NVARCHAR(MAX),[grade_grade]) [grade_grade]
	--,CONVERT(NVARCHAR(MAX),[grade_exception]) [grade_exception]
	--,CONVERT(NVARCHAR(MAX),[grade_max-points]) [grade_max_points]
	--,CONVERT(NVARCHAR(MAX),[grade_is-final]) [grade_is_final]
	--,CONVERT(NVARCHAR(MAX),[grade_timestamp]) [grade_timestamp]
	--,CONVERT(NVARCHAR(MAX),[grade_comment]) [grade_comment]
	--,CONVERT(NVARCHAR(MAX),[grade_comment-status]) [grade_comment_status]
	--,CONVERT(NVARCHAR(MAX),[grade_override]) [grade_override]
	--,CONVERT(NVARCHAR(MAX),[grade_calculated-grade]) [grade_calculated_grade]
	--,CONVERT(NVARCHAR(MAX),[grade_pending]) [grade_pending]
	--,CONVERT(NVARCHAR(MAX),[grade_type]) [grade_type]
	--,CONVERT(NVARCHAR(MAX),[grade_location]) [grade_location]
	--,CONVERT(NVARCHAR(MAX),[grade_scale-id]) [grade_scale_id]
	--,CONVERT(NVARCHAR(MAX),[grade_scale-type]) [grade_scale_type]
	--,CONVERT(NVARCHAR(MAX),[grade_category-id]) [grade_category_id]
	--,CONVERT(NVARCHAR(MAX),[grade_school-uid]) [grade_school_uid]
	,CONVERT(NVARCHAR(50),[final-grade_period_period-id]) [period_id_K]
	,CONVERT(NVARCHAR(50),[final-grade_period_grade]) [grade]
	,CONVERT(NVARCHAR(MAX),[final-grade_period_comment]) [comment]
	,CONVERT(NVARCHAR(50),[final-grade_period_comment-status]) [final_grade_period_comment_status]
	,CONVERT(NVARCHAR(50),[final-grade_period_total-points-possible]) [total_points_possible]
	,CONVERT(NVARCHAR(50),[final-grade_period_total-points-awarded]) [total_points_awarded]
	,CONVERT(NVARCHAR(50),[final-grade_period_override-numeric]) [override_numeric]
	,CONVERT(NVARCHAR(50),[final-grade_period_exception]) [exception]
FROM [src].[Schoology_grades] WITH (NOLOCK)
WHERE [final-grade_enrollment-id] IS NOT NULL AND [final-grade_period_period-id] IS NOT null

GO
