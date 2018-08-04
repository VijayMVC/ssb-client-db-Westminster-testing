SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [preODS].[BlackBaud_funds]
AS

SELECT DISTINCT
	CONVERT(INT,[FundID]) [FundID_K]
	,CONVERT(datetime2,[DateAdded]) [DateAdded]
	,CONVERT(datetime2,[DateModified]) [DateModified]
	,CONVERT(NVARCHAR(MAX),[Description]) [Description]
	,CONVERT(bit,[Inactive]) [Inactive]
	,CONVERT(NVARCHAR(250),[LookupID]) [LookupID]
	,CONVERT(datetime2,[StartDate]) [StartDate]
	,CONVERT(NVARCHAR(250),[Category]) [Category]
	,CONVERT(datetime2,[EndDate]) [EndDate]
	,CONVERT(float,[GoalValue]) [GoalValue]
FROM [src].[BlackBaud_funds] WITH (NOLOCK)
GO
