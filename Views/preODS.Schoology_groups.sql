SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [preODS].[Schoology_groups]
AS

SELECT DISTINCT
	CONVERT(NVARCHAR(50),[groupid]) [groupid_K]
	,CONVERT(NVARCHAR(500),[title]) [title]
	,CONVERT(NVARCHAR(MAX),[description]) [description]
	,CONVERT(NVARCHAR(500),[website]) [website]
	,CONVERT(NVARCHAR(250),[access-code]) [access-code]
	,CONVERT(NVARCHAR(100),[category]) [category]
	,CONVERT(NVARCHAR(50),[group-code]) [group_code]
	,CONVERT(NVARCHAR(50),[privacy-level]) [privacy_level]
	,CONVERT(NVARCHAR(MAX),[picture-url]) [picture_url]
	,CONVERT(NVARCHAR(50),[school-id]) [school_id]
	,CONVERT(NVARCHAR(50),[building-id]) [building_id]
FROM [src].[Schoology_groups] WITH (NOLOCK)
where groupid is not null
GO
