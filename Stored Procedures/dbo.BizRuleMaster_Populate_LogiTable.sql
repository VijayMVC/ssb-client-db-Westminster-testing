SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

--TRUNCATE TABLE
-- select * from dbo.BizRule_Issues_Logi
 
CREATE PROCEDURE [dbo].[BizRuleMaster_Populate_LogiTable]  
AS


DECLARE @SQL NVARCHAR(MAX) = ''

DECLARE
	@TableName NVARCHAR(MAX),
	@KeyFieldName NVARCHAR(MAX),
	@BizRuleSubscriptionSK NVARCHAR(MAX)


IF OBJECT_ID('tempdb..#WorkingRulesOutput') IS NOT NULL
	DROP TABLE #WorkingRulesOutput


CREATE TABLE #WorkingRulesOutput (
	[IssueID] [bigint] NOT NULL,
	[SSID] [varchar](500) NOT NULL,
	FullName VARCHAR(600),
	[SourceSystem] [varchar](100) NOT NULL,
	BizRuleSubscriptionSK INT NOT NULL,
	BizRulePriority int NULL,
	BizRuleDesc [nvarchar](MAX) NULL,
	[Name] [nvarchar](255) NOT NULL,
	KeyFieldName [nvarchar](MAX) NULL,
	KeyFieldValue [nvarchar](MAX) NULL,
	[ValidationFieldName] [nvarchar](MAX) NULL,
	[ValidationFieldValue] [nvarchar](MAX) NULL,
	[SourceFieldName] [nvarchar](MAX) NULL,
	[SourceFieldValue] [nvarchar](MAX) NULL
	,IssueIsApproved	 BIT
	,IssueIsIgnore		 BIT
	,IssueIsCompleted	 BIT
	,[Issue_OpenedOn] [datetime] NOT NULL,
	[Issue_UpdatedOn] [datetime] NOT NULL,
	Logi_Approval BIT NULL,
	Logi_Ignore BIT NULL,
	IsTwoButton BIT NOT NULL

	
)


DECLARE BizRule_Subscription_cursor CURSOR
FOR 
	SELECT DISTINCT bsr.BizRuleSubscriptionSK
	FROM dbo.BizRule_Subscription bsr
	INNER JOIN dbo.BizRule_Issues bri
		ON  bri.BizRuleSubscriptionSK = bsr.BizRuleSubscriptionSK
	WHERE bsr.IsActive = 1 
	AND bsr.BizRuleSK NOT IN ( 18,19, 20)

OPEN BizRule_Subscription_cursor

FETCH NEXT FROM BizRule_Subscription_cursor
INTO @BizRuleSubscriptionSK

WHILE @@FETCH_STATUS = 0
BEGIN

		SELECT @SQL = 
		'
		INSERT INTO #WorkingRulesOutput (
			 IssueID
			,SSID
			,FullName
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
			,IssueIsApproved
			,IssueIsIgnore
			,IssueIsCompleted
			,Issue_OpenedOn
			--,Issue_CreatedBy
			,Issue_UpdatedOn
			--,Issue_UpdatedBy
			,IsTwoButton
		)
		SELECT --top 100
			 bri.[IssueID]
			,bri.[SSID]
			,dcust.FullName
			,bri.[SourceSystem]
			,drs.BizRuleSubscriptionSK
			,drs.PriorityOrder 
			,ISNULL(drs.FullDescription,he.FullDescription) FullDescription
			--,drs.[Type]
			,drs.[Name]
			--,drs.[TableName]
			,ISNULL(drs.OtherID,drs.KeyFieldName) KeyFieldName
			,'+  CASE WHEN drs.SourceTableName IS NOT NULL THEN 'ISNULL(t.' + drs.KeyFieldName + ' , t.' + KeyFieldName + ')' ELSE 't.' + KeyFieldName END +' AS KeyFieldValue
			,drs.ValidationFieldName
			,t.' + ValidationFieldName + ' AS ValidationFieldValue
			,ISNULL(drs.SourceFieldName,'''') SourceFieldName
			,'+ CASE WHEN drs.IsDimcustomer = 1 AND drs.SourceTableName IS NULL THEN 't.' + REPLACE(drs.SourceFieldName,'+ '' '' + ','+ '' '' + t.')
					WHEN drs.SourceFieldName IS NOT NULL THEN 'st.' + drs.SourceFieldName ELSE '''''' END + ' AS SourceFieldValue
			,bri.[IssueIsApproved]
			,bri.[IssueIsIgnore]
			,bri.[IssueIsCompleted]
			,bri.[Issue_OpenedOn]
			--,bri.[Issue_CreatedBy]
			,bri.[Issue_UpdatedOn]
			--,bri.[Issue_UpdatedBy]
			,CASE WHEN drs.IsOutboundRule = 1 then 0 else 1 END  IsTwoButton
		FROM dbo.BizRule_Issues bri
		INNER JOIN dbo.Dimcustomer dcust	On bri.SSID = dcust.SSID and bri.SourceSystem = dcust.SourceSystem
		INNER JOIN dbo.BizRule_Header he
			ON  bri.BizRuleSK = he.BizRuleSK
		INNER JOIN dbo.BizRule_Subscription drs
			ON  bri.BizRuleSubscriptionSK = drs.BizRuleSubscriptionSK
		INNER JOIN ' + drs.TableName + ' t
			ON  bri.' + drs.KeyFieldName + ' = t.' + drs.KeyFieldName + '
			 AND ' + CASE WHEN drs.OtherID IS NOT NULL THEN 'ISNULL(bri.OtherID,'''') = ISNULL(t.' + drs.OtherID +','''')' ELSE '1=1'END +'
			 AND ' + CASE WHEN drs.IsDimcustomer = 1 THEN 't.SourceSystem =bri.Sourcesystem' ELSE '1=1'END +
		+ CASE WHEN drs.SourceTableName IS NOT NULL THEN 
		CHAR(10) + 'LEFT JOIN ' + drs.SourceTableName + ' st' + CHAR(10)
			+ CASE WHEN drs.SourceTableName = 'dbo.vwDimCustomer_ModAcctId' THEN 'ON  bri.OtherID = st.DimcustomerID ' +CHAR(10) 
			 ELSE 'ON  bri.' + drs.SourceKeyFieldName + ' = st.' + drs.SourceKeyFieldName + CHAR(10) END  +'
			 AND ' + CASE WHEN drs.SourceOtherID IS NOT NULL THEN 'ISNULL(bri.SourceOtherID,'''') = ISNULL(st.' + drs.SourceOtherID +','''')' ELSE '1=1'END 
			 ELSE '' END +'
		WHERE drs.TableName = ''' + drs.TableName  + '''
			AND drs.KeyFieldName = ''' +drs.KeyFieldName + '''
			AND drs.BizRuleSubscriptionSK = '+@BizRuleSubscriptionSK +''
		FROM dbo.BizRule_Subscription drs
		WHERE drs.BizRuleSubscriptionSK = @BizRuleSubscriptionSK


		PRINT @SQL
		EXECUTE SP_EXECUTESQL @SQL

	FETCH NEXT FROM BizRule_Subscription_cursor
	INTO @BizRuleSubscriptionSK

END

CLOSE BizRule_Subscription_cursor;
DEALLOCATE BizRule_Subscription_cursor;
--#WorkingRulesOutput WHERE IssueID = 4172

INSERT INTO #WorkingRulesOutput (
			 IssueID
			,SSID
			,FullName
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
			,IssueIsApproved
			,IssueIsIgnore
			,IssueIsCompleted
			,Issue_OpenedOn
			--,Issue_CreatedBy
			,Issue_UpdatedOn
			--,Issue_UpdatedBy
			,IsTwoButton
		)
		SELECT --top 100
			 bri.[IssueID]
			,CASE WHEN bri.SSID LIKE '%-%' THEN SUBSTRING(bri.SSID, 1,CHARINDEX('-',bri.SSID)-1) ELSE bri.SSID END [SSID]
			,CONCAT(p.FullName, CASE WHEN ISNULL(ConstituentClassYr,0) <> 0 THEN ' - ' + p. ConstituentClassYr END )
			,bri.[SourceSystem]
			,drs.BizRuleSubscriptionSK
			,drs.PriorityOrder 
			,drs.FullDescription FullDescription
			--,drs.[Type]
			,drs.[Name]
			--,drs.[TableName]
			,drs.KeyFieldName KeyFieldName
			,CASE WHEN p.IsStudent = 'true' THEN 'Student' WHEN p.IsFaculty = 'true' THEN 'Faculty/Staff'  ELSE 'Parent'  END AS KeyFieldValue
			,SIS.FieldName ValidationFieldName
			,sis.Current_Value AS ValidationFieldValue
			,sis.FieldName SourceFieldName
			,sis.Previous_Value AS SourceFieldValue
			,bri.[IssueIsApproved]
			,bri.[IssueIsIgnore]
			,bri.[IssueIsCompleted]
			,sis.ChangeDate [Issue_OpenedOn]
			--,bri.[Issue_CreatedBy]
			,bri.[Issue_UpdatedOn]
			--,bri.[Issue_UpdatedBy]
			,CASE WHEN drs.IsOutboundRule = 1 then 0 else 1 END  IsTwoButton
		FROM dbo.BizRule_Issues bri
		INNER JOIN dbo.BizRule_Header he
			ON  bri.BizRuleSK = he.BizRuleSK
		INNER JOIN dbo.BizRule_Subscription drs
			ON  bri.BizRuleSubscriptionSK = drs.BizRuleSubscriptionSK
		INNER JOIN (SELECT *,ROW_NUMBER() OVER(PARTITION BY SSID, FieldName ORDER BY ChangeDate DESC) RN
					FROM dbo.SIS_DataChanges) sis 
			ON sis.SSID = CASE WHEN bri.SSID LIKE '%-%' THEN SUBSTRING(bri.SSID, 1,CHARINDEX('-',bri.SSID)-1) ELSE bri.SSID END
			AND sis.FieldName = CASE WHEN bri.SSID LIKE '%-%' THEN SUBSTRING(bri.SSID, CHARINDEX('-',bri.SSID)+ 1, 99) ELSE drs.KeyFieldName end
			AND sis.rn = 1	
		INNER JOIN ods.SeniorSystems_persons p
			ON SIS.SSID = p.EntityNo
		--WHERE drs.BizRuleSK IN ( 19)
		WHERE drs.BizRuleSK IN ( 18 ,19)

INSERT INTO #WorkingRulesOutput (
			 IssueID
			,SSID
			,FullName
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
			,IssueIsApproved
			,IssueIsIgnore
			,IssueIsCompleted
			,Issue_OpenedOn
			--,Issue_CreatedBy
			,Issue_UpdatedOn
			--,Issue_UpdatedBy
			,IsTwoButton
		)
		SELECT --top 100
			 bri_i.[IssueID]
			,bri.[SSID]
			,dcust.FullName
			,bri.[SourceSystem]
			,drs.BizRuleSubscriptionSK
			,drs.PriorityOrder 
			,ISNULL(drs.FullDescription,he.FullDescription) FullDescription
			--,drs.[Type]
			,drs.[Name]
			--,drs.[TableName]
			,ISNULL(drs.OtherID,drs.KeyFieldName) KeyFieldName
			,t.IssueID AS KeyFieldValue
			,drs.ValidationFieldName
			,t.IssueID AS ValidationFieldValue
			,ISNULL(drs.SourceFieldName,'') SourceFieldName
			,'' AS SourceFieldValue
			,bri_i.[IssueIsApproved]
			,bri_i.[IssueIsIgnore]
			,bri_i.[IssueIsCompleted]
			,bri_i.[Issue_OpenedOn]
			--,bri.[Issue_CreatedBy]
			,bri_i.[Issue_UpdatedOn]
			--,bri.[Issue_UpdatedBy]
			,1 IsTwoButton
		FROM dbo.BizRule_Issues bri_i
		INNER JOIN dbo.BizRule_Issues bri ON bri.IssueID = bri_i.SSID AND bri_i.BizRuleSubscriptionSK = 44
		INNER JOIN dbo.Dimcustomer dcust	On bri.SSID = dcust.SSID and bri.SourceSystem = dcust.SourceSystem
		INNER JOIN dbo.BizRule_Header he
			ON  bri_i.BizRuleSK = he.BizRuleSK
		INNER JOIN dbo.BizRule_Subscription drs
			ON  bri_i.BizRuleSubscriptionSK = drs.BizRuleSubscriptionSK
		INNER JOIN dbo.BizRule_Issues t
			ON  bri.IssueID = t.IssueID
		WHERE drs.BizRuleSK IN (20)

MERGE dbo.BizRule_Issues_Logi t-- where  IssueID = 6825 
USING #WorkingRulesOutput s --where  IssueID = 6825 
	ON t.IssueID =s.IssueID	 
	WHEN MATCHED AND s.IssueIsCompleted = 0 THEN UPDATE
		SET t.Name = s.Name
			,t.FullName = s.FullName
			,t.BizRuleDesc = s.BizRuleDesc
			,t.KeyFieldName = s.KeyFieldName
			,t.KeyFieldValue = s.KeyFieldValue
			,t.ValidationFieldName = s.ValidationFieldName
			,t.ValidationFieldValue = s.ValidationFieldValue
			,t.SourceFieldName = s.SourceFieldName
			,t.SourceFieldValue = s.SourceFieldValue
			,t.Issue_UpdatedOn = s.Issue_OpenedOn
			,t.BizRulePriority = s.BizRulePriority
			,t.IsTwoButton = s.IsTwoButton
	WHEN NOT MATCHED AND s.IssueIsCompleted = 0 THEN INSERT
		(IssueID
		,SSID
		,FullName
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
		,Issue_UpdatedOn
		,IsTwoButton)
	VALUES (
		s.IssueID
		,s.SSID
		,s.FullName
		,s.SourceSystem
		,s.BizRuleSubscriptionSK
		,s.BizRulePriority
		,s.BizRuleDesc
		,s.Name
		,s.KeyFieldName
		,s.KeyFieldValue
		,s.ValidationFieldName
		,s.ValidationFieldValue
		,s.SourceFieldName
		,s.SourceFieldValue
		,s.Issue_OpenedOn
		,s.Issue_UpdatedOn
		,s.IsTwoButton)
	WHEN MATCHED AND s.IssueIsCompleted = 1 THEN DELETE
	WHEN NOT MATCHED BY SOURCE AND t.Logi_Approval IS NULL AND t.Logi_Ignore IS NULL THEN DELETE;


	--DELETE BizRule_Issues_Logi WHERE BizRuleSubscriptionSK IN (SELECT BizRuleSubscriptionSK FROM dbo.BizRule_Subscription WHERE BizRuleSK =18)


	
GO
