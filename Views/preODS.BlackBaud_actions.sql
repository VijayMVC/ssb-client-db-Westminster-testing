SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [preODS].[BlackBaud_actions]
AS

SELECT DISTINCT
	CONVERT(NVARCHAR(50),[ActionId]) [action_id_K]
	,CONVERT(NVARCHAR(50),[constituent-id]) [constituent_id]
	,CONVERT(NVARCHAR(MAX),[category]) [category]
	,CONVERT(datetime2,[date]) [date]
	,CONVERT(NVARCHAR(500),[summary]) [summary]
	,CONVERT(NVARCHAR(100),[type]) [type]
	,CONVERT(NVARCHAR(MAX),[description]) [description]
	,CONVERT(NVARCHAR(10),[completed]) [completed]
	,CONVERT(NVARCHAR(50),[status]) [status]
	,CONVERT(datetime2,[date-added]) [date_added]
	,CONVERT(datetime2,[date-modified]) [date_modified]
	,CONVERT(datetime2,[completed-date]) [completed_date]
	,CONVERT(NVARCHAR(50),[opportunity-id]) [opportunity_id]
FROM [src].[BlackBaud_actions] WITH (NOLOCK)
GO
