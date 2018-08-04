SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [preODS].[Schoology_grades]
AS

SELECT DISTINCT --top 100
	CONVERT(NVARCHAR(50),[ETL__multi_query_value_for_audit]) section_id_K
	,CONVERT(NVARCHAR(50),[grade_enrollment-id]) [enrollment_id_K]
	,CONVERT(NVARCHAR(50),[grade_assignment-id]) [assignment_id_K]
	,CONVERT(float,[grade_grade]) [grade]
	,CONVERT(bit,[grade_exception]) [grade_exception]
	,CONVERT(float,[grade_max-points]) [grade_max_points]
	,CONVERT(bit,[grade_is-final]) [grade_is_final]
	,CONVERT(NVARCHAR(50),[grade_timestamp]) [grade_timestamp]
	,CONVERT(NVARCHAR(MAX),[grade_comment]) [grade_comment]
	,CONVERT(int,[grade_comment-status]) [grade_comment_status]
	,CONVERT(bit,[grade_override]) [grade_override]
	,CONVERT(float,[grade_calculated-grade]) [grade_calculated_grade]
	,CONVERT(NVARCHAR(50),[grade_pending]) [grade_pending]
	,CONVERT(NVARCHAR(50),[grade_type]) [grade_type]
	,CONVERT(NVARCHAR(500),[grade_location]) [grade_location]
	,CONVERT(NVARCHAR(50),[grade_scale-id]) [grade_scale_id]
	,CONVERT(NVARCHAR(50),[grade_scale-type]) [grade_scale_type]
	,CONVERT(NVARCHAR(50),[grade_category-id]) [grade_category_id]
	,CONVERT(NVARCHAR(50),[grade_school-uid]) [grade_school_uid]
FROM [src].[Schoology_grades] WITH (NOLOCK)
where [grade_enrollment-id] IS NOT NULL
GO
