SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[Queue_RE_PreferedName]
	@IssueID	INT 
AS

--[dbo].[Queue_RE_PreferedName]  7621

SELECT  'RaisersEdge' APIName, 'Constituent' APIEntity, 'Constituents' EndpointName, i.SSID SourceID 
				,(SELECT b.SalutationName AS [preferred_name]  FROM dbo.BizRule_Issues a
				JOIN dbo.DimCustomer b ON a.EntityNo = b.SSID AND b.SourceSystem = 'SeniorSystems'
				WHERE IssueID = @IssueID
				FOR JSON PATH, WITHOUT_ARRAY_WRAPPER) json_payload
	,'patch' htmlAction 
	,'Preferred Name' Description
	,i.IssueID
FROM dbo.BizRule_Issues i-- WHERE i.BizRuleSubscriptionSK = 20
WHERE i.IssueID = @IssueID
GO
