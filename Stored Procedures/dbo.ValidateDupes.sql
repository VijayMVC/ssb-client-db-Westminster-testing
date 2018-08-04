SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[ValidateDupes] 
	@BizRuleSK	INT 

--EXEC [dbo].[ValidateDupes]  8
--[dbo].[BizRuleMaster]
AS
BEGIN

--DECLARE @BizRuleSK	INT = 8

	SET NOCOUNT ON; 

	DECLARE @RunTime DATETIME = GETDATE()
	DECLARE @SQL NVARCHAR(MAX)
	DECLARE @SourceSystem NVARCHAR(255)
	DECLARE @BizRuleSubscriptionSK INT
	DECLARE @count INT
	DECLARE @maxcount int

	BEGIN TRY



		DECLARE @Loop TABLE (ID INT IDENTITY(1,1) NOT NULL,  SourceSystem NVARCHAR(255),BizRuleSubscriptionSK INT)

		INSERT INTO @Loop
		(SourceSystem,BizRuleSubscriptionSK)
				
		SELECT  
		 b.SourceSystem
		, b.BizRuleSubscriptionSK
		FROM dbo.BizRule_Header a
		JOIN dbo.BizRule_Subscription b ON a.BizRuleSK = b.BizRuleSK
		WHERE a.BizRuleSK = @BizRuleSK
		AND b.IsActive = 1

		SET @maxcount = (SELECT MAX(ID) FROM @Loop)
		SET @count = 1
		WHILE @count < = @maxcount 
			BEGIN

			SELECT 
			  @SourceSystem = SourceSystem
			, @BizRuleSubscriptionSK = BizRuleSubscriptionSK
			FROM @Loop
			WHERE ID = @count

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
			, HASHBYTES(''sha2_256'', d.SSB_CRMSYSTEM_CONTACT_ID)  
		FROM (select *, COUNT(SSID) OVER(Partition by SSB_CRMSYSTEM_CONTACT_ID) DupeCheck, ROW_NUMBER() OVER(PARTITION BY SSB_CRMSYSTEM_CONTACT_ID Order by SSID) rn  
			FROM dbo.vwDimCustomer_ModAcctId
					WHERE SourceSystem = ''' + @SourceSystem + ''' AND ISNULL([ExtAttribute4],'''') <>''Deceased'') d
			WHERE DupeCheck > 1
			AND RN = 1'

		 
		
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


		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState)

	END CATCH

	

END 







GO
