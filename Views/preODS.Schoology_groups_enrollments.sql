SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [preODS].[Schoology_groups_enrollments]
AS

SELECT DISTINCT
	CONVERT(NVARCHAR(50),[ETL__multi_query_value_for_audit]) Group_ID
	,CONVERT(NVARCHAR(50),[enrollment_id]) [enrollment_id_K]
	,CONVERT(NVARCHAR(50),[uid]) [uid]
	,CONVERT(NVARCHAR(50),[school-uid]) [school_uid]
	,CONVERT(NVARCHAR(50),[name-title]) [name_title]
	,CONVERT(bit,[name-title-show]) [name_title_show]
	,CONVERT(NVARCHAR(100),[name-first]) [name_first]
	,CONVERT(NVARCHAR(100),[name-first-preferred]) [name_first_preferred]
	,CONVERT(bit,[use-preferred-first-name]) [use_preferred_first_name]
	,CONVERT(NVARCHAR(100),[name-middle]) [name_middle]
	,CONVERT(bit,[name-middle-show]) [name_middle_show]
	,CONVERT(NVARCHAR(100),[name-last]) [name_last]
	,CONVERT(NVARCHAR(250),[name-display]) [name_display]
	,CONVERT(bit,[admin]) [admin]
	,CONVERT(bit,[status]) [status]
	,CONVERT(NVARCHAR(500),[picture-url]) [picture_url]
	,CONVERT(NVARCHAR(500),[links_self]) [links_self]
FROM [src].[Schoology_groups_enrollments] WITH (NOLOCK)
GO
