SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[Queue_RE_FirstName]
	@IssueID	INT 
AS

--[dbo].[Queue_RE_MiddleName]  61193

SELECT  'RaisersEdge' APIName, 'Constituent' APIEntity, 'Constituents' EndpointName, i.Constituent_ID SourceID 
				,(SELECT b.FirstName AS [first]  FROM dbo.BizRule_Issues a 
				JOIN dbo.DimCustomer b ON a.EntityNo = b.SSID AND b.SourceSystem = 'SeniorSystems'
				WHERE IssueID = @IssueID
				FOR JSON PATH, WITHOUT_ARRAY_WRAPPER) json_payload
	,'patch' htmlAction 
	,'First Name' Description
	,i.IssueID
FROM dbo.BizRule_Issues i --WHERE i.BizRuleSubscriptionSK = 21
WHERE i.IssueID = @IssueID
GO
