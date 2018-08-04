SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROC [dbo].[OutputDuplicates] 
	@IssueID	INT 
	AS
--[dbo].[OutputDuplicates] 6937  11430
--SELECT * FROM dbo.BizRule_Issues WHERE bizrulesk = 8

DECLARE @SSB_CONTACT_ID NVARCHAR(50) 
DECLARE @SSID NVARCHAR(50) 
DECLARE @SS NVARCHAR(50) 

(SELECT @SSB_CONTACT_ID = c.SSB_CRMSYSTEM_CONTACT_ID
		,@SSID = a.SSID
		,@SS = a.SourceSystem
		 FROM dbo.BizRule_Issues a 
		JOIN dbo.BizRule_Subscription b ON b.BizRuleSubscriptionSK = a.BizRuleSubscriptionSK
		JOIN dbo.dimcustomerssbid c ON a.SSID = c.SSID AND a.SourceSystem = c.SourceSystem
		WHERE a.IssueID = @IssueID)



DECLARE @sql NVARCHAR(MAX)

SET @sql =
	'SELECT a.SourceSystem
		,a.SSID AS '+ CASE WHEN @ss = 'RaisersEdge' THEN 'Constituent_ID' WHEN @ss = 'SeniorSystems' THEN 'EntityNo'WHEN @ss = 'Schoology' THEN 'UID'END + '
		, CASE WHEN a.ssid = ''' + @SSID +'''THEN ''Current Issue Record'' ELSE ''Duplicate Record'' END RecordType
		,a.Prefix
		,a.FirstName
		,a.MiddleName
		,a.LastName
		,a.Suffix
		,a.ExtAttribute1 AS ClassYear
		'+ CASE WHEN @SS = 'RaisersEdge' THEN ', a.ExtAttribute8 ConCodes' ELSE '' END +'
		,a.Birthday
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
		,t.SS_Current_Student
		,t.RE_Current_Student
		,t.SS_Current_Parent
		,t.RE_Current_Parent
		,t.SS_Current_FactStaff
		,t.RE_Current_FactStaff
		FROM dbo.vwDimCustomer_ModAcctId a 
		INNER JOIN [dbo].[vwConstituent_Tagging] t
	 ON a.SSID = t.SSID AND a.SourceSystem = t.SourceSystem
		WHERE a.SSB_CRMSYSTEM_CONTACT_ID = ''' + CAST(@SSB_CONTACT_ID AS VARCHAR(50)) +'''
		  AND a.sourcesystem = ''' + @ss + '''
		  Order by RecordType'

		--SELECT @sql,@SS,@SSB_CONTACT_ID,@SSID
	PRINT @sql
	EXEC(@sql)
--SELECT 'Senior Systems Record - This will be Changed' UpdateHeader, bi.EntityNo, bi.OtherID AS AddressNumber, CONCAT(pa.Address1, pa.Address2, pa.Address3) Address, pa.City, pa.State,pa.Zip ,
--'Raisers Edge Source Record - This will be the new address in Senior' SourceHeader, bi.Constituent_ID, bi.SourceOtherID AS Address_ID, a.Formatted_address Address, a.City, a.State,a.Postal_Code
--FROM dbo.BizRule_Issues bi
--JOIN ods.BlackBaud_addresses a (NOLOCK) ON a.constituent_id = bi.Constituent_ID AND bi.SourceOtherID = a.address_id
--JOIN ods.SeniorSystems_persons_address pa (NOLOCK) ON pa.EntityNo = bi.EntityNo AND bi.OtherID = pa.AddressNumber
--WHERE bi.IssueID = @IssueID


GO
