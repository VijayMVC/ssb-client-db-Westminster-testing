SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

 
CREATE PROCEDURE [dbo].[BizRuleMaster]  
AS 
BEGIN  
/*
Truncate table dbo.[BizRuleBatchLog]
DBCC CHECKIDENT ('dbo.BizRule_Issues',RESEED, 0);  
delete  [dbo].BizRule_Issues-- select * from [dbo].BizRule_Issues where issueid = 4418
TRUNCATE TABLE [dbo].BizRule_Issues_Notes  --select * from [dbo].BizRule_Issues_Notes where issueid = 17676
 */
 

 --https://Westminster.SeniorMBP.com:444/SeniorSystemsWS/UserManagementService.asmx

	SET NOCOUNT ON; 

	DECLARE @BatchSK INT
	DECLARE @RunTime DATETIME = GETDATE() 
	DECLARE @_n int = 0 -- counter 
	DECLARE @_i int = 0 -- counter  
	DECLARE @sql nvarchar(max)  
	DECLARE @BizRuleSK int 
	DECLARE @Proc nvarchar(MAX)

INSERT INTO dbo.[BizRuleBatchLog] ([ExecuteStart])
VALUES ((SELECT [etl].[ConvertToLocalTime](GetDate())))
SET @BatchSK = SCOPE_IDENTITY()
 
 	BEGIN TRY  
/*****************************************************************************************************************
Step One: Update Issues, set completed = 1 where the API outbound process successfully updated the source
******************************************************************************************************************/
	
--Check for Completed Records from OutBound Queue table
	IF OBJECT_ID('tempdb..#APIComplete') IS NOT NULL 
			DROP TABLE #APIComplete  
	CREATE TABLE #APIComplete --TABLE	 
		(IssueID				int,  
		Queue_ProcessDate	datetime) 

--Find newly completed records
	INSERT INTO #APIComplete
	SELECT a.IssueID , Queue_ProcessDate 
		FROM (SELECT IssueID,MAX(Queue_ProcessDate) Queue_ProcessDate FROM etl.API_OutboundQueue
			GROUP BY IssueID
			HAVING COUNT(1) = SUM(CAST(IsCompleted AS INT))
				AND SUM(CAST(IsCompleted AS INT)) > 0) a
		JOIN dbo.BizRule_Issues b ON a.IssueID = b.IssueID
		WHERE b.IssueIsCompleted = 0

	CREATE INDEX IX_apic ON #APIComplete (IssueID)

--Updated IsCompleted flag in the Issues table
	UPDATE a
	SET a.IssueIsCompleted = 1
	,a.Issue_UpdatedOn = b.Queue_ProcessDate
	,a.Issue_UpdatedBy = 'SSB OutBound Integration'
	FROM dbo.BizRule_Issues a --WHERE a.BizRuleSK = 7
	JOIN #APIComplete b 
		ON b.IssueID = a.IssueID


--Log a note that the issue was completed by the Outbound Process
	INSERT INTO dbo.BizRule_Issues_Notes
	(IssueID,NoteText,IsApproval,IsIgnore,Note_CreatedOn,Note_CreatedBy)
	SELECT IssueID, 'Issue Completed by SSB Outbound Integration', 0, 0, Queue_ProcessDate,'SSB OutBound Integration'  FROM #APIComplete
	
	
 /*****************************************************************************************************************
Step Two: Build Temp tables and run all active business rules
******************************************************************************************************************/

	IF OBJECT_ID('tempdb..#BizRules') IS NOT NULL 
		DROP TABLE #BizRules  
	IF OBJECT_ID('tempdb..#RuleResults') IS NOT NULL 
		DROP TABLE #RuleResults 

---------- Temp Tables ---------- 
	CREATE TABLE #RuleResults --TABLE	 
		(ResultID				INT IDENTITY(1,1) NOT NULL,
		SSID					VARCHAR(500), 
		SourceSystem			VARCHAR(100), 
		BizRuleSK				int,  
		BizRuleSubscriptionSK	int,  
		Result					VARCHAR(255) 
		,Constituent_ID			VARCHAR(50)
		,EntityNo				VARCHAR(50)
		,UID					VARCHAR(50)
		,OtherID				VARCHAR(50)
		,SourceOtherID			VARCHAR(50)
		,FieldHash				BINARY(32)) 

	CREATE TABLE #BizRules
		(BizRuleSK		int,  
		ProcName		NVARCHAR(255),   
		SortOrder		int,  
		ProcessFlag		int) 
 
 -- Grab all active business rules (non-multirule)
	INSERT INTO #BizRules 
		(BizRuleSK , 
		ProcName , 
		SortOrder , 
		ProcessFlag)
		
	SELECT BizRuleSK, ProcName, SortOrder, NULL as ProcessFlag 
	FROM dbo.BizRule_Header 
	WHERE ProcName IS NOT NULL  
		AND IsActive = 1 
		AND IsMultiSubRule = 0
	ORDER BY SortOrder 
 
 		
-- # of rules to process 
	SELECT @_n = COUNT(*)  
	FROM #BizRules 
		 
--- loop through each rule, pass batch to appropriate sproc and capture results  
		WHILE @_i < @_n 
		BEGIN  
 
			SELECT TOP(1) @BizRuleSK =  BizRuleSK  
						, @Proc = ProcName 
			FROM #BizRules 
			WHERE ProcessFlag IS NULL  
			ORDER BY SortOrder asc 
 
			set @sql = 'EXEC ' + @Proc + ' @BizRuleSK = ' + cast(@BizRuleSK as varchar(5)) 
		 --PRINT @sql

			INSERT INTO #RuleResults (SSID,SourceSystem,BizRuleSK,BizRuleSubscriptionSK,Result,Constituent_ID,EntityNo,UID,OtherID,SourceOtherID,FieldHash)
			exec(@sql) 																					
 																											
			UPDATE #BizRules 
			SET ProcessFlag = 1 
			WHERE BizRuleSK = @BizRuleSK 
 
			SET @_i = @_i + 1 
 
		END	 

-- Run multi-sub value field validations

TRUNCATE TABLE dbo.BizRule_SingleValidationResults 

TRUNCATE TABLE #BizRules
 -- Grab all active business rules (multirule)
	INSERT INTO #BizRules 
		(BizRuleSK , 
		ProcName , 
		SortOrder , 
		ProcessFlag)		
	SELECT BizRuleSK, ProcName, SortOrder, NULL as ProcessFlag 
	FROM dbo.BizRule_Header 
	WHERE ProcName IS NOT NULL  
		AND IsActive = 1 
		AND IsMultiSubRule = 1
	ORDER BY SortOrder 

	-- # of rules to process 
	SET @_i = 0
	SELECT @_n = COUNT(*)  
	FROM #BizRules 
		 
--- loop through each rule, pass batch to appropriate sproc and capture results  
		WHILE @_i < @_n 
		BEGIN  
 
			SELECT TOP(1) @BizRuleSK =  BizRuleSK  
						, @Proc = ProcName 
			FROM #BizRules 
			WHERE ProcessFlag IS NULL  
			ORDER BY SortOrder asc 
 
			set @sql = 'EXEC ' + @Proc + ' @BizRuleSK = ' + cast(@BizRuleSK as varchar(5)) 
		 --PRINT @sql

			--INSERT INTO #RuleResults (SSID,SourceSystem,BizRuleSK,BizRuleSubscriptionSK,Result,Constituent_ID,EntityNo,UID,OtherID,SourceOtherID,FieldHash)
			exec(@sql) 																					
 																											
			UPDATE #BizRules 
			SET ProcessFlag = 1 
			WHERE BizRuleSK = @BizRuleSK 
 
			SET @_i = @_i + 1 
 
		END	 

		
	INSERT #RuleResults (SSID,SourceSystem,BizRuleSK,BizRuleSubscriptionSK,Result,OtherID,Constituent_ID,EntityNo,UID,FieldHash)
	SELECT SSID,SourceSystem,BizRuleSK,BizRuleSubscriptionSK,Result,OtherID,Constituent_ID,EntityNo,UID,FieldHash  FROM dbo.BizRule_SingleValidationResults 

	TRUNCATE TABLE dbo.BizRule_SingleValidationResults 

 /*****************************************************************************************************************
Step Three: Merge temp results from this run into the BizRules_Issues table
******************************************************************************************************************/	
	
---Update Results table in order to determine the next action add ResultAction and MatchingIssueID columns
	ALTER TABLE #RuleResults ADD ResultAction	varchar(255)
	, MatchingIssueID INT --update #RuleResults set ResultAction = null

	UPDATE rr SET ResultAction = CASE WHEN bri.IssueID IS NULL	THEN 'Insert'
										WHEN bri.IssueIsCompleted = 1 AND bri.FieldHash = rr.FieldHash THEN 'Do Nothing'
										WHEN bri.IssueIsCompleted = 1 AND bri.FieldHash <> rr.FieldHash THEN 'Insert'
										WHEN bri.IssueIsIgnore = 1 and bri.FieldHash <> rr.FieldHash THEN 'Close Old Issue and Open New'
										WHEN bri.FieldHash = rr.FieldHash THEN 'Update Issue_UpdatedOn Date'
										WHEN bri.FieldHash <> rr.FieldHash THEN 'Update UpdateHash and update UpdateHash'
									END
				,MatchingIssueID = bri.IssueID
	FROM #RuleResults rr
			--Only pull the most recent Issue with the primary key
	LEFT OUTER JOIN (SELECT *, ROW_NUMBER() OVER(PARTITION BY SSID, SourceSystem, BizRuleSK, BizRuleSubscriptionSK ORDER BY IssueID DESC) RN FROM [dbo].BizRule_Issues ) bri
		ON rr.SSID = bri.SSID AND bri.SourceSystem = rr.SourceSystem AND bri.BizRuleSK = rr.BizRuleSK AND bri.BizRuleSubscriptionSK = rr.BizRuleSubscriptionSK
			AND bri.rn = 1
	

	CREATE INDEX IX_RulesResuls ON #RuleResults (MatchingIssueID)

--Update existing issues based on the determined action
	UPDATE bri 
		SET bri.Issue_UpdatedOn = GETDATE()
		,bri.Issue_UpdatedBy = 'SSB Biz Rule Engine'
		,bri.FieldHash = CASE WHEN rr.ResultAction = 'Update UpdateHash and update UpdateHash' THEN rr.FieldHash ELSE bri.FieldHash END
		,bri.IssueIsCompleted = CASE WHEN rr.ResultAction = 'Close Old Issue and Open New' THEN 1 ELSE bri.IssueIsCompleted END
		,bri.OtherID = rr.OtherID
		,bri.SourceOtherID = rr.SourceOtherID
		,bri.Constituent_ID = rr.Constituent_ID
		,bri.EntityNo = rr.EntityNo
	FROM #RuleResults rr
	INNER JOIN [dbo].BizRule_Issues bri 
		ON rr.MatchingIssueID = bri.IssueID
		WHERE rr.ResultAction IN ('Close Old Issue and Open New','Update Issue_UpdatedOn Date','Update UpdateHash and update UpdateHash')

	
--Insert new issues when required
	INSERT INTO dbo.BizRule_Issues(
		SSID
		,SourceSystem
		,BizRuleSK
		,BizRuleSubscriptionSK
		,Constituent_ID
		,EntityNo
		,UID
		,OtherID
		,SourceOtherID
		,FieldHash
		,Issue_CreatedBy
		,Issue_UpdatedBy)
	SELECT SSID
		,SourceSystem
		,BizRuleSK
		,BizRuleSubscriptionSK
		,Constituent_ID
		,EntityNo
		,UID
		,OtherID
		,SourceOtherID
		,FieldHash
		,'SSB Biz Rule Engine'
		,'SSB Biz Rule Engine'
	FROM #RuleResults 
	WHERE ResultAction IN ('Insert','Close Old Issue and Open New')
	AND BizRuleSK <> 17
		
--Insert notes to decribe the above actions that just occured

	INSERT INTO dbo.BizRule_Issues_Notes
		(IssueID
		,NoteText
		,Note_CreatedBy)
	SELECT 
		MatchingIssueID
		,CASE ResultAction	
				WHEN  'Close Old Issue and Open New' THEN 'Ignored Issue Closed, new data detected for the same business rule'
				WHEN  'Update UpdateHash and update UpdateHash' THEN 'Issue is still open but the data has changed'
			END
		,'SSB Biz Rule Engine'
	FROM #RuleResults rr
	WHERE rr.ResultAction IN ('Close Old Issue and Open New','Update UpdateHash and update UpdateHash')

	INSERT INTO dbo.BizRule_Issues_Notes
		(IssueID
		,NoteText
		,Note_CreatedBy)
	SELECT 
		bri.IssueID
		,CASE ResultAction
				WHEN 'Insert' THEN 'Issue first detected'
				WHEN 'Close Old Issue and Open New' THEN 'New Issue created -- Data changed on a previously ignored rule'
			END
		,'SSB Biz Rule Engine'
	FROM #RuleResults rr
	INNER JOIN dbo.BizRule_Issues bri
		ON rr.SSID = bri.SSID AND bri.SourceSystem = rr.SourceSystem 
		AND bri.BizRuleSK = rr.BizRuleSK AND bri.BizRuleSubscriptionSK = rr.BizRuleSubscriptionSK
		AND bri.IssueIsCompleted = 0
	WHERE rr.ResultAction IN ('Insert','Close Old Issue and Open New') 

	
 /*****************************************************************************************************************
Step Four: Final cleanup - Check for open Issues that are no longer detected
******************************************************************************************************************/	

	DECLARE @Cleanup TABLE (IssueID INT)

	INSERT INTO @Cleanup
	SELECT IssueID 
	FROM dbo.BizRule_Issues bri --WHERE IssueID = 986
	LEFT OUTER JOIN #RuleResults rr
		ON rr.SSID = bri.SSID AND bri.SourceSystem = rr.SourceSystem 
		AND bri.BizRuleSK = rr.BizRuleSK AND bri.BizRuleSubscriptionSK = rr.BizRuleSubscriptionSK
		WHERE bri.IssueIsCompleted = 0
		AND rr.ResultID IS NULL

	UPDATE dbo.BizRule_Issues
	SET Issue_UpdatedOn = GETDATE()
		,Issue_UpdatedBy = 'SSB Biz Rule Engine'
		,IssueIsCompleted = 1
	WHERE IssueID IN (SELECT IssueID FROM @Cleanup)

	INSERT INTO dbo.BizRule_Issues_Notes
		(IssueID
		,NoteText
		,Note_CreatedBy)
	SELECT 
		IssueID
		,'Issue no longer detected - may have been resolved by a manual update'
		,'SSB Biz Rule Engine'
	FROM @Cleanup
	

--Load logi table
EXEC [dbo].[BizRuleMaster_Populate_LogiTable]  			 


	 UPDATE dbo.[BizRuleBatchLog] SET ExecuteEnd = (SELECT [etl].[ConvertToLocalTime](GetDate())) WHERE ID = @BatchSK
		 
	END TRY  
 
	BEGIN CATCH 
 
		DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE(); 
		DECLARE @ErrorSeverity INT = ERROR_SEVERITY(); 
		DECLARE @ErrorState INT = ERROR_STATE(); 
		                     
		PRINT @ErrorMessage 
 
		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState) 
 
	END CATCH 


 
END 
GO
