SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [preODS].[BlackBaud_appeals]
AS

SELECT DISTINCT
	CONVERT(INT,[AppealID]) [AppealID_K]
	,CONVERT(datetime2,[DateAdded]) [DateAdded]
	,CONVERT(datetime2,[DateModified]) [DateModified]
	,CONVERT(NVARCHAR(MAX),[Description]) [Description]
	,CONVERT(bit,[Inactive]) [Inactive]
	,CONVERT(NVARCHAR(100),[LookupID]) [LookupID]
	,CONVERT(datetime2,[EndDate]) [EndDate]
	,CONVERT(datetime2,[StartDate]) [StartDate]
	,CONVERT(float,[GoalValue]) [GoalValue]
FROM [src].[BlackBaud_appeals] WITH (NOLOCK)
GO
