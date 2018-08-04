SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[ValidateDataDifference_SS_to_RE] 
	@BizRuleSK	INT 
AS
--exec [dbo].[ValidateDataDifference_SS_to_RE]  17

	DECLARE @SQL NVARCHAR(MAX)
	DECLARE @IsDimCust bit
	DECLARE @TableName NVARCHAR(255)
	DECLARE @ValidatioField NVARCHAR(255)
	DECLARE @KeyField NVARCHAR(255)
	DECLARE @Type NVARCHAR(255)
	DECLARE @otherID NVARCHAR(255)
	DECLARE @SourceSystem NVARCHAR(255)
	DECLARE @BizRuleSubscriptionSK INT
	DECLARE @count INT
	DECLARE @maxcount int
		BEGIN TRY

	--TRUNCATE TABLE dbo.BizRule_SingleValidationResults

		DECLARE @Loop TABLE (ID INT IDENTITY(1,1) NOT NULL, IsDimcustomer BIT, TableName NVARCHAR(255), ValidationFieldName NVARCHAR(255)
				,Type VARCHAR(255), KeyFieldName NVARCHAR(255), SourceSystem NVARCHAR(255),BizRuleSubscriptionSK INT, OtherID VARCHAR(50))
		--DECLARE @output TABLE (SSID VARCHAR(50), SourceSystem VARCHAR(100), BizRuleSK INT , BizRuleSubscriptionSK INT, Result NVARCHAR(MAX))

		INSERT INTO @Loop
		(IsDimcustomer,TableName,ValidationFieldName, KeyFieldName, Type, SourceSystem,BizRuleSubscriptionSK, OtherID)
				
		SELECT  b.IsDimcustomer
		, b.TableName
		, b.ValidationFieldName
		, b.KeyFieldName
		, b.Type
		, b.SourceSystem
		, b.BizRuleSubscriptionSK
		, b.OtherID
		FROM dbo.BizRule_Header a
		JOIN dbo.BizRule_Subscription b ON a.BizRuleSK = b.BizRuleSK
		WHERE a.BizRuleSK = @BizRuleSK

		SET @maxcount = (SELECT MAX(ID) FROM @Loop)
		SET @count = 1
		WHILE @count < = @maxcount 
			BEGIN

			SELECT 
			  @IsDimCust = IsDimcustomer
			, @TableName = TableName
			, @ValidatioField = ValidationFieldName
			, @KeyField = KeyFieldName
			, @Type = Type
			, @otherID = OtherID
			, @SourceSystem = SourceSystem
			, @BizRuleSubscriptionSK = BizRuleSubscriptionSK
			FROM @Loop
			WHERE ID = @count

	IF @IsDimCust =1 
		BEGIN
		SET @SQL = 
		'WITH workingset AS (SELECT SSB_CRMSYSTEM_CONTACT_ID FROM dbo.vwDimCustomer_ModAcctId
		WHERE SourceSystem IN (''seniorsystems'',''Raisersedge'')
		GROUP BY SSB_CRMSYSTEM_CONTACT_ID
		HAVING COUNT(1) = 2 AND COUNT(DISTINCT SourceSystem) = 2)

		SELECT MAX(CASE WHEN a.SourceSystem = ''RaisersEdge'' THEN a.SSID END) SSID
		, ''RaisersEdge'' SourceSystem
		, ' + CAST(@BizRuleSK AS NVARCHAR(10)) + ' AS BizRuleSK
		, ' + CAST(@BizRuleSubscriptionSK AS NVARCHAR(10)) + ' AS BizRuleSubscriptionSK
		, ''Fail'' AS Result
		, MAX(CASE WHEN a.SourceSystem = ''SeniorSystems'' THEN a.DimCustomerID END) OtherID
		, MAX(CASE WHEN a.SourceSystem = ''RaisersEdge'' THEN a.SSID END) Constituent_ID
		, MAX(CASE WHEN a.SourceSystem = ''SeniorSystems'' THEN a.SSID END) EntityNo
		,NULL UID
		, HASHBYTES(''sha2_256'', ISNULL(RTRIM(CONCAT(MAX(CASE WHEN a.SourceSystem = ''SeniorSystems'' THEN a.' + @ValidatioField + ' END),  MAX(CASE WHEN a.SourceSystem = ''RaisersEdge'' THEN a.' + @ValidatioField + ' END))),''DBNULL_TEXT''))  
		FROM dbo.vwDimCustomer_ModAcctId a
		JOIN workingset b ON b.SSB_CRMSYSTEM_CONTACT_ID = a.SSB_CRMSYSTEM_CONTACT_ID
		where SourceSystem IN (''seniorsystems'',''Raisersedge'') AND NOT ((ISNULL(ExtAttribute8,'''') =''Studnet'' or ISNULL(ExtAttribute9,'''') like ''%student%'') and (''' + @ValidatioField + ''' like ''%Email%'' or ''' + @ValidatioField + ''' like ''%Phone%''))
			AND NOT (''' + @ValidatioField + ''' like ''%AddressPrimary%'' AND AddressPrimaryStreet =''1424 W Paces Ferry Rd NW'')
		GROUP BY a.SSB_CRMSYSTEM_CONTACT_ID	
		HAVING MAX(CASE WHEN a.SourceSystem = ''SeniorSystems'' THEN a.' + @ValidatioField + ' END) <>  MAX(CASE WHEN a.SourceSystem = ''RaisersEdge'' THEN a.' + @ValidatioField + ' END)
		AND MAX(ISNULL(CASE WHEN a.SourceSystem = ''SeniorSystems'' THEN a.' + @ValidatioField + ' END,'''')) <> '''''

		

		END 
		ELSE BEGIN
			SET @Sql = ''

			END

	--PRINT @sql
	INSERT INTO dbo.BizRule_SingleValidationResults
	EXEC(@sql)

	SET @count = @count + 1

            END

	--SELECT * FROM @output
		
	END TRY 

	BEGIN CATCH
			
		DECLARE @ErrorMessage NVARCHAR(4000) = ERROR_MESSAGE();
		DECLARE @ErrorSeverity INT = ERROR_SEVERITY();
		DECLARE @ErrorState INT = ERROR_STATE();
		                    
		PRINT @ErrorMessage
		--EXEC [dbo].[LogBizRuleEventRecord] @BatchSK, 'Error', @ProcedureName, 'Validate Biz Rule', 'Error Processing', @ErrorMessage, @ExecutionId

		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState)

	END CATCH



GO
