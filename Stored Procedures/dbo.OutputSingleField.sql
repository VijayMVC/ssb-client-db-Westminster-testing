SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE PROC [dbo].[OutputSingleField] 
	@IssueID	INT 
	AS
--[dbo].[OutputSingleField] 988

DECLARE @SourceTable NVARCHAR(MAX) =(SELECT b.TableName FROM dbo.BizRule_Issues a 
									JOIN dbo.BizRule_Subscription b ON b.BizRuleSubscriptionSK = a.BizRuleSubscriptionSK
									WHERE a.IssueID = @IssueID)
--DECLARE @SourceField NVARCHAR(MAX) =(SELECT DISTINCT b.TableName FROM dbo.BizRule_Issues a 
--									JOIN dbo.BizRule_Subscription b ON b.BizRuleSubscriptionSK = a.BizRuleSubscriptionSK
--									WHERE a.IssueID = @IssueID)
DECLARE @sql NVARCHAR(MAX)

SET @sql =
CASE @SourceTable
	WHEN  'dbo.DimCustomer'
	THEN 
	'SELECT a.SourceSystem
		,a.SSID
		,a.Birthday
		,a.Prefix
		,a.FirstName
		,a.MiddleName
		,a.LastName
		,a.Suffix
		,a.FullName
		,a.AddressPrimaryStreet
		,a.AddressPrimarySuite
		,a.AddressPrimaryCity
		,a.AddressPrimaryState
		,a.AddressPrimaryZip
		,a.AddressPrimaryCounty
		,a.AddressPrimaryCountry
		,a.AddressPrimaryIsCleanStatus
		,a.PhonePrimary
		,a.PhonePrimaryIsCleanStatus
		,a.EmailPrimary
		,a.EmailPrimaryIsCleanStatus 
		FROM dbo.DimCustomer a JOIN dbo.BizRule_Issues b on a.SSID = b.SSID and a.sourcesystem = b.sourcesystem and b.IssueID = ' + CAST(@IssueID AS VARCHAR(10))
	ELSE  'Select * from ' + @SourceTable
	END

	PRINT @sql
	EXEC(@sql)
--SELECT 'Senior Systems Record - This will be Changed' UpdateHeader, bi.EntityNo, bi.OtherID AS AddressNumber, CONCAT(pa.Address1, pa.Address2, pa.Address3) Address, pa.City, pa.State,pa.Zip ,
--'Raisers Edge Source Record - This will be the new address in Senior' SourceHeader, bi.Constituent_ID, bi.SourceOtherID AS Address_ID, a.Formatted_address Address, a.City, a.State,a.Postal_Code
--FROM dbo.BizRule_Issues bi
--JOIN ods.BlackBaud_addresses a (NOLOCK) ON a.constituent_id = bi.Constituent_ID AND bi.SourceOtherID = a.address_id
--JOIN ods.SeniorSystems_persons_address pa (NOLOCK) ON pa.EntityNo = bi.EntityNo AND bi.OtherID = pa.AddressNumber
--WHERE bi.IssueID = @IssueID

GO
