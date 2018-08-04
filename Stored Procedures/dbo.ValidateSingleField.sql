SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[ValidateSingleField] 
	@BizRuleSK	INT 

--EXEC [dbo].[ValidateSingleField]  2
--[dbo].[BizRuleMaster]
AS
BEGIN


	SET NOCOUNT ON; 

	DECLARE @RunTime DATETIME = GETDATE()
	DECLARE @ExecutionId UNIQUEIDENTIFIER = NEWID();
	DECLARE @ProcedureName NVARCHAR(255) = OBJECT_SCHEMA_NAME(@@PROCID) + '.' + OBJECT_NAME(@@PROCID);
	DECLARE @ExpectedResult VARCHAR(50)
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
		  SET @Sql = 

		'SELECT DISTINCT
			d.SSID
			, d.SourceSystem
			, ' + CAST(@BizRuleSK AS NVARCHAR(10)) + ' AS BizRuleSK
			, ' + CAST(@BizRuleSubscriptionSK AS NVARCHAR(10)) + ' AS BizRuleSubscriptionSK
			, ''Fail'' AS Result
			, DimcustomerID AS OtherID
			, CASE WHEN d.SourceSystem = ''RaisersEdge'' THEN SSID END Constituent_ID
			, CASE WHEN d.SourceSystem = ''SeniorSystems'' THEN SSID END EntityNo
			, CASE WHEN d.SourceSystem = ''Schoology'' THEN SSID END UID
			, HASHBYTES(''sha2_256'', ISNULL(RTRIM(d.' + REPLACE(@ValidatioField,'IsCleanStatus',CASE WHEN @ValidatioField = 'AddressPrimaryIsCleanStatus' THEN 'Street' ELSE '' END) + '),''DBNULL_TEXT''))  
		FROM dbo.vwDimCustomer_ModAcctId d
		WHERE NOT(d.' + REPLACE(@ValidatioField,'IsCleanStatus',CASE WHEN @ValidatioField = 'AddressPrimaryIsCleanStatus' THEN 'Street' ELSE '' END) + ' = ''''
				OR d.' + @ValidatioField + ' LIKE ''Valid%''
				OR d.' + @ValidatioField + ' LIKE ''%Blank%''
				OR d.' + @ValidatioField + ' = ''Foreign Address''
				OR d.' + @ValidatioField + ' = ''Invalid (Mail Server Not Found)''
				OR d.isdeleted = 1)
				AND ISNULL([ExtAttribute4],'''') <>''Deceased''
				AND (((ExtAttribute8 like ''%Parent%'' or ExtAttribute8 like ''%Parent%'') AND Sourcesystem =''RaisersEdge'') or Sourcesystem <> ''RaisersEdge'')
				AND Sourcesystem =''SeniorSystems'' '

		END 
		ELSE BEGIN
			SET @Sql = 
			'Select DISTINCT
			d.SSID
			, d.SourceSystem
			, ' + CAST(@BizRuleSK AS NVARCHAR(10)) + ' AS BizRuleSK
			, ' + CAST(@BizRuleSubscriptionSK AS NVARCHAR(10)) + ' AS BizRuleSubscriptionSK
			, ''Fail'' AS Results
			, ' + @otherID +' OtherID
			, CASE WHEN d.SourceSystem = ''RaisersEdge'' THEN SSID END Constituent_ID
			, CASE WHEN d.SourceSystem = ''SeniorSystems'' THEN SSID END EntityNo
			, CASE WHEN d.SourceSystem = ''Schoology'' THEN SSID END UID
			, HASHBYTES(''sha2_256'', ISNULL(RTRIM(x.'+@ValidatioField+'),''DBNULL_TEXT'') ) 
			FROM dbo.vwDimCustomer_ModAcctId d
			JOIN (SELECT *, ROW_NUMBER() OVER( partition by '+@KeyField + ' Order by '+@KeyField + ') RN FROM '+@TableName + ' ) x on d.SSID = x.'+@KeyField + ' AND d.sourcesystem = '''+@SourceSystem +	'''  and x.rn = 1
			WHERE ISNULL('+@ValidatioField +','''') <> '''' 
			AND ('+ CASE WHEN @Type = 'Email' THEN '' +@ValidatioField +' NOT LIKE ''%@%''' ELSE '1=2' END +')'

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

	

END 







GO
