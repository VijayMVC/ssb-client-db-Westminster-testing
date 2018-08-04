SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE VIEW [preODS].[BlackBaud_campaigns]
AS

SELECT DISTINCT
	CONVERT(INT,[CampaingID]) [CampaignID_K]
	,CONVERT(DATETIME2,[DateAdded]) [DateAdded]
	,CONVERT(DATETIME2,[DateModified]) [DateModified]
	,CONVERT(NVARCHAR(MAX),[Description]) [Description]
	,CONVERT(BIT,[Inactive]) [Inactive]
	,CONVERT(NVARCHAR(50),[lookupID]) [lookupID]
	,CONVERT(DATETIME2,[StartDate]) [StartDate]
	,CONVERT(FLOAT,[GoalValue]) [GoalValue]
FROM [src].[BlackBaud_campaigns] WITH (NOLOCK)

GO
