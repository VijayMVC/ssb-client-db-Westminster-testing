SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
 
 
CREATE PROCEDURE [rpt].[p_IssueDetails]  
	@IssueID		INT  
AS
--rpt.p_IssueDetails 72471
 

--DECLARE @IssueID INT = 72471  
IF OBJECT_ID('tempdb..#work') IS NOT NULL
	DROP TABLE #Work

SELECT * INTO #work FROM dbo.BizRule_Issues WHERE IssueID = @IssueID

SET @IssueID = (SELECT CASE WHEN BizRuleSK = 20 THEN Try_Cast(SSID AS BIGINT) ELSE IssueID END FROM #work) 
 
 DECLARE @ExecProc NVARCHAR(MAX) = (SELECT b.OutputProcedure FROM dbo.BizRule_Issues a 
									JOIN dbo.BizRule_Subscription b ON b.BizRuleSubscriptionSK = a.BizRuleSubscriptionSK
									WHERE a.IssueID = @IssueID
									)
 DECLARE @sql NVARCHAR(MAX)
 
			set @sql = 'EXEC ' + @ExecProc + ' @IssueID = ' + cast(@IssueID as varchar(5)) 
		 --PRINT @sql

			exec(@sql) 																					
 																											
		 

GO
