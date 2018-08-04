SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [segmentation].[vw__Primary_Customer]
AS
    ( 
	SELECT    ssbid.SSB_CRMSYSTEM_CONTACT_ID
              , dimcustomer.Prefix
              , dimcustomer.FirstName AS First_Name
              , dimcustomer.MiddleName AS Middle_Name
              , dimcustomer.LastName AS Last_Name
			  , dimcustomer.FullName AS Full_Name
              , dimcustomer.Suffix
              , dimcustomer.CompanyName AS Company_Name
              , dimcustomer.NameIsCleanStatus AS Name_Is_Clean_Status
              , dimcustomer.CustomerType AS Customer_Type
              , dimcustomer.CustomerStatus AS Customer_Status
              , dimcustomer.AccountType AS Account_Type
              , dimcustomer.AddressPrimaryStreet AS Primary_Address_Street
              , dimcustomer.AddressPrimaryCity AS Primary_Address_City
              , dimcustomer.AddressPrimaryState AS Primary_Address_State
              , dimcustomer.AddressPrimarySuite AS Primary_Address_Suite
              , dimcustomer.AddressPrimaryZip AS Primary_Address_Zip
              , LEFT(dimcustomer.AddressPrimaryZip, 3) AS Primary_Address_Zip3
              , dimcustomer.AddressPrimaryCounty AS Primary_Address_County
              , dimcustomer.AddressPrimaryCountry AS Primary_Address_Country
              , dimcustomer.AddressPrimaryIsCleanStatus AS Address_Primary_Is_Clean_Status
              , dimcustomer.PhonePrimary AS Phone_Primary
              , CAST(CASE WHEN dimcustomer.PhonePrimaryIsCleanStatus = 'Valid'
                          THEN SUBSTRING(dimcustomer.PhonePrimary, 2, 3)
                          ELSE NULL
                     END AS INT) AS Phone_Primary_Area_Code
              , dimcustomer.PhonePrimaryIsCleanStatus AS Phone_Primary_Is_Clean_Status
              , dimcustomer.EmailPrimary AS Primary_Email
              , RIGHT(dimcustomer.EmailPrimary,
                      LEN(dimcustomer.EmailPrimary) - CHARINDEX('@', dimcustomer.EmailPrimary)) Primary_Email_Domain
              , CASE WHEN dimcustomer.EmailPrimary IS NOT NULL
                          AND dimcustomer.EmailPrimary LIKE '%@%' THEN 1
                     ELSE 0
                END Primary_Email_Exists
              , dimcustomer.EmailPrimaryIsCleanStatus AS Email_Primary_Is_Clean_Status
              , dimcustomer.SourceSystem AS Primary_Record_Source_System
              , dimcustomer.SSID AS Primary_Record_Source_System_Id
              , dimcustomer.AccountId AS Archtics_Account_Id
              , dimcustomer.Gender
              , dimcustomer.PhonePrimaryDNC AS Phone_Primary_DNC
              , dimcustomer.Birthday AS Birth_Date
              , CASE WHEN dimcustomer.Birthday = '1900-01-01' THEN NULL
                     ELSE YEAR(dimcustomer.Birthday)
                END AS Birth_Year
              , CASE WHEN dimcustomer.Birthday = '1900-01-01' THEN NULL
                     ELSE MONTH(dimcustomer.Birthday)
                END AS Birth_Month
              , CASE WHEN dimcustomer.Birthday = '1900-01-01' THEN NULL
                     ELSE DAY(dimcustomer.Birthday)
                END AS Birth_Day
              , CASE WHEN dimcustomer.Birthday = '1900-01-01' THEN NULL
                     ELSE DATEDIFF(YEAR, dimcustomer.Birthday, GETDATE())
                END AS Age
              , ssbid.SSB_CRMSYSTEM_PRIMARY_FLAG AS SSB_Primary_Record_Flag
      FROM      dbo.DimCustomer dimcustomer WITH ( NOLOCK )
                JOIN dbo.dimcustomerssbid ssbid WITH ( NOLOCK ) ON ssbid.DimCustomerId = dimcustomer.DimCustomerId
	  WHERE ssbid.SSB_CRMSYSTEM_PRIMARY_FLAG = 1
	
	)

GO
