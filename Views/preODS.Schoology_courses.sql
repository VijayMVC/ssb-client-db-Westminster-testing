SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [preODS].[Schoology_courses]
AS

SELECT DISTINCT
	CONVERT(NVARCHAR(50),[course_id]) [course_id_K]
	,CONVERT(NVARCHAR(250),[title]) [title]
	,CONVERT(NVARCHAR(50),[course-code]) [course-code]
	,CONVERT(NVARCHAR(50),[department]) [department]
	,CONVERT(NVARCHAR(MAX),[description]) [description]
	,CONVERT(int,[credits]) [credits]
	,CONVERT(int,[subject-area]) [subject-area]
	,CONVERT(int,[grade-level-range-start]) [grade-level-range-start]
	,CONVERT(int,[grade-level-range-end]) [grade-level-range-end]
	,CONVERT(bit,[synced]) [synced]
	,CONVERT(NVARCHAR(50),[building-id]) [building-id]
FROM [src].[Schoology_courses] WITH (NOLOCK)
GO
