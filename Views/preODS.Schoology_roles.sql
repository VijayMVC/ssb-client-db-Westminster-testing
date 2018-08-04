SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [preODS].[Schoology_roles]
AS

SELECT DISTINCT
	CONVERT(NVARCHAR(50),[role_id]) [role_id_K]
	,CONVERT(NVARCHAR(100),[role_title]) [role_title]
	,CONVERT(int,[role_faculty]) [role_faculty]
FROM [src].[Schoology_roles] WITH (NOLOCK)
GO
