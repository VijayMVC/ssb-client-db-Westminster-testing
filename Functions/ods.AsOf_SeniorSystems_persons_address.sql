SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

/*
-- Get the status of your table 20 minutes ago...
DECLARE @AsOfDate DATETIME = (SELECT [etl].[ConvertToLocalTime](DATEADD(MINUTE,-20,GETDATE())))
SELECT * FROM [ods].[AsOf_SeniorSystems_persons_address] (@AsOfDate)
*/

CREATE FUNCTION [ods].[AsOf_SeniorSystems_persons_address] (@AsOfDate DATETIME)

RETURNS @Results TABLE
(
[EntityNo] [nvarchar](50) NULL,
[AddressNumber] [nvarchar](50) NULL,
[Address1] [nvarchar](500) NULL,
[Address2] [nvarchar](500) NULL,
[Address3] [nvarchar](500) NULL,
[NotPublishAddressLines] [nvarchar](10) NULL,
[City] [nvarchar](50) NULL,
[State] [nvarchar](10) NULL,
[Zip] [nvarchar](25) NULL,
[NotPublishCityStateZip] [nvarchar](10) NULL,
[HouseholdID] [nvarchar](50) NULL,
[Country] [nvarchar](50) NULL,
[NotPublishCountry] [nvarchar](10) NULL,
[Phone] [nvarchar](50) NULL,
[NotPublishPhone] [nvarchar](10) NULL,
[Email1] [nvarchar](250) NULL,
[NotPublishEmail1] [nvarchar](10) NULL,
[SendHouseholdEmail1] [nvarchar](10) NULL,
[Email2] [nvarchar](250) NULL,
[NotPublishEmail2] [nvarchar](10) NULL,
[SendHouseholdEmail2] [nvarchar](10) NULL,
[OtherNumberType1] [nvarchar](50) NULL,
[OtherNumber1] [nvarchar](50) NULL,
[NotPublishOtherNumber1] [nvarchar](10) NULL,
[OtherNumberType2] [nvarchar](50) NULL,
[OtherNumber2] [nvarchar](50) NULL,
[NotPublishOtherNumber2] [nvarchar](10) NULL,
[OtherNumberType3] [nvarchar](50) NULL,
[OtherNumber3] [nvarchar](50) NULL,
[NotPublishOtherNumber3] [nvarchar](10) NULL,
[OtherNumberType4] [nvarchar](50) NULL,
[OtherNumber4] [nvarchar](50) NULL,
[NotPublishOtherNumber4] [nvarchar](10) NULL,
[IsActive] [nvarchar](10) NULL,
[ActiveFromDate] [nvarchar](50) NULL,
[ActiveToDate] [nvarchar](50) NULL,
[AddressType] [nvarchar](50) NULL,
[AddressCode] [nvarchar](50) NULL,
[InternalAddressCode] [nvarchar](50) NULL,
[CompanyName] [nvarchar](250) NULL,
[NotPublishCompany] [nvarchar](10) NULL,
[Occupation] [nvarchar](100) NULL,
[JobTitle] [nvarchar](100) NULL,
[Industry] [nvarchar](100) NULL,
[Notes] [nvarchar](max) NULL,
[BillCode] [nvarchar](100) NULL,
[IsSendGrades] [nvarchar](10) NULL,
[IsPrimaryAddress] [nvarchar](10) NULL,
[IsEmergencyContact] [nvarchar](10) NULL,
[NotPublishEntireAddress] [nvarchar](10) NULL,
[IsAdditionalContact] [nvarchar](10) NULL,
[HasPendingChanges] [nvarchar](10) NULL,
[IsPendingRecord] [nvarchar](10) NULL,
[IsPendingDelete] [nvarchar](10) NULL,
[Name1EntityNo] [nvarchar](50) NULL,
[Name1Title] [nvarchar](100) NULL,
[Name1FirstName] [nvarchar](100) NULL,
[Name1MiddleName] [nvarchar](100) NULL,
[Name1LastName] [nvarchar](100) NULL,
[Name1Suffix] [nvarchar](50) NULL,
[Name1PreferredName] [nvarchar](100) NULL,
[Name1FullName] [nvarchar](300) NULL,
[Name1Relation] [nvarchar](100) NULL,
[Name2EntityNo] [nvarchar](50) NULL,
[Name2Title] [nvarchar](100) NULL,
[Name2FirstName] [nvarchar](100) NULL,
[Name2MiddleName] [nvarchar](100) NULL,
[Name2LastName] [nvarchar](100) NULL,
[Name2Suffix] [nvarchar](50) NULL,
[Name2PreferredName] [nvarchar](100) NULL,
[Name2FullName] [nvarchar](300) NULL,
[Name2Relation] [nvarchar](100) NULL,
[ETL_CreatedOn] [datetime] NOT NULL,
[ETL_CreatedBy] NVARCHAR(400) NOT NULL,
[ETL_UpdatedOn] [datetime] NOT NULL,
[ETL_UpdatedBy] NVARCHAR(400) NOT NULL
)

AS
BEGIN

DECLARE @EndDate DATETIME = (SELECT [etl].[ConvertToLocalTime](CAST(GETDATE() AS datetime2(0))))
SET @AsOfDate = (SELECT CAST(@AsOfDate AS datetime2(0)))

INSERT INTO @Results
SELECT [EntityNo],[AddressNumber],[Address1],[Address2],[Address3],[NotPublishAddressLines],[City],[State],[Zip],[NotPublishCityStateZip],[HouseholdID],[Country],[NotPublishCountry],[Phone],[NotPublishPhone],[Email1],[NotPublishEmail1],[SendHouseholdEmail1],[Email2],[NotPublishEmail2],[SendHouseholdEmail2],[OtherNumberType1],[OtherNumber1],[NotPublishOtherNumber1],[OtherNumberType2],[OtherNumber2],[NotPublishOtherNumber2],[OtherNumberType3],[OtherNumber3],[NotPublishOtherNumber3],[OtherNumberType4],[OtherNumber4],[NotPublishOtherNumber4],[IsActive],[ActiveFromDate],[ActiveToDate],[AddressType],[AddressCode],[InternalAddressCode],[CompanyName],[NotPublishCompany],[Occupation],[JobTitle],[Industry],[Notes],[BillCode],[IsSendGrades],[IsPrimaryAddress],[IsEmergencyContact],[NotPublishEntireAddress],[IsAdditionalContact],[HasPendingChanges],[IsPendingRecord],[IsPendingDelete],[Name1EntityNo],[Name1Title],[Name1FirstName],[Name1MiddleName],[Name1LastName],[Name1Suffix],[Name1PreferredName],[Name1FullName],[Name1Relation],[Name2EntityNo],[Name2Title],[Name2FirstName],[Name2MiddleName],[Name2LastName],[Name2Suffix],[Name2PreferredName],[Name2FullName],[Name2Relation],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy]
FROM
	(
	SELECT [EntityNo],[AddressNumber],[Address1],[Address2],[Address3],[NotPublishAddressLines],[City],[State],[Zip],[NotPublishCityStateZip],[HouseholdID],[Country],[NotPublishCountry],[Phone],[NotPublishPhone],[Email1],[NotPublishEmail1],[SendHouseholdEmail1],[Email2],[NotPublishEmail2],[SendHouseholdEmail2],[OtherNumberType1],[OtherNumber1],[NotPublishOtherNumber1],[OtherNumberType2],[OtherNumber2],[NotPublishOtherNumber2],[OtherNumberType3],[OtherNumber3],[NotPublishOtherNumber3],[OtherNumberType4],[OtherNumber4],[NotPublishOtherNumber4],[IsActive],[ActiveFromDate],[ActiveToDate],[AddressType],[AddressCode],[InternalAddressCode],[CompanyName],[NotPublishCompany],[Occupation],[JobTitle],[Industry],[Notes],[BillCode],[IsSendGrades],[IsPrimaryAddress],[IsEmergencyContact],[NotPublishEntireAddress],[IsAdditionalContact],[HasPendingChanges],[IsPendingRecord],[IsPendingDelete],[Name1EntityNo],[Name1Title],[Name1FirstName],[Name1MiddleName],[Name1LastName],[Name1Suffix],[Name1PreferredName],[Name1FullName],[Name1Relation],[Name2EntityNo],[Name2Title],[Name2FirstName],[Name2MiddleName],[Name2LastName],[Name2Suffix],[Name2PreferredName],[Name2FullName],[Name2Relation],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],@EndDate [RecordEndDate]
	FROM [ods].[SeniorSystems_persons_address] t
	UNION ALL
	SELECT [EntityNo],[AddressNumber],[Address1],[Address2],[Address3],[NotPublishAddressLines],[City],[State],[Zip],[NotPublishCityStateZip],[HouseholdID],[Country],[NotPublishCountry],[Phone],[NotPublishPhone],[Email1],[NotPublishEmail1],[SendHouseholdEmail1],[Email2],[NotPublishEmail2],[SendHouseholdEmail2],[OtherNumberType1],[OtherNumber1],[NotPublishOtherNumber1],[OtherNumberType2],[OtherNumber2],[NotPublishOtherNumber2],[OtherNumberType3],[OtherNumber3],[NotPublishOtherNumber3],[OtherNumberType4],[OtherNumber4],[NotPublishOtherNumber4],[IsActive],[ActiveFromDate],[ActiveToDate],[AddressType],[AddressCode],[InternalAddressCode],[CompanyName],[NotPublishCompany],[Occupation],[JobTitle],[Industry],[Notes],[BillCode],[IsSendGrades],[IsPrimaryAddress],[IsEmergencyContact],[NotPublishEntireAddress],[IsAdditionalContact],[HasPendingChanges],[IsPendingRecord],[IsPendingDelete],[Name1EntityNo],[Name1Title],[Name1FirstName],[Name1MiddleName],[Name1LastName],[Name1Suffix],[Name1PreferredName],[Name1FullName],[Name1Relation],[Name2EntityNo],[Name2Title],[Name2FirstName],[Name2MiddleName],[Name2LastName],[Name2Suffix],[Name2PreferredName],[Name2FullName],[Name2Relation],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate]
	FROM [ods].[Snapshot_SeniorSystems_persons_address]
	) a
WHERE
	@AsOfDate BETWEEN [ETL_UpdatedOn] AND [RecordEndDate]
	AND [ETL_CreatedOn] <= @AsOfDate

RETURN

END
GO
