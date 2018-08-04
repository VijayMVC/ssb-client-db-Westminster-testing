SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



 
/*****Hash Rules for Reference****** 
WHEN 'int' THEN 'ISNULL(RTRIM(CONVERT(varchar(10),' + COLUMN_NAME + ')),''DBNULL_INT'')' 
WHEN 'bigint' THEN 'ISNULL(RTRIM(CONVERT(varchar(10),' + COLUMN_NAME + ')),''DBNULL_BIGINT'')' 
WHEN 'datetime' THEN 'ISNULL(RTRIM(CONVERT(varchar(25),' + COLUMN_NAME + ')),''DBNULL_DATETIME'')'   
WHEN 'datetime2' THEN 'ISNULL(RTRIM(CONVERT(varchar(25),' + COLUMN_NAME + ')),''DBNULL_DATETIME'')' 
WHEN 'date' THEN 'ISNULL(RTRIM(CONVERT(varchar(10),' + COLUMN_NAME + ',112)),''DBNULL_DATE'')'  
WHEN 'bit' THEN 'ISNULL(RTRIM(CONVERT(varchar(10),' + COLUMN_NAME + ')),''DBNULL_BIT'')'   
WHEN 'decimal' THEN 'ISNULL(RTRIM(CONVERT(varchar(25),'+ COLUMN_NAME + ')),''DBNULL_NUMBER'')'  
WHEN 'numeric' THEN 'ISNULL(RTRIM(CONVERT(varchar(25),'+ COLUMN_NAME + ')),''DBNULL_NUMBER'')'  
ELSE 'ISNULL(RTRIM(' + COLUMN_NAME + '),''DBNULL_TEXT'')' 
*****/ 
 
 CREATE VIEW [etl].[vw_Load_DimCustomer_RaisersEdge] AS 

(

	SELECT *
	/*Name*/
	, HASHBYTES('sha2_256',
							ISNULL(RTRIM(FullName),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(Prefix),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(FirstName),'DBNULL_TEXT')
							+ ISNULL(RTRIM(MiddleName),'DBNULL_TEXT')  
							+ ISNULL(RTRIM(LastName),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(Suffix),'DBNULL_TEXT')
							+ ISNULL(RTRIM(CompanyName),'DBNULL_TEXT')
							) AS [NameDirtyHash]
	, 'Dirty' AS [NameIsCleanStatus]
	, NULL AS [NameMasterId]

	/*Address*/
	/*Address*/
	, HASHBYTES('sha2_256', ISNULL(RTRIM(AddressPrimaryStreet),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(AddressPrimarySuite),'DBNULL_TEXT')
							+ ISNULL(RTRIM(AddressPrimaryCity),'DBNULL_TEXT')
							+ ISNULL(RTRIM(AddressPrimaryState),'DBNULL_TEXT')  
							+ ISNULL(RTRIM(AddressPrimaryZip),'DBNULL_TEXT') 
							---+ ISNULL(RTRIM(AddressPrimaryCounty),'DBNULL_TEXT')
							---+ ISNULL(RTRIM(AddressPrimaryCountry),'DBNULL_TEXT')
							) AS [AddressPrimaryDirtyHash]
	, 'Dirty' AS [AddressPrimaryIsCleanStatus]
	, NULL AS [AddressPrimaryMasterId]
	, HASHBYTES('sha2_256', ISNULL(RTRIM(AddressOneStreet),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(AddressOneSuite),'DBNULL_TEXT')
							+ ISNULL(RTRIM(AddressOneCity),'DBNULL_TEXT')
							+ ISNULL(RTRIM(AddressOneState),'DBNULL_TEXT')  
							+ ISNULL(RTRIM(AddressOneZip),'DBNULL_TEXT') 
							---+ ISNULL(RTRIM(AddressOneCounty),'DBNULL_TEXT')
							---+ ISNULL(RTRIM(AddressOneCountry),'DBNULL_TEXT')
							) AS [AddressOneDirtyHash]
	, 'Dirty' AS [AddressOneIsCleanStatus]
	, NULL AS [AddressOneMasterId]
	, HASHBYTES('sha2_256', ISNULL(RTRIM(AddressTwoStreet),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(AddressTwoSuite),'DBNULL_TEXT')
							+ ISNULL(RTRIM(AddressTwoCity),'DBNULL_TEXT')
							+ ISNULL(RTRIM(AddressTwoState),'DBNULL_TEXT')  
							+ ISNULL(RTRIM(AddressTwoZip),'DBNULL_TEXT')
							---+ ISNULL(RTRIM(AddressTwoCounty),'DBNULL_TEXT') 
							---+ ISNULL(RTRIM(AddressTwoCountry),'DBNULL_TEXT')
							) AS [AddressTwoDirtyHash]
	, 'Dirty' AS [AddressTwoIsCleanStatus]
	, NULL AS [AddressTwoMasterId]
	, HASHBYTES('sha2_256', ISNULL(RTRIM(AddressThreeStreet),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(AddressThreeSuite),'DBNULL_TEXT')
							+ ISNULL(RTRIM(AddressThreeCity),'DBNULL_TEXT')
							+ ISNULL(RTRIM(AddressThreeState),'DBNULL_TEXT')  
							+ ISNULL(RTRIM(AddressThreeZip),'DBNULL_TEXT') 
							---+ ISNULL(RTRIM(AddressThreeCounty),'DBNULL_TEXT')
							---+ ISNULL(RTRIM(AddressThreeCountry),'DBNULL_TEXT')
							) AS [AddressThreeDirtyHash]
	, 'Dirty' AS [AddressThreeIsCleanStatus]
	, NULL AS [AddressThreeMasterId]
	, HASHBYTES('sha2_256', ISNULL(RTRIM(AddressFourStreet),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(AddressFourSuite),'DBNULL_TEXT')
							+ ISNULL(RTRIM(AddressFourCity),'DBNULL_TEXT')
							+ ISNULL(RTRIM(AddressFourState),'DBNULL_TEXT')  
							+ ISNULL(RTRIM(AddressFourZip),'DBNULL_TEXT')
							---+ ISNULL(RTRIM(AddressFourCounty),'DBNULL_TEXT') 
							---+ ISNULL(RTRIM(AddressFourCountry),'DBNULL_TEXT')
							) AS [AddressFourDirtyHash]
	, 'Dirty' AS [AddressFourIsCleanStatus]
	, NULL AS [AddressFourMasterId]

	/*Contact*/
	, HASHBYTES('sha2_256', ISNULL(RTRIM(Prefix),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(FirstName),'DBNULL_TEXT')
							+ ISNULL(RTRIM(MiddleName),'DBNULL_TEXT')  
							+ ISNULL(RTRIM(LastName),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(Suffix),'DBNULL_TEXT')+ ISNULL(RTRIM(AddressPrimaryStreet),'DBNULL_TEXT')
							+ ISNULL(RTRIM(AddressPrimarySuite),'DBNULL_TEXT')
							+ ISNULL(RTRIM(AddressPrimaryCity),'DBNULL_TEXT')
							+ ISNULL(RTRIM(AddressPrimaryState),'DBNULL_TEXT')  
							+ ISNULL(RTRIM(AddressPrimaryZip),'DBNULL_TEXT') 
							--+ ISNULL(RTRIM(AddressPrimaryCounty),'DBNULL_TEXT')
							--+ ISNULL(RTRIM(AddressPrimaryCountry),'DBNULL_TEXT')
							) AS [ContactDirtyHash]

	/*Phone*/
	, HASHBYTES('sha2_256',	ISNULL(RTRIM(PhonePrimary),'DBNULL_TEXT')) AS [PhonePrimaryDirtyHash]
	, 'Dirty' AS [PhonePrimaryIsCleanStatus]
	, NULL AS [PhonePrimaryMasterId]
	, HASHBYTES('sha2_256',	ISNULL(RTRIM(PhoneHome),'DBNULL_TEXT')) AS [PhoneHomeDirtyHash]
	, 'Dirty' AS [PhoneHomeIsCleanStatus]
	, NULL AS [PhoneHomeMasterId]
	, HASHBYTES('sha2_256',	ISNULL(RTRIM(PhoneCell),'DBNULL_TEXT')) AS [PhoneCellDirtyHash]
	, 'Dirty' AS [PhoneCellIsCleanStatus]
	, NULL AS [PhoneCellMasterId]
	, HASHBYTES('sha2_256',	ISNULL(RTRIM(PhoneBusiness),'DBNULL_TEXT')) AS [PhoneBusinessDirtyHash]
	, 'Dirty' AS [PhoneBusinessIsCleanStatus]
	, NULL AS [PhoneBusinessMasterId]
	, HASHBYTES('sha2_256',	ISNULL(RTRIM(PhoneFax),'DBNULL_TEXT')) AS [PhoneFaxDirtyHash]
	, 'Dirty' AS [PhoneFaxIsCleanStatus]
	, NULL AS [PhoneFaxMasterId]
	, HASHBYTES('sha2_256',	ISNULL(RTRIM(PhoneOther),'DBNULL_TEXT')) AS [PhoneOtherDirtyHash]
	, 'Dirty' AS [PhoneOtherIsCleanStatus]
	, NULL AS [PhoneOtherMasterId]

	/*Email*/
	, HASHBYTES('sha2_256',	ISNULL(RTRIM(EmailPrimary),'DBNULL_TEXT')) AS [EmailPrimaryDirtyHash]
	, 'Dirty' AS [EmailPrimaryIsCleanStatus]
	, NULL AS [EmailPrimaryMasterId]
	, HASHBYTES('sha2_256',	ISNULL(RTRIM(EmailOne),'DBNULL_TEXT')) AS [EmailOneDirtyHash]
	, 'Dirty' AS [EmailOneIsCleanStatus]
	, NULL AS [EmailOneMasterId]
	, HASHBYTES('sha2_256',	ISNULL(RTRIM(EmailTwo),'DBNULL_TEXT')) AS [EmailTwoDirtyHash]
	, 'Dirty' AS [EmailTwoIsCleanStatus]
	, NULL AS [EmailTwoMasterId]

	
	/*Attributes*/
, HASHBYTES('sha2_256', ISNULL(RTRIM(customerType),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(CustomerStatus),'DBNULL_TEXT')
							+ ISNULL(RTRIM(AccountType),'DBNULL_TEXT')  
							+ ISNULL(RTRIM(AccountRep),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(CompanyName),'DBNULL_TEXT')
							+ ISNULL(RTRIM(SalutationName),'DBNULL_TEXT')
							+ ISNULL(RTRIM(DonorMailName),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(DonorFormalName),'DBNULL_TEXT')
							+ ISNULL(RTRIM(Birthday),'DBNULL_TEXT')  
							+ ISNULL(RTRIM(Gender),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(AccountId),'DBNULL_TEXT')
							+ ISNULL(RTRIM(MergedRecordFlag),'DBNULL_TEXT')
							+ ISNULL(RTRIM(MergedIntoSSID),'DBNULL_TEXT')
							+ ISNULL(RTRIM(IsBusiness),'DBNULL_TEXT')) AS [contactattrDirtyHash]

, HASHBYTES('sha2_256', ISNULL(RTRIM(ExtAttribute1),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(ExtAttribute2),'DBNULL_TEXT')
							+ ISNULL(RTRIM(ExtAttribute3),'DBNULL_TEXT')  
							+ ISNULL(RTRIM(ExtAttribute4),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(ExtAttribute5),'DBNULL_TEXT')
							+ ISNULL(RTRIM(ExtAttribute6),'DBNULL_TEXT')
							+ ISNULL(RTRIM(ExtAttribute7),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(ExtAttribute8),'DBNULL_TEXT')
							+ ISNULL(RTRIM(ExtAttribute9),'DBNULL_TEXT')  
							+ ISNULL(RTRIM(ExtAttribute10),'DBNULL_TEXT') 
							) AS [extattr1_10DirtyHash]

							, HASHBYTES('sha2_256', ISNULL(RTRIM(ExtAttribute11),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(ExtAttribute12),'DBNULL_TEXT')
							+ ISNULL(RTRIM(ExtAttribute13),'DBNULL_TEXT')  
							+ ISNULL(RTRIM(ExtAttribute14),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(ExtAttribute15),'DBNULL_TEXT')
							+ ISNULL(RTRIM(ExtAttribute16),'DBNULL_TEXT')
							+ ISNULL(RTRIM(ExtAttribute17),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(ExtAttribute18),'DBNULL_TEXT')
							+ ISNULL(RTRIM(ExtAttribute19),'DBNULL_TEXT')  
							+ ISNULL(RTRIM(ExtAttribute20),'DBNULL_TEXT') 
							) AS [extattr11_20DirtyHash]

							
, HASHBYTES('sha2_256', ISNULL(RTRIM(ExtAttribute21),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(ExtAttribute22),'DBNULL_TEXT')
							+ ISNULL(RTRIM(ExtAttribute23),'DBNULL_TEXT')  
							+ ISNULL(RTRIM(ExtAttribute24),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(ExtAttribute25),'DBNULL_TEXT')
							+ ISNULL(RTRIM(ExtAttribute26),'DBNULL_TEXT')
							+ ISNULL(RTRIM(ExtAttribute27),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(ExtAttribute28),'DBNULL_TEXT')
							+ ISNULL(RTRIM(ExtAttribute29),'DBNULL_TEXT')  
							+ ISNULL(RTRIM(ExtAttribute30),'DBNULL_TEXT') 
							) AS [extattr21_30DirtyHash]

							
, HASHBYTES('sha2_256', ISNULL(RTRIM(ExtAttribute31),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(ExtAttribute32),'DBNULL_TEXT')
							+ ISNULL(RTRIM(ExtAttribute33),'DBNULL_TEXT')  
							+ ISNULL(RTRIM(ExtAttribute34),'DBNULL_TEXT') 
							+ ISNULL(RTRIM(ExtAttribute35),'DBNULL_TEXT')
							) AS [extattr31_35DirtyHash]




	FROM (


--base set 
/* 
SELECT TOP 100 * 
FROM ods.TI_PatronMDM 
*/ 
              SELECT 
                      'Westminster' AS [SourceDB] 
                      , 'RaisersEdge' AS [SourceSystem] 
                      , 0 AS [SourceSystemPriority] --0-100 100 is higher Priority 
 
                      /*Standard Attributes*/ 
                      , CAST(c.constituent_id AS NVARCHAR(25)) [SSID] 
                      , CAST(c.type AS NVARCHAR(50)) AS [CustomerType] 
                      , CAST(CASE WHEN c.inactive = 'false' THEN 'Active' ELSE 'Inactive'END AS NVARCHAR(50)) AS [CustomerStatus] 
                      , CAST(NULL AS NVARCHAR(50)) AS [AccountType]  
                      , CAST(NULL AS NVARCHAR(50)) AS [AccountRep]  
                      , CAST(NULL AS NVARCHAR(50)) AS [CompanyName]  
                      , c.preferred_name AS [SalutationName] 
                      , NULL AS [DonorMailName] 
                      , NULL AS [DonorFormalName] 
                      , TRY_CAST(CONCAT(c.birthdate_year,'-',c.birthdate_month,'-',c.birthdate_day) AS DATE) AS [Birthday] 
                      , c.gender AS [Gender] --ADD GENDER!! 
                      , 0 [MergedRecordFlag] 
                      , NULL [MergedIntoSSID] 
 
                      /**ENTITIES**/ 
                      /*Name*/                      
                      , CONCAT(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(c.fullname,'deceased',''),'(decesased)',''),'(deceas)',''),'(DEC.)',''),'(deceases)',''),'()','')
							, CASE WHEN c.suffix IS NOT NULL THEN ' ' + REPLACE(c.suffix,',','') END)  AS FullName 
                      , c.title AS [Prefix] 
                      , REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(c.firstname,'deceased',''),'(decesased)',''),'(deceas)',''),'(DEC.)',''),'(deceases)',''),'()','')  AS [FirstName] 
                      --, master.dbo.TI_FirstName(FullName) AS [FirstName] 
                      , REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(c.middlename,'deceased',''),'(decesased)',''),'(deceas)',''),'(DEC.)',''),'(deceases)',''),'()','') AS [MiddleName] 
                      , REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(c.lastname,'deceased',''),'(decesased)',''),'(deceas)',''),'(DEC.)',''),'(deceases)',''),'()','') AS [LastName] 
                      --, master.dbo.TI_LastName(FullName) AS [LastName] 
                      , ISNULL(REPLACE(c.suffix,', ',''),'') AS [Suffix] 
                      --, c.name_title as [Title] 
 
                      /*AddressPrimary*/ 
                      , ad.address_lines AS [AddressPrimaryStreet] 
                      , ad.city AS [AddressPrimaryCity]  
                      , ad.state AS [AddressPrimaryState]  
                      , ad.postal_code AS [AddressPrimaryZip]  
                      , ad.county AS [AddressPrimaryCounty] 
                      , ad.country AS [AddressPrimaryCountry]  
					  , NULL AddressPrimarySuite 
					  , NULL AddressPrimaryNCOAStatus 
                       
                      , NULL AS [AddressOneStreet] 
                      , NULL AS [AddressOneCity]  
                      , NULL AS [AddressOneState]  
                      , NULL AS [AddressOneZip]  
                      , NULL AS [AddressOneCounty]  
                      , NULL AS [AddressOneCountry]  
					  , NULL AddressOneSuite 
					  , NULL AddressOneStreetNCOAStatus 
 
                      , NULL AS [AddressTwoStreet] 
                      , NULL AS [AddressTwoCity]  
                      , NULL AS [AddressTwoState]  
                      , NULL AS [AddressTwoZip]  
                      , NULL AS [AddressTwoCounty]  
                      , NULL AS [AddressTwoCountry]  
					  , NULL AddressTwoSuite 
					  , NULL AddressTwoStreetNCOAStatus 
 
                      , NULL AS [AddressThreeStreet] 
                      , NULL AS [AddressThreeCity]  
                      , NULL AS [AddressThreeState]  
                      , NULL AS [AddressThreeZip]  
                      , NULL AS [AddressThreeCounty]  
                      , NULL AS [AddressThreeCountry]  
					  , NULL AddressThreeSuite 
					  , NULL AddressThreeStreetNCOAStatus 
                       
                      , NULL AS [AddressFourStreet] 
                      , NULL AS [AddressFourCity]  
                      , NULL AS [AddressFourState]  
                      , NULL AS [AddressFourZip]  
                      , NULL AS [AddressFourCounty] 
                      , NULL AS [AddressFourCountry]  
					  , NULL AddressFourSuite 
					  , NULL AddressFourStreetNCOAStatus 
 
                      /*Phone*/ 
                      , CAST(pho.number AS NVARCHAR(25)) AS [PhonePrimary] 
                      , CAST(NULL AS NVARCHAR(25)) AS [PhoneHome] 
                      , CAST(NULL AS NVARCHAR(25)) AS [PhoneCell] 
                      , CAST(NULL AS NVARCHAR(25)) AS [PhoneBusiness] 
                      , CAST(NULL AS NVARCHAR(25)) AS [PhoneFax] 
                      , CAST(NULL AS NVARCHAR(25)) AS [PhoneOther] 
 
                      /*Email*/ 
                      , em.address AS [EmailPrimary] 
                      , NULL AS [EmailOne] 
                      , NULL AS [EmailTwo] 
 
                      /*Extended Attributes*/ 
                      , class.Class_of  AS[ExtAttribute1] --nvarchar(100) 
                      , NULL AS[ExtAttribute2]  
                      , NULL AS[ExtAttribute3]  
                      , CASE WHEN c.fullname LIKE '%deceased%' OR c.deceased ='true' THEN 'Deceased'END AS[ExtAttribute4]  
                      , NULL AS[ExtAttribute5]  
                      , NULL AS[ExtAttribute6]  
                      , NULL AS[ExtAttribute7]  
                      , cc.ConCodes AS[ExtAttribute8]  
                      , stud.customvalue AS[ExtAttribute9]  
                      , NULL AS[ExtAttribute10]  -- Grad Class 
 
                      , NULL AS [ExtAttribute11]  
                      , NULL AS [ExtAttribute12]  
                      , NULL AS [ExtAttribute13]  
                      , NULL AS [ExtAttribute14]  
                      , NULL AS [ExtAttribute15]  
                      , NULL AS [ExtAttribute16]  
                      , NULL AS [ExtAttribute17]  
                      , NULL AS [ExtAttribute18]  
                      , NULL AS [ExtAttribute19]  
                      , NULL AS [ExtAttribute20]   
 
                      , NULL AS [ExtAttribute21] --datetime 
                      , NULL AS [ExtAttribute22]  
                      , NULL AS[ExtAttribute23]  
                      , NULL AS [ExtAttribute24]  
                      , NULL AS [ExtAttribute25]  
                      , NULL AS [ExtAttribute26]  
                      , NULL AS [ExtAttribute27]  
                      , NULL AS [ExtAttribute28]  
                      , NULL AS [ExtAttribute29]  
                      , NULL AS [ExtAttribute30]   
 
                      , NULL AS [ExtAttribute31] 
                      , NULL AS [ExtAttribute32] 
                      , NULL AS [ExtAttribute33]  
                      , NULL AS [ExtAttribute34] 
                      , NULL AS [ExtAttribute35] 
 
                      /*Source Created and Updated*/ 
                      , NULL [SSCreatedBy] 
                      , NULL [SSUpdatedBy] 
                      , c.[date_added] [SSCreatedDate] 
                      , c.[date_modified] [SSUpdatedDate] 
					  , 0 IsDeleted 
					  , NULL DeleteDate 
					  , GETDATE() CreatedDate 
					  , GETDATE() UpdatedDate 
 
					  , NULL Customer_Matchkey 
                      , NULL [AccountId] 
                      , CAST(NULL AS BIT) IsBusiness 
                       
				FROM ODS.BlackBaud_constituents   c
				LEFT JOIN  ODS.BlackBaud_addresses ad
					ON c.address_id    = ad.Address_id
				LEFT JOIN  ODS.BlackBaud_emailaddresses em
					ON c.email_id    = em.Email_id
				LEFT JOIN  ODS.BlackBaud_phones pho
					ON c.phone_id    = pho.Phoneid  
				LEFT JOIN 
					(SELECT constituent_id, MAX(class_of) Class_of FROM [ods].[BlackBaud_education] WHERE school = 'Westminster Schools'  GROUP BY constituent_id) class
						ON c.constituent_id = class.constituent_id
				LEFT JOIN 
						(SELECT DISTINCT constituent_id, 
							SUBSTRING(
								(
									SELECT ','+A.description  AS [text()]
									FROM ods.BlackBaud_constituentcodes A
									WHERE a.constituent_id = b.constituent_id
									AND A.description IS NOT NULL
									ORDER BY A.description
									FOR XML PATH ('')
								), 2, 200) ConCodes
						FROM ods.BlackBaud_constituentcodes b
						WHERE inactive ='false' AND description IS NOT NULL) cc
					ON c.constituent_id = cc.constituent_id
				LEFT JOIN 
					(SELECT DISTINCT parent_id, customvalue FROM ods.BlackBaud_customfields WHERE category = 'Student Type'  AND  customvalue IN ('Current Student','Former Student')
					) stud
						ON c.constituent_id = stud.parent_id
				WHERE 1=1 
				--AND c.constituent_id = 106017
              --AND updatedate > (GETDATE() - 2) 
 
       ) a 
 
) 
 

 

 








GO
