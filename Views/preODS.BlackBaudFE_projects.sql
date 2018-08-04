SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [preODS].[BlackBaudFE_projects]
AS

SELECT DISTINCT
	CONVERT(NVARCHAR(50),[project-id]) [project_id_K]
	,CONVERT(NVARCHAR(MAX),[description]) [description]
	,CONVERT(NVARCHAR(100),[ui-project-id]) [ui_project_id]
	,CONVERT(datetime2,[start-date]) [start-date]
	,CONVERT(datetime2,[end-date]) [end-date]
	,CONVERT(NVARCHAR(100),[location]) [location]
	,CONVERT(NVARCHAR(100),[division]) [division]
	,CONVERT(NVARCHAR(100),[department]) [department]
	,CONVERT(NVARCHAR(25),[status]) [status]
	,CONVERT(datetime2,[date-added]) [date-added]
	,CONVERT(datetime2,[date-modified]) [date-modified]
	,CONVERT(NVARCHAR(50),[added-by]) [added-by]
	,CONVERT(NVARCHAR(50),[modified-by]) [modified-by]
FROM [src].[BlackBaudFE_projects] WITH (NOLOCK)
GO
