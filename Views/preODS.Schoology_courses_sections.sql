SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE VIEW [preODS].[Schoology_courses_sections]
AS

SELECT 
	CONVERT(NVARCHAR(50),[section_id]) [section_id_K]
	,CONVERT(NVARCHAR(500),[course-title]) [course_title]
	,CONVERT(NVARCHAR(50),[course-code]) [course_code]
	,CONVERT(NVARCHAR(50),[course-id]) [course_id]
	,CONVERT(NVARCHAR(50),[school-id]) [school_id]
	,CONVERT(NVARCHAR(50),[access-code]) [access_code]
	,CONVERT(NVARCHAR(250),[section-title]) [section_title]
	,CONVERT(NVARCHAR(50),[section-code]) [section_code]
	,CONVERT(NVARCHAR(50),[section-school-code]) [section_school_code]
	,CONVERT(BIT,[synced]) [synced]
	,CONVERT(BIT,[active]) [active]
	,CONVERT(NVARCHAR(MAX),[description]) [description]
	,CONVERT(NVARCHAR(50),[parent-id]) [parent_id]
	,CONVERT(NVARCHAR(2000),[profile-url]) [profile_url]
	,CONVERT(NVARCHAR(200),[location]) [location]
	,CONVERT(NVARCHAR(50),[start-time]) [start_time]
	,CONVERT(NVARCHAR(50),[end-time]) [end_time]
	,CONVERT(NVARCHAR(10),[weight]) [weight]
	,CONVERT(NVARCHAR(10),[admin]) [admin]
	,CONVERT(BIT,MAX([options_weighted-grading-categories])) [options_weighted_grading_categories]
	,CONVERT(BIT,MAX([upload-documents])) [upload_documents]
	,CONVERT(BIT,MAX([create-discussion])) [create_discussion]
	,CONVERT(BIT,MAX([member-post])) [member_post]
	,CONVERT(BIT,MAX([member-post-comment])) [member_post_comment]
	,CONVERT(BIT,MAX([default-grading-scale-id])) [default_grading_scale_id]
	,CONVERT(BIT,MAX([hide-overall-grade])) [hide_overall_grade]
	,CONVERT(BIT,MAX([hide-grading-period-grade])) [hide_grading_period_grade]
	,CONVERT(BIT,MAX([allow-custom-overall-grade])) [allow_custom_overall_grade]
	,CONVERT(BIT,MAX([allow-custom-overall-grade-text])) [allow_custom_overall_grade_text]
	,CONVERT(BIT,MAX([visibility_topics])) [visibility_topics]
	,CONVERT(BIT,MAX([visibility_assignments])) [visibility_assignments]
	,CONVERT(BIT,MAX([visibility_assessments])) [visibility_assessments]
	,CONVERT(BIT,MAX([visibility_new-test-quiz])) [visibility_new_test_quiz]
	,CONVERT(BIT,MAX([visibility_common-assessments])) [visibility_common_assessments]
	,CONVERT(BIT,MAX([visibility_documents])) [visibility_documents]
	,CONVERT(BIT,MAX([visibility_discussion])) [visibility_discussion]
	,CONVERT(BIT,MAX([visibility_album])) [visibility_album]
	,CONVERT(BIT,MAX([visibility_pages])) [visibility_pages]
FROM [src].[Schoology_courses_sections] WITH (NOLOCK)
WHERE [section_id] IS NOT NULL
GROUP BY
	CONVERT(NVARCHAR(50),[section_id]) 
	,CONVERT(NVARCHAR(500),[course-title]) 
	,CONVERT(NVARCHAR(50),[course-code]) 
	,CONVERT(NVARCHAR(50),[course-id]) 
	,CONVERT(NVARCHAR(50),[school-id]) 
	,CONVERT(NVARCHAR(50),[access-code]) 
	,CONVERT(NVARCHAR(250),[section-title]) 
	,CONVERT(NVARCHAR(50),[section-code]) 
	,CONVERT(NVARCHAR(50),[section-school-code]) 
	,CONVERT(BIT,[synced]) 
	,CONVERT(BIT,[active]) 
	,CONVERT(NVARCHAR(MAX),[description]) 
	,CONVERT(NVARCHAR(50),[parent-id]) 
	,CONVERT(NVARCHAR(2000),[profile-url]) 
	,CONVERT(NVARCHAR(200),[location]) 
	,CONVERT(NVARCHAR(50),[start-time]) 
	,CONVERT(NVARCHAR(50),[end-time]) 
	,CONVERT(NVARCHAR(10),[weight]) 
	,CONVERT(NVARCHAR(10),[admin])

GO
