SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
/****** Script for SelectTopNRows command from SSMS  ******/
CREATE PROCEDURE [rpt].[p_FailedBusinessRules2] (@Name varchar(max))
AS
--DECLARE @SQL NVARCHAR(MAX) = ''


--DECLARE
--	@TableName NVARCHAR(MAX),
--	@KeyFieldName NVARCHAR(MAX),
--	@BizRuleSubscriptionSK NVARCHAR(MAX)

--IF OBJECT_ID('tempdb..#WorkingRulesOutput') IS NOT NULL
--	DROP TABLE #WorkingRulesOutput

--IF OBJECT_ID('tempdb..#abc') IS NOT NULL
--	DROP TABLE #abc


--CREATE TABLE #WorkingRulesOutput (
--	[IssueID] [bigint] NOT NULL,
--	[SSID] [varchar](500) NOT NULL,
--	[SourceSystem] [varchar](100) NOT NULL,
--	BizRuleSubscriptionSK INT NOT NULL,
--	BizRulePriority int NULL,
--	BizRuleDesc [nvarchar](MAX) NULL,
--	--[Type] [varchar](50) NULL,
--	[Name] [nvarchar](255) NOT NULL,
--	--[TableName] [nvarchar](255) NULL,
--	KeyFieldName [nvarchar](MAX) NULL,
--	KeyFieldValue [nvarchar](MAX) NULL,
--	[ValidationFieldName] [nvarchar](MAX) NULL,
--	[ValidationFieldValue] [nvarchar](MAX) NULL,
--	[SourceFieldName] [nvarchar](MAX) NULL,
--	[SourceFieldValue] [nvarchar](MAX) NULL,
--	[Issue_OpenedOn] [datetime] NOT NULL,
--	[Issue_UpdatedOn] [datetime] NOT NULL--,
--)



--DECLARE BizRule_Subscription_cursor CURSOR
--FOR 
--	SELECT DISTINCT bsr.BizRuleSubscriptionSK
--	FROM dbo.BizRule_Subscription bsr
--	INNER JOIN dbo.BizRule_Issues bri
--		ON  bri.BizRuleSubscriptionSK = bsr.BizRuleSubscriptionSK
--	WHERE bsr.IsActive = 1 
--	--AND bsr.BizRuleSubscriptionSK = 2

--OPEN BizRule_Subscription_cursor

--FETCH NEXT FROM BizRule_Subscription_cursor
--INTO @BizRuleSubscriptionSK

--WHILE @@FETCH_STATUS = 0
--BEGIN

--		SELECT @SQL = 
--		'
--		INSERT INTO #WorkingRulesOutput (
--			 IssueID
--			,SSID
--			,SourceSystem
--			,BizRuleSubscriptionSK
--			,BizRulePriority
--			,BizRuleDesc
--			--,[Type]
--			,Name
--			--,TableName
--			,KeyFieldName
--			,KeyFieldValue
--			,ValidationFieldName
--			,ValidationFieldValue
--			,SourceFieldName
--			,SourceFieldValue
--			--,IssueIsApproved
--			--,IssueIsIgnore
--			--,IssueIsCompleted
--			,Issue_OpenedOn
--			--,Issue_CreatedBy
--			,Issue_UpdatedOn
--			--,Issue_UpdatedBy
--		)
--		SELECT --top 100
--			 bri.[IssueID]
--			,bri.[SSID]
--			,bri.[SourceSystem]
--			,drs.BizRuleSubscriptionSK
--			,drs.PriorityOrder 
--			,ISNULL(drs.FullDescription,he.FullDescription) FullDescription
--			--,drs.[Type]
--			,drs.[Name]
--			--,drs.[TableName]
--			,ISNULL(drs.OtherID,drs.KeyFieldName) KeyFieldName
--			,ISNULL(t.' + drs.KeyFieldName + ' , t.' + KeyFieldName + ') AS KeyFieldValue
--			,drs.ValidationFieldName
--			,t.' + ValidationFieldName + ' AS ValidationFieldValue
--			,ISNULL(drs.SourceFieldName,'''') SourceFieldName
--			,'+ CASE WHEN drs.IsDimcustomer = 1 THEN 't.' + REPLACE(drs.SourceFieldName,'+ '' '' + ','+ '' '' + t.')
--					WHEN drs.SourceFieldName IS NOT NULL THEN 'st.' + drs.SourceFieldName ELSE '''''' END + ' AS SourceFieldValue
--			--,bri.[IssueIsApproved]
--			--,bri.[IssueIsIgnore]
--			--,bri.[IssueIsCompleted]
--			,bri.[Issue_OpenedOn]
--			--,bri.[Issue_CreatedBy]
--			,bri.[Issue_UpdatedOn]
--			--,bri.[Issue_UpdatedBy]
--		FROM dbo.BizRule_Issues bri
--		INNER JOIN dbo.BizRule_Header he
--			ON  bri.BizRuleSK = he.BizRuleSK
--		INNER JOIN dbo.BizRule_Subscription drs
--			ON  bri.BizRuleSubscriptionSK = drs.BizRuleSubscriptionSK
--		INNER JOIN ' + drs.TableName + ' t
--			ON  bri.' + drs.KeyFieldName + ' = t.' + drs.KeyFieldName + '
--			 AND ' + CASE WHEN drs.OtherID IS NOT NULL THEN 'ISNULL(bri.OtherID,'''') = ISNULL(t.' + drs.OtherID +','''')' ELSE '1=1'END +'
--			 AND ' + CASE WHEN drs.IsDimcustomer = 1 THEN 't.SourceSystem =bri.Sourcesystem' ELSE '1=1'END +
--		+ CASE WHEN drs.SourceTableName IS NOT NULL THEN 
--		'LEFT JOIN ' + drs.SourceTableName + ' st
--			ON  bri.' + drs.SourceKeyFieldName + ' = st.' + drs.SourceKeyFieldName + '
--			 AND ' + CASE WHEN drs.SourceOtherID IS NOT NULL THEN 'ISNULL(bri.SourceOtherID,'''') = ISNULL(st.' + drs.SourceOtherID +','''')' ELSE '1=1'END 
--			 ELSE '' END +'
--		WHERE drs.TableName = ''' + drs.TableName  + '''
--			AND drs.KeyFieldName = ''' +drs.KeyFieldName + '''
--			AND CAST(bri.IssueIsCompleted as int) + CAST(bri.IssueIsApproved as int) +  CAST(bri.IssueIsIgnore as int) = 0
--			AND drs.BizRuleSubscriptionSK = '+@BizRuleSubscriptionSK +''
--		FROM dbo.BizRule_Subscription drs
--		WHERE drs.BizRuleSubscriptionSK = @BizRuleSubscriptionSK


--		PRINT @SQL
--		EXECUTE SP_EXECUTESQL @SQL

--	FETCH NEXT FROM BizRule_Subscription_cursor
--	INTO @BizRuleSubscriptionSK

--END

--CLOSE BizRule_Subscription_cursor;
--DEALLOCATE BizRule_Subscription_cursor;


CREATE TABLE #PromptBizRuleSubSK (BizSK int)
INSERT INTO #PromptBizRuleSubSK select cast(value as int) from string_split(@Name,',')


DECLARE @SelecterdCount INT = (SELECT COUNT(1) FROM #PromptBizRuleSubSK)

SELECT 
	[Group]	
	,[GroupID]
	,IssueID
	,SSID [Source ID]
	,SourceSystem [Source System]
	,BizRuleSubscriptionSK
	,BizRulePriority [Rule Priority]
	,BizRuleDesc [Rule Description]
	,Name	[Rule Name]
	,KeyFieldName	[Key Field Name]
	,KeyFieldValue	[Key Field Value]
	,ValidationFieldName
	,ValidationFieldValue	[Validation Value]
	,SourceFieldName		
	,SourceFieldValue		[Source Value]
	,Issue_OpenedOn			[Issue Opend On]
	,Issue_UpdatedOn		[Issue Last Updated On]
	,Issues
 FROM (
SELECT x.*
,ROW_NUMBER() OVER(PARTITION BY CASE WHEN [Group] = 'Parent' THEN 2 ELSE 1 END, BizRuleSubscriptionSK ORDER BY BizRulePriority, x.IssueID) RN
,ROW_NUMBER() OVER(PARTITION BY CASE WHEN [Group] = 'Parent' THEN 2 ELSE 1 END ORDER BY BizRulePriority, x.IssueID) RN_All
FROM (
SELECT 
	CASE GROUPING_ID(
		IssueID	,SSID	,SourceSystem	,BizRulePriority	,BizRuleDesc
		,Name	,KeyFieldName	,KeyFieldValue	,ValidationFieldName
		,ValidationFieldValue	,SourceFieldName	,SourceFieldValue
		,Issue_OpenedOn	,Issue_UpdatedOn)
		WHEN 0 THEN 'Child'
		ELSE 'Parent' END AS 'Group'
	,GROUPING_ID(
		IssueID	,SSID	,SourceSystem	,BizRulePriority	,BizRuleDesc
		,Name	,KeyFieldName	,KeyFieldValue	,ValidationFieldName
		,ValidationFieldValue	,SourceFieldName	,SourceFieldValue
		,Issue_OpenedOn	,Issue_UpdatedOn) GroupID
	,IssueID
	,SSID
	,SourceSystem
	,BizRuleSubscriptionSK
	,BizRulePriority
	,BizRuleDesc
	--,[Type]
	,Name
	--,TableName
	,KeyFieldName
	,KeyFieldValue
	,ValidationFieldName
	,ValidationFieldValue
	,SourceFieldName
	,SourceFieldValue
	--,IssueIsApproved
	--,IssueIsIgnore
	--,IssueIsCompleted
	,Issue_OpenedOn
	--,Issue_CreatedBy
	,Issue_UpdatedOn
	--,Issue_UpdatedBy
	--,B.DetailRow
	--,b.IssueCount
	--,b.RowType
	,COUNT(IssueID) Issues
FROM dbo.BizRule_Issues_Logi
--FROM #WorkingRulesOutput
WHERE CAST(ISNULL(Logi_Approval,0) AS INT) + CAST(ISNULL(Logi_Ignore,0) AS INT) = 0
--WHERE 1=1 
	and (BizRuleSubscriptionSK IN (SELECT BizSK from #PromptBizRuleSubSK))
--CROSS JOIN #abc B
--AND BizRuleSubscriptionSK = 21
GROUP BY GROUPING SETS ((BizRulePriority,BizRuleDesc,Name),(
	IssueID
	,SSID
	,SourceSystem
	,BizRuleSubscriptionSK
	,BizRulePriority
	,BizRuleDesc
	,Name
	,KeyFieldName
	,KeyFieldValue
	,ValidationFieldName
	,ValidationFieldValue
	,SourceFieldName
	,SourceFieldValue
	,Issue_OpenedOn
	,Issue_UpdatedOn))

) x
)y

WHERE y.[Group] = 'Parent' OR ((@SelecterdCount >1 AND RN  < 6) OR (@SelecterdCount =1 ))

ORDER BY BizRulePriority, [Issue Opend On] DESC
GO
