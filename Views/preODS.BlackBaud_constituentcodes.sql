SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE VIEW [preODS].[BlackBaud_constituentcodes]
AS

SELECT DISTINCT
	CONVERT(NVARCHAR(50),[constiuent_code_id]) [constiuent_code_id_K]
	,CONVERT(NVARCHAR(50),[constituent-id]) [constituent_id]
	,CONVERT(NVARCHAR(250),[description]) [description]
	,CONVERT(DATETIME2,[date-added]) [date_added]
	,CONVERT(DATETIME2,[date-modified]) [date_modified]
	,CONVERT(NVARCHAR(10),[inactive]) [inactive]
	,MAX(TRY_CAST(CONCAT([start_y],'-',[start_m],'-',[start_d]) AS DATE)) StartDate
	,MAX(TRY_CAST(CONCAT([end_y],'-',[end_m],'-',[end_d]) AS DATE)) EndDate
FROM [src].[BlackBaud_constituentcodes] WITH (NOLOCK)
GROUP BY 
	CONVERT(NVARCHAR(50),[constiuent_code_id])
	,CONVERT(NVARCHAR(50),[constituent-id]) 
	,CONVERT(NVARCHAR(250),[description]) 
	,CONVERT(DATETIME2,[date-added]) 
	,CONVERT(DATETIME2,[date-modified]) 
	,CONVERT(NVARCHAR(10),[inactive])
GO
