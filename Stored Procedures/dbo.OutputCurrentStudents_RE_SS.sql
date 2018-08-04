SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE PROC [dbo].[OutputCurrentStudents_RE_SS] 
	@IssueID	INT 
	AS
--[dbo].[OutputCurrentStudents_RE_SS] 4433  
--SELECT * FROM dbo.BizRule_Issues WHERE bizrulesk = 8

DECLARE @SSB_CONTACT_ID NVARCHAR(50) 
DECLARE @SSID NVARCHAR(50) 
DECLARE @SS NVARCHAR(50) 
DECLARE @DimCust NVARCHAR(50) 
DECLARE @lastname NVARCHAR(100)
DECLARE @prefName NVARCHAR(100) 
DECLARE @firstName NVARCHAR(100) 
DECLARE @email NVARCHAR(100) 
DECLARE @address NVARCHAR(100) 
DECLARE @birth DATETIME
DECLARE @class VARCHAR(10)

(SELECT @SSB_CONTACT_ID = c.SSB_CRMSYSTEM_CONTACT_ID
		,@SSID = a.SSID
		,@SS = a.SourceSystem
		,@DimCust = c.DimCustomerID
		,@lastname	= c.LastName
		,@email		= c.EmailPrimary
		,@address	= c.AddressPrimaryStreet
		,@prefName = c.SalutationName
		,@firstName = c.FirstName
		,@birth		=c.Birthday
		,@class		=c.ExtAttribute1
		 FROM dbo.BizRule_Issues a 
		JOIN dbo.BizRule_Subscription b ON b.BizRuleSubscriptionSK = a.BizRuleSubscriptionSK
		JOIN dbo.vwDimCustomer_ModAcctID c ON a.SSID = c.SSID AND a.SourceSystem = c.SourceSystem
		WHERE a.IssueID = @IssueID  )

	--SELECT @lastname, @prefName, @email, @address,@birth, @class

SELECT  a.SourceSystem
		,a.SSID
		,'Current Issue Record' RecordType
		,a.SSB_CRMSYSTEM_CONTACT_ID
		,a.Prefix
		,a.FirstName
		,a.SalutationName PreferredName
		,a.MiddleName
		,a.LastName
		,a.Suffix
		,a.ExtAttribute1 AS ClassYear
		,a.ExtAttribute8 ConCodes
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
		,@IssueID IssueID
		INTO #temp  
	FROM dbo.vwDimCustomer_ModAcctID a --JOIN dbo.vwConstituent_Tagging b ON a.SSID = b.SSID AND a.SourceSystem = b.SourceSystem
	WHERE a.DimCustomerID = @DimCust
	
	UNION 

	SELECT 
		a.SourceSystem
		,a.SSID
		,'Possible matching Record' RecordType
		,a.SSB_CRMSYSTEM_CONTACT_ID
		,a.Prefix
		,a.FirstName
		,a.SalutationName PreferredName
		,a.MiddleName
		,a.LastName
		,a.Suffix
		,a.ExtAttribute1 AS ClassYear
		,a.ExtAttribute8 ConCodes
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
		, @IssueID
	FROM dbo.vwDimCustomer_ModAcctID a JOIN dbo.vwConstituent_Tagging b ON a.SSID = b.SSID AND a.SourceSystem = b.SourceSystem
	WHERE a.DimCustomerID <> @DimCust
		AND a.SourceSystem IN ('RaisersEdge','SeniorSystems')
		AND (b.SS_Current_Student = 1 OR RE_Current_Student = 1)
		--AND NOT a.Birthday <> ISNULL(@birth,a.Birthday)
		--AND NOT a.ExtAttribute1 <> @class
	AND (a.SSB_CRMSYSTEM_CONTACT_ID = @SSB_CONTACT_ID OR a.EmailPrimary = NULLIF(@email,'') OR a.AddressPrimaryStreet = NULLIF(@address,'')
			OR (a.FirstName = NULLIF(@prefName,'') AND a.LastName = @lastname)
			OR (a.FirstName = NULLIF(@firstName,'') AND a.LastName = @lastname))

SELECT  CASE WHEN  MAX(AddressPrimarySuite) OVER(PARTITION BY IssueID) <> MIN(AddressPrimarySuite) OVER(PARTITION BY IssueID) THEN 'Possible Address Suite Issue'
		WHEN  MAX(Suffix) OVER(PARTITION BY IssueID) <> MIN(Suffix) OVER(PARTITION BY IssueID) THEN 'Possible Suffix Issue'
	 WHEN  MAX(FirstName) OVER(PARTITION BY IssueID) = MAX(PreferredName) OVER(PARTITION BY IssueID) 
			OR MIN(FirstName) OVER(PARTITION BY IssueID) = MIN(PreferredName) OVER(PARTITION BY IssueID) THEN 'Possible first/preferred Issue'
	WHEN  MAX(AddressPrimaryStreet) OVER(PARTITION BY IssueID) <> MIN(AddressPrimaryStreet) OVER(PARTITION BY IssueID) THEN 'Possible Address Issue'

END [Possible Fix]
,*
FROM #temp
ORDER BY FirstName

GO
