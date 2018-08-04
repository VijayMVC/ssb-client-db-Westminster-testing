SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
/****** Script for SelectTopNRows command from SSMS  ******/
CREATE PROCEDURE [rpt].[p_FailedBusinessRules]
AS
DECLARE @SQL NVARCHAR(MAX) = ''

DECLARE
	@TableName NVARCHAR(MAX),
	@KeyFieldName NVARCHAR(MAX),
	@BizRuleSubscriptionSK NVARCHAR(MAX)

IF OBJECT_ID('tempdb..#WorkingRulesOutput') IS NOT NULL
	DROP TABLE #WorkingRulesOutput

IF OBJECT_ID('tempdb..#abc') IS NOT NULL
	DROP TABLE #abc


CREATE TABLE #WorkingRulesOutput (
	[IssueID] [bigint] NOT NULL,
	[SSID] [varchar](500) NOT NULL,
	[SourceSystem] [varchar](100) NOT NULL,
	BizRuleName [nvarchar](MAX) NULL,
	BizRuleDesc [nvarchar](MAX) NULL,
	[Type] [varchar](50) NULL,
	[Name] [nvarchar](255) NOT NULL,
	[TableName] [nvarchar](255) NULL,
	KeyFieldName [nvarchar](MAX) NULL,
	KeyFieldValue [nvarchar](MAX) NULL,
	[ValidationFieldName] [nvarchar](MAX) NULL,
	[ValidationFieldValue] [nvarchar](MAX) NULL,
	[SourceFieldName] [nvarchar](MAX) NULL,
	[SourceFieldValue] [nvarchar](MAX) NULL,
	[IssueIsApproved] [bit] NOT NULL,
	[IssueIsIgnore] [bit] NOT NULL,
	[IssueIsCompleted] [bit] NOT NULL,
	[Issue_OpenedOn] [datetime] NOT NULL,
	[Issue_CreatedBy] [nvarchar](200) NOT NULL,
	[Issue_UpdatedOn] [datetime] NOT NULL,
	[Issue_UpdatedBy] [nvarchar](200) NOT NULL--,
	--DetailRow NVARCHAR(max)
)

CREATE TABLE #abc (DetailRow NVARCHAR(max), IssueCount INT, RowType NVARCHAR(15))

INSERT INTO #abc

 SELECT		     'Col0...........COULMN 1..COLUMN2...COLUMN 3', 1, 'Parent'
unioN ALL SELECT 'VAL1............vAL2......V3........VAL4',0,'Child1'
unioN ALL SELECT 'VAL1............AvAL2A....V3A.......VAL4',0,'Child2'

DECLARE BizRule_Subscription_cursor CURSOR
FOR 
	SELECT DISTINCT bsr.TableName, bsr.KeyFieldName, bsr.BizRuleSubscriptionSK
	FROM dbo.BizRule_Subscription bsr
	INNER JOIN dbo.BizRule_Issues bri
		ON  bri.BizRuleSubscriptionSK = bsr.BizRuleSubscriptionSK
	WHERE bsr.IsActive = 1 --AND bsr.BizRuleSubscriptionSK = 7

OPEN BizRule_Subscription_cursor

FETCH NEXT FROM BizRule_Subscription_cursor
INTO @TableName, @KeyFieldName, @BizRuleSubscriptionSK

WHILE @@FETCH_STATUS = 0
BEGIN

		SELECT @SQL = 
		'
		INSERT INTO #WorkingRulesOutput (
			 IssueID
			,SSID
			,SourceSystem
			,BizRuleName
			,BizRuleDesc
			,[Type]
			,Name
			,TableName
			,KeyFieldName
			,KeyFieldValue
			,ValidationFieldName
			,ValidationFieldValue
			,SourceFieldName
			,SourceFieldValue
			,IssueIsApproved
			,IssueIsIgnore
			,IssueIsCompleted
			,Issue_OpenedOn
			,Issue_CreatedBy
			,Issue_UpdatedOn
			,Issue_UpdatedBy
		)
		SELECT top 100
			 bri.[IssueID]
			,bri.[SSID]
			,bri.[SourceSystem]
			,he.Name
			,he.FullDescription
			,drs.[Type]
			,drs.[Name]
			,drs.[TableName]
			,ISNULL(drs.OtherID,drs.KeyFieldName) KeyFieldName
			,ISNULL(t.' + drs.KeyFieldName + ' , t.' + KeyFieldName + ') AS KeyFieldValue
			,drs.ValidationFieldName
			,t.' + ValidationFieldName + ' AS ValidationFieldValue
			,drs.SourceFieldName
			,st.' + drs.SourceFieldName + ' AS SourceFieldValue
			,bri.[IssueIsApproved]
			,bri.[IssueIsIgnore]
			,bri.[IssueIsCompleted]
			,bri.[Issue_OpenedOn]
			,bri.[Issue_CreatedBy]
			,bri.[Issue_UpdatedOn]
			,bri.[Issue_UpdatedBy]
		FROM dbo.BizRule_Issues bri
		INNER JOIN dbo.BizRule_Header he
			ON  bri.BizRuleSK = he.BizRuleSK
		INNER JOIN dbo.BizRule_Subscription drs
			ON  bri.BizRuleSubscriptionSK = drs.BizRuleSubscriptionSK
		INNER JOIN ' + drs.TableName + ' t
			ON  bri.' + drs.KeyFieldName + ' = t.' + drs.KeyFieldName + '
			 AND ' + CASE WHEN drs.OtherID IS NOT NULL THEN 'ISNULL(bri.OtherID,'''') = ISNULL(t.' + drs.OtherID +','''')' ELSE '1=1'END +'
			 AND ' + CASE WHEN drs.IsDimcustomer = 1 THEN 't.SourceSystem =bri.Sourcesystem' ELSE '1=1'END +'
		LEFT JOIN ' + drs.SourceTableName + ' st
			ON  bri.' + drs.SourceKeyFieldName + ' = st.' + drs.SourceKeyFieldName + '
			 AND ' + CASE WHEN drs.SourceOtherID IS NOT NULL THEN 'ISNULL(bri.SourceOtherID,'''') = ISNULL(st.' + drs.SourceOtherID +','''')' ELSE '1=1'END +'
		WHERE drs.TableName = ''' + @TableName + '''
			AND drs.KeyFieldName = ''' + @KeyFieldName + '''
			AND CAST(bri.IssueIsCompleted as int) + CAST(bri.IssueIsApproved as int) +  CAST(bri.IssueIsIgnore as int) = 0
			AND drs.BizRuleSubscriptionSK = '+@BizRuleSubscriptionSK +''
		FROM dbo.BizRule_Subscription drs
		WHERE drs.TableName = @TableName
			AND drs.KeyFieldName = @KeyFieldName
			AND drs.BizRuleSubscriptionSK = @BizRuleSubscriptionSK


		PRINT @SQL
		EXECUTE SP_EXECUTESQL @SQL

	FETCH NEXT FROM BizRule_Subscription_cursor
	INTO @TableName, @KeyFieldName, @BizRuleSubscriptionSK

END

CLOSE BizRule_Subscription_cursor;
DEALLOCATE BizRule_Subscription_cursor;

SELECT 
	case GROUPING_ID(
	IssueID	,SSID	,SourceSystem	,BizRuleName	,BizRuleDesc
	,[Type]	,Name	,TableName	,KeyFieldName	,KeyFieldValue
	,ValidationFieldName	,ValidationFieldValue	,SourceFieldName
	,SourceFieldValue	,IssueIsApproved ,IssueIsIgnore	,IssueIsCompleted
	,Issue_OpenedOn	,Issue_CreatedBy	,Issue_UpdatedOn	,Issue_UpdatedBy
	,B.DetailRow	,b.IssueCount	,b.RowType	) --GroupID
		WHEN 0 THEN 'Child1'
		WHEN 14811135 THEN 'PARENT' END AS 'Group'
	 ,IssueID
	,SSID
	,SourceSystem
	,BizRuleName
	,BizRuleDesc
	,[Type]
	,Name
	,TableName
	,KeyFieldName
	,KeyFieldValue
	,ValidationFieldName
	,ValidationFieldValue
	,SourceFieldName
	,SourceFieldValue
	,IssueIsApproved
	,IssueIsIgnore
	,IssueIsCompleted
	,Issue_OpenedOn
	,Issue_CreatedBy
	,Issue_UpdatedOn
	,Issue_UpdatedBy
	,B.DetailRow
	,b.IssueCount
	,b.RowType
	,count(IssueID) Issues
FROM #WorkingRulesOutput A 
CROSS JOIN #abc B
WHERE A.IssueID < 10
group by GROUPING SETS ((BizRuleName,BizRuleDesc,[Type],Name),(BizRuleName,IssueID,
	SSID,BizRuleDesc,[Type],Name
	,SourceSystem
	,TableName
	,KeyFieldName
	,KeyFieldValue
	,ValidationFieldName
	,ValidationFieldValue
	,SourceFieldName
	,SourceFieldValue
	,IssueIsApproved
	,IssueIsIgnore
	,IssueIsCompleted
	,Issue_OpenedOn
	,Issue_CreatedBy
	,Issue_UpdatedOn
	,Issue_UpdatedBy
	,B.DetailRow
	,b.IssueCount
	,b.RowType))
GO
