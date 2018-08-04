SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




CREATE PROC [dbo].[OutputCurrentStudents_Suffix_SS_to_RE] 
	@IssueID	INT 
	AS
--[dbo].[OutputCurrentStudents_Suffix_SS_to_RE] 5818  11430
--SELECT * FROM dbo.BizRule_Issues WHERE bizrulesk = 8

DECLARE @SSB_CONTACT_ID NVARCHAR(50) 
DECLARE @SSID NVARCHAR(50) 
DECLARE @SS NVARCHAR(50) 
DECLARE @DimCust NVARCHAR(50) 

(SELECT @SSB_CONTACT_ID = c.SSB_CRMSYSTEM_CONTACT_ID
		,@SSID = a.SSID
		,@SS = a.SourceSystem
		,@DimCust = a.OtherID
		 FROM dbo.BizRule_Issues a 
		JOIN dbo.BizRule_Subscription b ON b.BizRuleSubscriptionSK = a.BizRuleSubscriptionSK
		JOIN dbo.dimcustomerssbid c ON a.SSID = c.SSID AND a.SourceSystem = c.SourceSystem
		WHERE a.IssueID = @IssueID)



DECLARE @sql NVARCHAR(MAX)

SET @sql =
	'SELECT ''Raisers Edge Update Record - This will be Changed'' UpdateHeader, bi.ssid AS SourceID,a.Prefix,a.FirstName,a.MiddleName,a.LastName,a.Suffix,a.ExtAttribute1 AS ClassYear
	, a.ExtAttribute8 ConCodes ,TRY_CAST(a.Birthday AS DATE) Birthday	,a.AddressPrimaryStreet	,a.EmailPrimary, a.SSB_CRMSYSTEM_CONTACT_ID
	FROM dbo.BizRule_Issues bi
	JOIN dbo.vwDimCustomer_ModAcctID a (NOLOCK) ON a.SSID =bi.SSID AND a.SourceSystem = bi.SourceSystem
	WHERE bi.IssueID = ' +CAST(@IssueID AS VARCHAR(10)) +'
	UNION  ALL
	SELECT ''Senior Systems Source Record - This will be the new suffix from Senior'' SourceHeader, bi.OtherID,a.Prefix,a.FirstName,a.MiddleName,a.LastName,a.Suffix,a.ExtAttribute1 AS ClassYear
		, '''' ConCodes ,TRY_CAST(a.Birthday AS DATE) Birthday	,a.AddressPrimaryStreet	,a.EmailPrimary, a.SSB_CRMSYSTEM_CONTACT_ID
	FROM dbo.BizRule_Issues bi
	JOIN dbo.vwDimCustomer_ModAcctID a (NOLOCK) ON bi.OtherID = a.DimCustomerId
	WHERE bi.IssueID = ' +CAST(@IssueID AS VARCHAR(10))

		--SELECT @sql,@SS,@SSB_CONTACT_ID,@SSID
	PRINT @sql
	EXEC(@sql)




GO
