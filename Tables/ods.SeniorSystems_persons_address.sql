CREATE TABLE [ods].[SeniorSystems_persons_address]
(
[EntityNo] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[AddressNumber] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Address1] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Address2] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Address3] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[NotPublishAddressLines] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[City] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[State] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Zip] [nvarchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[NotPublishCityStateZip] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[HouseholdID] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Country] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[NotPublishCountry] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Phone] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[NotPublishPhone] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Email1] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[NotPublishEmail1] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SendHouseholdEmail1] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Email2] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[NotPublishEmail2] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SendHouseholdEmail2] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[OtherNumberType1] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[OtherNumber1] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[NotPublishOtherNumber1] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[OtherNumberType2] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[OtherNumber2] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[NotPublishOtherNumber2] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[OtherNumberType3] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[OtherNumber3] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[NotPublishOtherNumber3] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[OtherNumberType4] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[OtherNumber4] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[NotPublishOtherNumber4] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsActive] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ActiveFromDate] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ActiveToDate] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AddressType] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AddressCode] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[InternalAddressCode] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CompanyName] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[NotPublishCompany] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Occupation] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[JobTitle] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Industry] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Notes] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BillCode] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsSendGrades] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsPrimaryAddress] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsEmergencyContact] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[NotPublishEntireAddress] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsAdditionalContact] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[HasPendingChanges] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsPendingRecord] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsPendingDelete] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Name1EntityNo] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Name1Title] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Name1FirstName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Name1MiddleName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Name1LastName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Name1Suffix] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Name1PreferredName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Name1FullName] [nvarchar] (300) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Name1Relation] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Name2EntityNo] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Name2Title] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Name2FirstName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Name2MiddleName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Name2LastName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Name2Suffix] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Name2PreferredName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Name2FullName] [nvarchar] (300) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Name2Relation] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_CreatedOn] [datetime] NOT NULL CONSTRAINT [DF__SeniorSys__ETL_C__2AC04CAA] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__SeniorSys__ETL_C__2BB470E3] DEFAULT (suser_sname()),
[ETL_UpdatedOn] [datetime] NOT NULL CONSTRAINT [DF__SeniorSys__ETL_U__2CA8951C] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__SeniorSys__ETL_U__2D9CB955] DEFAULT (suser_sname())
)
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

----------- CREATE TRIGGER -----------
CREATE TRIGGER [ods].[Snapshot_SeniorSystems_persons_addressUpdate] ON [ods].[SeniorSystems_persons_address]
AFTER UPDATE, DELETE

AS
BEGIN

DECLARE @ETL_UpdatedOn DATETIME = (SELECT [etl].[ConvertToLocalTime](CAST(GETDATE() AS DATETIME2(0))))
DECLARE @ETL_UpdatedBy NVARCHAR(400) = (SELECT SYSTEM_USER)

UPDATE t SET
[ETL_UpdatedOn] = @ETL_UpdatedOn
,[ETL_UpdatedBy] = @ETL_UpdatedBy
FROM [ods].[SeniorSystems_persons_address] t
	JOIN inserted i ON  t.[EntityNo] = i.[EntityNo] AND t.[AddressNumber] = i.[AddressNumber]

INSERT INTO [ods].[Snapshot_SeniorSystems_persons_address] ([EntityNo],[AddressNumber],[Address1],[Address2],[Address3],[NotPublishAddressLines],[City],[State],[Zip],[NotPublishCityStateZip],[HouseholdID],[Country],[NotPublishCountry],[Phone],[NotPublishPhone],[Email1],[NotPublishEmail1],[SendHouseholdEmail1],[Email2],[NotPublishEmail2],[SendHouseholdEmail2],[OtherNumberType1],[OtherNumber1],[NotPublishOtherNumber1],[OtherNumberType2],[OtherNumber2],[NotPublishOtherNumber2],[OtherNumberType3],[OtherNumber3],[NotPublishOtherNumber3],[OtherNumberType4],[OtherNumber4],[NotPublishOtherNumber4],[IsActive],[ActiveFromDate],[ActiveToDate],[AddressType],[AddressCode],[InternalAddressCode],[CompanyName],[NotPublishCompany],[Occupation],[JobTitle],[Industry],[Notes],[BillCode],[IsSendGrades],[IsPrimaryAddress],[IsEmergencyContact],[NotPublishEntireAddress],[IsAdditionalContact],[HasPendingChanges],[IsPendingRecord],[IsPendingDelete],[Name1EntityNo],[Name1Title],[Name1FirstName],[Name1MiddleName],[Name1LastName],[Name1Suffix],[Name1PreferredName],[Name1FullName],[Name1Relation],[Name2EntityNo],[Name2Title],[Name2FirstName],[Name2MiddleName],[Name2LastName],[Name2Suffix],[Name2PreferredName],[Name2FullName],[Name2Relation],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate])
SELECT a.*,dateadd(s,-1,@ETL_UpdatedOn)
FROM deleted a

END
GO
ALTER TABLE [ods].[SeniorSystems_persons_address] ADD CONSTRAINT [PK__SeniorSy__ADA0CF274F068CDE] PRIMARY KEY CLUSTERED  ([EntityNo], [AddressNumber])
GO
