SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE PROC [dbo].[ValidateBusinessAddress] 
	@BizRuleSK	INT 
	AS
--[dbo].[ValidateBusinessAddress]  6

DECLARE @BizRuleSubscriptionSK INT
SET @BizRuleSubscriptionSK = ISNULL((SELECT BizRuleSubscriptionSK FROM dbo.BizRule_Subscription WHERE BizRuleSK = @BizRuleSK),-1);

WITH xx AS  (
SELECT DISTINCT
a.SSB_CRMSYSTEM_CONTACT_ID 
, MAX(re.address_lines) OVER(PARTITION BY SSB_CRMSYSTEM_CONTACT_ID)  RE_Add
, MAX(CONCAT(Address1,	Address2,	Address3)) OVER(PARTITION BY SSB_CRMSYSTEM_CONTACT_ID)  SS_ADD
, MAX(ss.AddressNumber) OVER(PARTITION BY SSB_CRMSYSTEM_CONTACT_ID) AddressNumber
, MAX(ss.EntityNo) OVER(PARTITION BY SSB_CRMSYSTEM_CONTACT_ID) EntityNo
, MAX(re.constituent_id) OVER(PARTITION BY SSB_CRMSYSTEM_CONTACT_ID) constituent_id
, MAX(re.address_id) OVER(PARTITION BY SSB_CRMSYSTEM_CONTACT_ID) address_id
,ROW_NUMBER() OVER(PARTITION BY a.DimCustomerId ORDER BY ss.AddressNumber DESC) rn
FROM dbo.dimcustomerssbid a
LEFT JOIN 
	(SELECT *, ROW_NUMBER() OVER(PARTITION BY constituent_id ORDER BY date_modified DESC, date_added DESC, address_id DESC) RN  FROM ods.BlackBaud_addresses 
			WHERE type = 'Business' AND inactive = 'false' AND ISNULL(RTRIM(LTRIM(address_lines)),'') <> '' )RE 
	ON a.SSID = RE.constituent_id AND a.SourceSystem = 'RaisersEdge' AND re.rn= 1
LEFT JOIN 
	(SELECT *, ROW_NUMBER() OVER(PARTITION BY EntityNo ORDER BY ETL_CreatedOn DESC, AddressNumber DESC) RN  FROM ods.SeniorSystems_persons_address 
			WHERE AddressCode ='Work' AND IsActive = 'true' AND ISNULL(Address1,'') <> '') SS 
	ON a.SSID = ss.EntityNo AND a.SourceSystem = 'SeniorSystems' AND ss.rn = 1
--WHERE re.address_lines <> CONCAT(Address1,	Address2,	Address3)
--AND SSB_CRMSYSTEM_CONTACT_ID = '039BD0F2-8DDB-45C1-AEA8-65D9232697C8'

)

SELECT 
	SSID
	,SourceSystem
	,@BizRuleSK
	,@BizRuleSubscriptionSK
	,'Fail'
	, xx.constituent_id
	, xx.EntityNo
	, CASE WHEN a.SourceSystem = 'Schoology' THEN SSID END UID
	, xx.AddressNumber
	, xx.address_id
	, HASHBYTES('sha2_256', ISNULL(RTRIM(CONCAT(xx.AddressNumber,xx.address_id,xx.RE_Add,xx.SS_ADD)),'DBNULL_TEXT') ) 
FROM dbo.vwDimCustomer_ModAcctId a JOIN xx ON a.SSB_CRMSYSTEM_CONTACT_ID = xx.SSB_CRMSYSTEM_CONTACT_ID
AND a.SourceSystem = 'SeniorSystems'
WHERE xx.RE_Add <> xx.SS_ADD
AND xx.AddressNumber IS NOT NULL 
AND xx.rn = 1
GO
