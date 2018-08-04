SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [rpt].[prompt_ValidationFieldName] (@TableName varchar(255))
AS



SELECT DISTINCT Name
FROM dbo.BizRule_Subscription
WHERE TableName = @TableName
GO
