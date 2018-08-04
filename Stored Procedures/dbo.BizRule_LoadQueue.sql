SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[BizRule_LoadQueue]  
AS 



--Read the results from the approvals workflow
UPDATE i
SET i.IssueIsApproved = CASE WHEN l.Logi_Approval IS NOT NULL THEN l.Logi_Approval ELSE i.IssueIsApproved END
,i.IssueIsIgnore = CASE WHEN l.Logi_Ignore IS NOT NULL THEN l.Logi_Ignore ELSE i.IssueIsIgnore END
FROM dbo.BizRule_Issues i 
JOIN dbo.BizRule_Issues_Logi l
	ON l.IssueID = i.IssueID
WHERE (ISNULL(i.IssueIsApproved,0) <> ISNULL(l.Logi_Approval,0) AND l.Logi_Approval IS NOT NULL)
	OR (ISNULL(i.IssueIsIgnore,0) <> ISNULL(l.Logi_Ignore,0) AND l.Logi_Ignore IS NOT NULL)
	

--Update the Queue table to remove Issues that are already completed
UPDATE q
SET q.IsCompleted = 1 
FROM etl.API_OutboundQueue q
JOIN dbo.BizRule_Issues i
	ON q.IssueID = i.IssueID
WHERE i.IssueIsCompleted = 1 AND q.IsCompleted = 0


IF OBJECT_ID('tempdb..#ApprovedIssues') IS NOT NULL
	DROP TABLE #ApprovedIssues

	CREATE TABLE #ApprovedIssues --TABLE	 
		(ID				INT IDENTITY(1,1) NOT NULL,
		IssueID					INT,
		QueueProcedure			NVARCHAR(MAX), 
		IsAttempted				BIT,  
		IsCompleted				BIT,
		Json_payload			NVARCHAR(MAX),
		InQueue					BIT)

IF OBJECT_ID('tempdb..#TempQueue') IS NOT NULL
	DROP TABLE #TempQueue

	CREATE TABLE #TempQueue --TABLE	 
		(APIName		VARCHAR(100)
		,APIEntity		VARCHAR(100)
		,EndpointName	VARCHAR(100)
		,SourceID		VARCHAR(100)
		,json_payload	NVARCHAR(MAX)
		,httpAction		NVARCHAR(200)
		,Description	VARCHAR(MAX)
		,IssueID		INT)

INSERT INTO #ApprovedIssues
SELECT i.IssueID,s.QueueProcedure, q.IsAttempted, q.IsCompleted  , q.Json_payload, CASE WHEN q.IssueID IS NOT NULL THEN 1 ELSE 0 END InQueue
FROM dbo.BizRule_Issues i
JOIN dbo.BizRule_Subscription s
	ON i.BizRuleSubscriptionSK = s.BizRuleSubscriptionSK
LEFT JOIN etl.API_OutboundQueue q
	ON i.IssueID = q.IssueID
WHERE i.IssueIsCompleted = 0 AND (i.IssueIsApproved = 1 OR s.RequiresReview = 0)
AND s.IsOutboundRule = 1 AND s.QueueProcedure IS NOT NULL


	DECLARE @_n int 
	DECLARE @_i int = 1
	DECLARE @sql nvarchar(max)  
	DECLARE @Proc nvarchar(MAX)
	DECLARE @IssueID int
-- # of rules to process 
	SELECT @_n =(SELECT MAX(ID) FROM #ApprovedIssues)
		 
--- loop through each rule, pass batch to appropriate sproc and capture results  
		WHILE @_i <= @_n 
		BEGIN  
 
			SELECT @Proc = QueueProcedure 
			,@IssueID = IssueID
			FROM #ApprovedIssues 
			WHERE ID = @_i
 
			set @sql = 'EXEC ' + @Proc + ' @IssueID = ' + cast(@IssueID as varchar(10)) 
		 --PRINT @sql

			INSERT INTO #TempQueue (APIName,APIEntity,EndpointName,SourceID,json_payload,httpAction,Description,IssueID)
			exec(@sql) 																					
 																										
 
			SET @_i = @_i + 1 
 
		END	 

		ALTER TABLE #TempQueue ADD QueueAction VARCHAR(100)

		UPDATE a 
		SET QueueAction = CASE WHEN b.InQueue = 0 THEN 'Insert'
								WHEN b.IsCompleted = 1 THEN 'Queue shows complete but issue still detected'
								WHEN ISNULL(b.IsCompleted,0) = 0 AND a.json_payload = b.json_payload THEN 'Update Queue_UpdatedOn date'
								WHEN ISNULL(b.IsCompleted,0) = 0 AND a.json_payload <> b.json_payload THEN 'Update json_payload'
							END
		FROM #TempQueue a
		JOIN #ApprovedIssues b 
			ON a.IssueID = b.IssueID


--Update existing queue records based on the determined action
	UPDATE oq 
		SET oq.Queue_UpdatedOn = GETDATE()
		,oq.Queue_UpdatedBy = 'SSB OutBound Queue Process'
		,oq.json_payload = CASE WHEN QueueAction = 'Update json_payload' THEN tq.json_payload ELSE oq.Json_Payload END
		,oq.IsCompleted = CASE WHEN QueueAction = 'Queue shows complete but issue still detected' THEN 0 ELSE oq.IsCompleted END
		--select * 
	FROM #TempQueue tq
	INNER JOIN etl.API_OutboundQueue oq
		ON tq.IssueID = oq.IssueID
		WHERE tq.QueueAction IN ('Update Queue_UpdatedOn date','Update json_payload','Queue shows complete but issue still detected')

	
--Insert new issues to the queue when required
	INSERT INTO etl.API_OutboundQueue
		(APIName
		,APIEntity
		,EndpointName
		,SourceID
		,Json_Payload
		,httpAction
		,Description
		,IssueID
		,Queue_CreatedBy
		,Queue_UpdatedBy)
	SELECT APIName
		,APIEntity
		,EndpointName
		,SourceID
		,Json_Payload
		,httpAction
		,Description
		,IssueID
		,'SSB OutBound Queue Process'
		,'SSB OutBound Queue Process'
	FROM #TempQueue 
	WHERE QueueAction IN ('Insert')
		
--Insert notes to decribe the above actions that just occured

	INSERT INTO dbo.BizRule_Issues_Notes
		(IssueID
		,NoteText
		,Note_CreatedBy)
	SELECT 
		IssueID
		,CASE QueueAction	
				WHEN  'Insert' THEN 'Issue first added to the outbound queue'
				WHEN  'Update Queue_UpdatedOn date' THEN 'Issue was already in the queue and nothing has changed'
				WHEN  'Update json_payload' THEN ' Issue was already in the queue and not completed.  The json_payload has been updated'
				WHEN 'Queue shows complete but issue still detected' THEN 'Issued had a completed status in the Queue but the issue was not resolved. Resetting the IsCompleted flag in etl.API_OutboundQueue'
			END
		,'SSB OutBound Queue Process'
	FROM #TempQueue 

 
GO
