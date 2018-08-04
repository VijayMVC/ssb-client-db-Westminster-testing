SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE PROC [dbo].[OutputDataDifference_SS_to_RE] 
	@IssueID	INT 
	AS
--[dbo].[OutputDataDifference_SS_to_RE] 7736

DECLARE @sql NVARCHAR(MAX)
DECLARE @validationField NVARCHAR(250) = (SELECT b.ValidationFieldName FROM dbo.BizRule_Issues a 
									JOIN dbo.BizRule_Subscription b ON b.BizRuleSubscriptionSK = a.BizRuleSubscriptionSK
									WHERE a.IssueID = @IssueID) 

SET @sql =
	'SELECT 
		CASE WHEN SourceSystem = ''RaisersEdge'' THEN ''Raisers Edge record to be updated'' ELSE ''Senior Systems source record'' END AS Note
		, a.SourceSystem 
		, SSID
		, ' +@validationField + ' 
		, FullName [Fulll Name]		
		, a.ExtAttribute8 ConCodes
		, a.ExtAttribute1 ClassYear
		, a.SSB_CRMSYSTEM_CONTACT_ID
		FROM dbo.vwDimCustomer_ModAcctId a
		JOIN (Select SSB_CRMSYSTEM_CONTACT_ID FROM dbo.dimcustomerssbid a 
				JOIN dbo.BizRule_Issues c on a.SSID = c.SSID and a.SourceSystem = c.SourceSystem and c.IssueID = ' + CAST(@IssueID AS VARCHAR(10)) +') d
			on a.SSB_CRMSYSTEM_CONTACT_ID = d.SSB_CRMSYSTEM_CONTACT_ID
		WHERE a.SourceSystem IN (''seniorsystems'',''Raisersedge'')
		Order by SourceSystem
'
	--PRINT @sql
	EXEC(@sql)



--SELECT 'Senior Systems Record - This will be Changed' UpdateHeader, bi.EntityNo, bi.OtherID AS AddressNumber, CONCAT(pa.Address1, pa.Address2, pa.Address3) Address, pa.City, pa.State,pa.Zip ,
--'Raisers Edge Source Record - This will be the new address in Senior' SourceHeader, bi.Constituent_ID, bi.SourceOtherID AS Address_ID, a.Formatted_address Address, a.City, a.State,a.Postal_Code
--FROM dbo.BizRule_Issues bi
--JOIN ods.BlackBaud_addresses a (NOLOCK) ON a.constituent_id = bi.Constituent_ID AND bi.SourceOtherID = a.address_id
--JOIN ods.SeniorSystems_persons_address pa (NOLOCK) ON pa.EntityNo = bi.EntityNo AND bi.OtherID = pa.AddressNumber
--WHERE bi.IssueID = @IssueID

GO
