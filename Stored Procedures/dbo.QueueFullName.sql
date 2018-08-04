SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE PROC [dbo].[QueueFullName] 
	@IssueID	INT 
AS

--[dbo].[QueueFullName]  1

SELECT  'RaisersEdge' APIName, 'Constituent' APIEntity, 'Constituent' EndpointName,i.OtherID SourceID 
				,(SELECT b.FullName AS [name]  FROM dbo.BizRule_Issues a
				JOIN dbo.DimCustomer b ON a.SSID = b.SSID AND a.SourceSystem = b.SourceSystem
				WHERE IssueID = @IssueID
				FOR JSON PATH, WITHOUT_ARRAY_WRAPPER) json_payload
	,'patch' htmlAction 
	,'First Name' Description
	,i.IssueID
FROM dbo.BizRule_Issues i
WHERE i.IssueID = @IssueID

GO
