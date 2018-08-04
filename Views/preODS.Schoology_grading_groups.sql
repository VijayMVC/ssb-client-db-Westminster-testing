SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [preODS].[Schoology_grading_groups]
AS

SELECT DISTINCT
	CONVERT(NVARCHAR(50),[groups_id]) [groups_id_K]
	,CONVERT(NVARCHAR(200),[title]) [title]
	,CONVERT(NVARCHAR(50),[section-id]) [section_id]
FROM [src].[Schoology_grading_groups] WITH (NOLOCK)
GO
