SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE VIEW [preODS].[Schoology_grade_items]
AS

SELECT DISTINCT
	CONVERT(NVARCHAR(50),[ETL__multi_query_value_for_audit]) section_id_K
	,CONVERT(NVARCHAR(50),[assignment_id]) [assignment_id_K]
	,CONVERT(NVARCHAR(250),[title]) [title]
	,CONVERT(NVARCHAR(MAX),[description]) [description]
	,CONVERT(NVARCHAR(50),[due]) [due]
	,CONVERT(NVARCHAR(50),[grading-scale]) [grading_scale]
	,CONVERT(NVARCHAR(50),[grading-period]) [grading_period]
	,CONVERT(NVARCHAR(50),[grading-category]) [grading_category]
	,CONVERT(FLOAT,[max-points]) [max_points]
	,CONVERT(float,[factor]) [factor]
	,CONVERT(BIT,[is-final]) [is_final]
	,CONVERT(BIT,[show-comments]) [show_comments]
	,CONVERT(BIT,[grade-stats]) [grade_stats]
	,CONVERT(BIT,[allow-dropbox]) [allow_dropbox]
	,CONVERT(BIT,[allow-discussion]) [allow_discussion]
	,CONVERT(BIT,[published]) [published]
	,CONVERT(NVARCHAR(50),[type]) [type]
	,CONVERT(NVARCHAR(50),[grade-item-id]) [grade_item_id]
	,CONVERT(BIT,[available]) [available]
	,CONVERT(BIT,[completed]) [completed]
	,CONVERT(BIT,[dropbox-locked]) [dropbox_locked]
	,CONVERT(INT,[grading-scale-type]) [grading_scale_type]
	,CONVERT(NVARCHAR(10),[show-rubric]) [show_rubric]
	,CONVERT(INT,[display-weight]) [display_weight]
	,CONVERT(NVARCHAR(50),[folder-id]) [folder_id]
	,CONVERT(INT,[num-assignees]) [num_assignees]
	,CONVERT(NVARCHAR(50),[last-updated]) [last_updated]
	,CONVERT(NVARCHAR(50),[completion-status]) [completion_status]
	,CONVERT(NVARCHAR(50),[topic-id]) [topic_id]
FROM [src].[Schoology_grade_items] WITH (NOLOCK)

GO
