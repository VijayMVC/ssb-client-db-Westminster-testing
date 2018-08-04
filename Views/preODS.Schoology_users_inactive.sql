SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [preODS].[Schoology_users_inactive]
AS

SELECT DISTINCT
	CONVERT(NVARCHAR(50),[uid]) [uid_K]
	,CONVERT(NVARCHAR(250),[name]) [name]
	,CONVERT(NVARCHAR(50),[school-uid]) [school_uid]
	,CONVERT(INT,[synced]) [synced]
	,CONVERT(NVARCHAR(50),[inactive-timestamp]) [inactive_timestamp]
	,CONVERT(NVARCHAR(50),[modified-by-uid]) [modified_by_uid]
FROM [src].[Schoology_users_inactive] WITH (NOLOCK)
GO
