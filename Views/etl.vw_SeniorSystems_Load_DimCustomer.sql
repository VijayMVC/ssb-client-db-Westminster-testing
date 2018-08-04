SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


 --select * from [etl].[vw_SeniorSystems_Load_DimCustomer] where ssid =  10941
CREATE VIEW [etl].[vw_SeniorSystems_Load_DimCustomer] AS 

WITH dualprimay AS
(SELECT p.EntityNo,  MIN(ad.AddressNumber) Min_add  
,  MAX(ad.AddressNumber) Max_add 
FROM [ods].[SeniorSystems_persons] p 
JOIN ods.SeniorSystems_persons_Relationships r ON p.EntityNo = r.StudentEntityNo
LEFT JOIN (SELECT *, ROW_NUMBER() OVER(PARTITION BY entityno ORDER BY isactive DESC
								, CASE AddressCode WHEN 'Faculty Primary' THEN 1 WHEN 'Residential' THEN 2 WHEN 'Work' THEN 3 WHEN 'Other' THEN 4 WHEN 'Additional Contact' THEN 5 ELSE 6 END
								,LEN(address1) DESC) RN   FROM ods.SeniorSystems_persons_address) ad
					ON r.EntityNo = ad.EntityNo
					AND ad.rn=1
GROUP BY p.EntityNo
HAVING COUNT(DISTINCT ad.AddressNumber) > 1)
,ExcludeRec AS--10168
(SELECT DISTINCT a.EntityNo FROM ods.SeniorSystems_persons a 
		LEFT JOIN ods.SeniorSystems_persons_FacultyInfo b ON b.EntityNo = a.EntityNo
		LEFT JOIN (SELECT DISTINCT FamilyID,HouseholdID FROM ods.SeniorSystems_persons WHERE IsStudent = 'true' AND IsDeleted = 0) c
			ON c.FamilyID = a.FamilyID OR c.HouseholdID = a.HouseholdID
		WHERE ISNUMERIC(TRY_CAST(a.FamilyID AS INT)) = 1
		OR 	(a.FamilyID IN (SELECT DISTINCT FacultyID FROM  ods.SeniorSystems_persons) AND ISNULL(FacultyID,'')  = '')
		OR FullName LIKE '%/%'
		OR a.EntityNo IN ('38541')
		OR (ISNULL(b.IsActive,'') = 'False' AND NOT ISNULL(a.IsParent,'False') = 'True')
		OR (ISNULL(c.FamilyID,c.HouseholdID) IS NULL AND a.IsParent = 'true' AND ISNULL(b.IsActive,'') <> 'true')
)
 
( 
 
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
 
       SELECT * 
       /*Name*/ 
       , HASHBYTES('sha2_256', 
                                                  ISNULL(RTRIM(FullName),'DBNULL_TEXT')  
                                                  --+ ISNULL(RTRIM(Prefix),'DBNULL_TEXT')  
                                                  --+ ISNULL(RTRIM(FirstName),'DBNULL_TEXT') 
                                                  --+ ISNULL(RTRIM(MiddleName),'DBNULL_TEXT')   
                                                  --+ ISNULL(RTRIM(LastName),'DBNULL_TEXT')  
                                                  --+ ISNULL(RTRIM(Suffix),'DBNULL_TEXT') 
                                                  --+ ISNULL(RTRIM(CompanyName),'DBNULL_TEXT') 
                                                  ) AS [NameDirtyHash] 
       , CAST(NULL AS VARCHAR(50)) AS [NameIsCleanStatus] 
       , NULL AS [NameMasterId] 
 
       /*Address*/ 
       /*Address*/ 
       , HASHBYTES('sha2_256', ISNULL(RTRIM(AddressPrimaryStreet),'DBNULL_TEXT')  
                                                  + ISNULL(RTRIM(AddressPrimaryCity),'DBNULL_TEXT') 
                                                  + ISNULL(RTRIM(AddressPrimaryState),'DBNULL_TEXT')   
                                                  + ISNULL(RTRIM(AddressPrimaryZip),'DBNULL_TEXT')  
                                                  ---+ ISNULL(RTRIM(AddressPrimaryCounty),'DBNULL_TEXT') 
                                                  ---+ ISNULL(RTRIM(AddressPrimaryCountry),'DBNULL_TEXT') 
                                                  ) AS [AddressPrimaryDirtyHash] 
       , CAST(NULL AS VARCHAR(50)) AS [AddressPrimaryIsCleanStatus] 
       , NULL AS [AddressPrimaryMasterId] 
       , HASHBYTES('sha2_256', ISNULL(RTRIM(AddressOneStreet),'DBNULL_TEXT')  
                                                  + ISNULL(RTRIM(AddressOneCity),'DBNULL_TEXT') 
                                                  + ISNULL(RTRIM(AddressOneState),'DBNULL_TEXT')   
                                                  + ISNULL(RTRIM(AddressOneZip),'DBNULL_TEXT')  
                                                  ---+ ISNULL(RTRIM(AddressOneCounty),'DBNULL_TEXT') 
                                                  ---+ ISNULL(RTRIM(AddressOneCountry),'DBNULL_TEXT') 
                                                  ) AS [AddressOneDirtyHash] 
       , CAST(NULL AS VARCHAR(50)) AS [AddressOneIsCleanStatus] 
       , NULL AS [AddressOneMasterId] 
       , HASHBYTES('sha2_256', ISNULL(RTRIM(AddressTwoStreet),'DBNULL_TEXT')  
                                                  + ISNULL(RTRIM(AddressTwoCity),'DBNULL_TEXT') 
                                                  + ISNULL(RTRIM(AddressTwoState),'DBNULL_TEXT')   
                                                  + ISNULL(RTRIM(AddressTwoZip),'DBNULL_TEXT') 
                                                  ---+ ISNULL(RTRIM(AddressTwoCounty),'DBNULL_TEXT')  
                                                  ---+ ISNULL(RTRIM(AddressTwoCountry),'DBNULL_TEXT') 
                                                  ) AS [AddressTwoDirtyHash] 
       , CAST(NULL AS VARCHAR(50)) AS [AddressTwoIsCleanStatus] 
       , NULL AS [AddressTwoMasterId] 
       , HASHBYTES('sha2_256', ISNULL(RTRIM(AddressThreeStreet),'DBNULL_TEXT')  
                                                  + ISNULL(RTRIM(AddressThreeCity),'DBNULL_TEXT') 
                                                  + ISNULL(RTRIM(AddressThreeState),'DBNULL_TEXT')   
                                                  + ISNULL(RTRIM(AddressThreeZip),'DBNULL_TEXT')  
                                                  ---+ ISNULL(RTRIM(AddressThreeCounty),'DBNULL_TEXT') 
                                                  ---+ ISNULL(RTRIM(AddressThreeCountry),'DBNULL_TEXT') 
                                                  ) AS [AddressThreeDirtyHash] 
       , CAST(NULL AS VARCHAR(50)) AS [AddressThreeIsCleanStatus] 
       , NULL AS [AddressThreeMasterId] 
       , HASHBYTES('sha2_256', ISNULL(RTRIM(AddressFourStreet),'DBNULL_TEXT')  
                                                  + ISNULL(RTRIM(AddressFourCity),'DBNULL_TEXT') 
                                                  + ISNULL(RTRIM(AddressFourState),'DBNULL_TEXT')   
                                                  + ISNULL(RTRIM(AddressFourZip),'DBNULL_TEXT') 
                                                  ---+ ISNULL(RTRIM(AddressFourCounty),'DBNULL_TEXT')  
                                                  ---+ ISNULL(RTRIM(AddressFourCountry),'DBNULL_TEXT') 
                                                  ) AS [AddressFourDirtyHash] 
       , CAST(NULL AS VARCHAR(50)) AS [AddressFourIsCleanStatus] 
       , NULL AS [AddressFourMasterId] 
 
       /*Contact*/ 
       , NULL AS [ContactDirtyHash] 
       , NULL AS [ContactGuid] 
 
       /*Phone*/ 
       , HASHBYTES('sha2_256',       ISNULL(RTRIM(PhonePrimary),'DBNULL_TEXT')) AS [PhonePrimaryDirtyHash] 
       , CAST(NULL AS VARCHAR(50)) AS [PhonePrimaryIsCleanStatus] 
       , NULL AS [PhonePrimaryMasterId] 
       , HASHBYTES('sha2_256',       ISNULL(RTRIM(PhoneHome),'DBNULL_TEXT')) AS [PhoneHomeDirtyHash] 
       , CAST(NULL AS VARCHAR(50)) AS [PhoneHomeIsCleanStatus] 
       , NULL AS [PhoneHomeMasterId] 
       , HASHBYTES('sha2_256',       ISNULL(RTRIM(PhoneCell),'DBNULL_TEXT')) AS [PhoneCellDirtyHash] 
       , CAST(NULL AS VARCHAR(50)) AS [PhoneCellIsCleanStatus] 
       , NULL AS [PhoneCellMasterId] 
       , HASHBYTES('sha2_256',       ISNULL(RTRIM(PhoneBusiness),'DBNULL_TEXT')) AS [PhoneBusinessDirtyHash] 
       , CAST(NULL AS VARCHAR(50)) AS [PhoneBusinessIsCleanStatus] 
       , NULL AS [PhoneBusinessMasterId] 
       , HASHBYTES('sha2_256',       ISNULL(RTRIM(PhoneFax),'DBNULL_TEXT')) AS [PhoneFaxDirtyHash] 
       , CAST(NULL AS VARCHAR(50)) AS [PhoneFaxIsCleanStatus] 
       , NULL AS [PhoneFaxMasterId] 
       , HASHBYTES('sha2_256',       ISNULL(RTRIM(PhoneFax),'DBNULL_TEXT')) AS [PhoneOtherDirtyHash] 
       , CAST(NULL AS VARCHAR(50)) AS [PhoneOtherIsCleanStatus] 
       , NULL AS [PhoneOtherMasterId] 
 
       /*Email*/ 
       , HASHBYTES('sha2_256',       ISNULL(RTRIM(EmailPrimary),'DBNULL_TEXT')) AS [EmailPrimaryDirtyHash] 
       , CAST(NULL AS VARCHAR(50)) AS [EmailPrimaryIsCleanStatus] 
       , NULL AS [EmailPrimaryMasterId] 
       , HASHBYTES('sha2_256',       ISNULL(RTRIM(EmailOne),'DBNULL_TEXT')) AS [EmailOneDirtyHash] 
       , CAST(NULL AS VARCHAR(50)) AS [EmailOneIsCleanStatus] 
       , NULL AS [EmailOneMasterId] 
       , HASHBYTES('sha2_256',       ISNULL(RTRIM(EmailTwo),'DBNULL_TEXT')) AS [EmailTwoDirtyHash] 
       , CAST(NULL AS VARCHAR(50)) AS [EmailTwoIsCleanStatus] 
       , NULL AS [EmailTwoMasterId] 
 
        
 
 
 
 
 
       FROM ( 
--base set 
/* 
SELECT TOP 100 * 
FROM ods.TI_PatronMDM 
*/ 
              SELECT 
                      'Westminster' AS [SourceDB] 
                      , 'SeniorSystems' AS [SourceSystem] 
                      , 0 AS [SourceSystemPriority] --0-100 100 is higher Priority 
 
                      /*Standard Attributes*/ 
                      , CAST(p.EntityNo AS NVARCHAR(25)) [SSID] 
                      , CAST(CASE WHEN IsParent = 'true' THEN 'Parent'
									WHEN IsFaculty = 'true' THEN 'Faculty'
									WHEN IsStudent = 'true' THEN 'Student'
									ELSE 'Other' END AS NVARCHAR(50)) AS [CustomerType] 
                      , CAST(NULL AS NVARCHAR(50)) AS [CustomerStatus] 
                      , CAST(NULL AS NVARCHAR(50)) AS [AccountType]  
                      , CAST(NULL AS NVARCHAR(50)) AS [AccountRep]  
                      , CAST(NULL AS NVARCHAR(50)) AS [CompanyName]  
                      , p.PrefferedName AS [SalutationName] 
                      , NULL AS [DonorMailName] 
                      , NULL AS [DonorFormalName] 
                      , CAST(BirthDate AS DATE) AS [Birthday] 
                      , p.Gender AS [Gender] --ADD GENDER!! 
                      , 0 [MergedRecordFlag] 
                      , NULL [MergedIntoSSID] 
 
                      /**ENTITIES**/ 
                      /*Name*/                      
                      , REPLACE(FullName,',','') AS FullName 
                      , title AS [Prefix] 
                      , FirstName AS [FirstName] 
                      --, master.dbo.TI_FirstName(FullName) AS [FirstName] 
                      , MiddleName AS [MiddleName] 
                      , LastName AS [LastName] 
                      --, master.dbo.TI_LastName(FullName) AS [LastName] 
                      , ISNULL(REPLACE(Suffix,', ',''),'') AS [Suffix] 
                      --, c.name_title as [Title] 
 
                      /*AddressPrimary*/ 
                      , CASE WHEN ad.Address1 IS NOT NULL THEN CONCAT(ad.Address1,' ',ad.Address2,' ',ad.Address3) 	ELSE CONCAT(ad2.Address1,' ',ad2.Address2,' ',ad2.Address3) END AS [AddressPrimaryStreet] 
                      , CASE WHEN ad.Address1 IS NOT NULL THEN ad.City ELSE ad2.City END AS [AddressPrimaryCity]  
                      , CASE WHEN ad.Address1 IS NOT NULL THEN ad.State ELSE ad2.State END AS [AddressPrimaryState]  
                      , CASE WHEN ad.Address1 IS NOT NULL THEN ad.Zip ELSE ad2.zip END AS [AddressPrimaryZip]  
                      , NULL AS [AddressPrimaryCounty] 
                      , CASE WHEN ad.Address1 IS NOT NULL THEN ad.country ELSE ad2.Country END AS [AddressPrimaryCountry]  
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
                       
                      , CASE WHEN ad2.AddressNumber = dp.Min_add THEN CONCAT(xmax.Address1,' ',xmax.Address2,' ',xmax.Address3)
							ELSE CONCAT(xmin.Address1,' ',xmin.Address2,' ',xmin.Address3) END AS [AddressFourStreet] 
                      , CASE WHEN ad2.AddressNumber = dp.Min_add THEN xmax.City	ELSE xmin.city END AS [AddressFourCity]  
                      , CASE WHEN ad2.AddressNumber = dp.Min_add THEN xmax.State	ELSE xmin.State END AS [AddressFourState]  
                      , CASE WHEN ad2.AddressNumber = dp.Min_add THEN xmax.Zip	ELSE xmin.Zip END AS [AddressFourZip]  
                      , NULL AS [AddressFourCounty] 
                      , CASE WHEN ad2.AddressNumber = dp.Min_add THEN xmax.country	ELSE xmin.country END AS [AddressFourCountry]  
					  , NULL AddressFourSuite 
					  , NULL AddressFourStreetNCOAStatus 
 
                      /*Phone*/ 
                      --, CASE WHEN ad.Phone IS NOT NULL THEN CAST(ad.phone AS NVARCHAR(25)) ELSE CAST(ad2.phone AS NVARCHAR(25)) END AS [PhonePrimary] 
					  , CASE WHEN (Gender ='f' OR Title IN ('Mrs.','Ms.','Miss')) AND p.IsParent = 'true' AND ad.OtherNumberType2 ='Cell Mother' THEN ISNULL(NULLIF(ad.OtherNumber2,''),ad.phone)
							WHEN p.IsParent = 'true' AND ad.OtherNumberType1 ='Cell Father' THEN ISNULL(NULLIF(ad.OtherNumber1,''),ad.phone) 
							ELSE 
								CASE WHEN ad.Phone IS NOT NULL THEN CAST(ad.phone AS NVARCHAR(25)) ELSE CAST(ad2.phone AS NVARCHAR(25)) END
							END AS [PhonePrimary] 
                      , CASE WHEN ad.Phone IS NOT NULL THEN CAST(ad.OtherNumber1 AS NVARCHAR(25)) ELSE CAST(ad2.OtherNumber1 AS NVARCHAR(25)) END AS [PhoneHome] 
                      , CASE WHEN ad.Phone IS NOT NULL THEN CAST(ad.OtherNumber2 AS NVARCHAR(25)) ELSE CAST(ad2.OtherNumber2 AS NVARCHAR(25)) END AS [PhoneCell] 
                      , CASE WHEN ad.Phone IS NOT NULL THEN CAST(ad.OtherNumber3 AS NVARCHAR(25)) ELSE CAST(ad2.OtherNumber3 AS NVARCHAR(25)) END AS [PhoneBusiness] 
                      , CASE WHEN ad.Phone IS NOT NULL THEN CAST(ad.OtherNumber4 AS NVARCHAR(25)) ELSE CAST(ad2.OtherNumber4 AS NVARCHAR(25)) END AS [PhoneFax] 
                      , CAST(NULL AS NVARCHAR(25)) AS [PhoneOther] 
 
                      /*Email*/ 
                      , CASE WHEN (Gender ='f' OR Title IN ('Mrs.','Ms.','Miss')) AND p.IsParent = 'true' THEN COALESCE(NULLIF(ad.email2,''),ad2.email1,ad.email1)
							WHEN p.IsParent = 'true' THEN ISNULL(NULLIF(ad.email1,''),AD2.Email1) 
							ELSE 
							COALESCE(NULLIF(ISNULL(p.StudentEmail,CASE WHEN Ad.Email1 IS NOT NULL THEN AD.email1 ELSE AD2.Email1 END ),''),CASE WHEN Ad.email2 IS NOT NULL THEN AD.email2 ELSE AD2.email2 END) 
								END AS [EmailPrimary] 
                      , CASE WHEN Ad.email2 IS NOT NULL THEN AD.email2 ELSE AD2.email2 END AS [EmailOne] 
                      , NULL AS [EmailTwo] 
 
                      /*Extended Attributes*/ 
                      , CASE WHEN p.ConstituentClassYr = 0 THEN '' ELSE p.ConstituentClassYr END AS[ExtAttribute1] --nvarchar(100) 
                      , NULL AS[ExtAttribute2]  
                      , NULL AS[ExtAttribute3]  
                      , p.FamilyID AS[ExtAttribute4]  
                      , p.HouseholdID AS[ExtAttribute5]  
                      , NULL AS[ExtAttribute6]  
                      , NULL AS[ExtAttribute7]  
                      , NULL AS[ExtAttribute8]  
                      , CASE WHEN dp.EntityNo IS NOT NULL THEN 'SeniorSystems Dual Primary Address Student' END AS [ExtAttribute9]  
                      , CAST(p.EntityNo AS NVARCHAR(25)) AS[ExtAttribute10]  
 
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
                      , NULL [SSCreatedDate] 
                      , NULL [SSUpdatedDate] 
					  , ISNULL(CASE WHEN er.EntityNo IS NOT NULL THEN 1 END, p.IsDeleted) IsDeleted 
					  , NULL DeleteDate 
					  , GETDATE() CreatedDate 
					  , GETDATE() UpdatedDate 
 
					  , NULL Customer_Matchkey 
                      , NULL [AccountId] 
                      , CAST(NULL AS BIT) IsBusiness 
                       
				FROM [ods].[SeniorSystems_persons] p
				LEFT JOIN (SELECT *, ROW_NUMBER() OVER(PARTITION BY entityno ORDER BY isactive DESC, CASE WHEN LTRIM(RTRIM(Address1)) = '' THEN 2 ELSE 1 END
								, CASE AddressCode WHEN 'Faculty Primary' THEN 1 WHEN 'Residential' THEN 2 WHEN 'Work' THEN 3 WHEN 'Other' THEN 4 WHEN 'Additional Contact' THEN 5 ELSE 6 END
								,LEN(address1) DESC) RN   FROM ods.SeniorSystems_persons_address) ad
					ON p.EntityNo = ad.EntityNo
					AND ad.rn=1
				LEFT JOIN (SELECT *, ROW_NUMBER() OVER(PARTITION BY HouseholdID ORDER BY isactive DESC, CASE WHEN LTRIM(RTRIM(Address1)) = '' THEN 2 ELSE 1 END
								, CASE AddressCode WHEN 'Faculty Primary' THEN 1 WHEN 'Residential' THEN 2 WHEN 'Work' THEN 3 WHEN 'Other' THEN 4 WHEN 'Additional Contact' THEN 5 ELSE 6 END
								,LEN(address1) DESC) RN   FROM ods.SeniorSystems_persons_address) ad2
					ON p.HouseholdID = ad2.HouseholdID
					AND ad2.rn=1
				LEFT JOIN ods.SeniorSystems_persons_student stu
					ON p.EntityNo = stu.EntityNo
				LEFT JOIN dualprimay dp
					ON p.EntityNo = dp.EntityNo
				LEFT JOIN ods.SeniorSystems_persons_address xmin
					ON dp.Min_add = xmin.AddressNumber
					--AND LTRIM(RTRIM(xmin.Address1)) <> ''
				LEFT JOIN ods.SeniorSystems_persons_address xmax
					ON dp.Max_add = xmax.AddressNumber
				LEFT JOIN ExcludeRec er
					ON p.EntityNo = er.EntityNo
				--WHERE er.EntityNo IS NULL
					--AND LTRIM(RTRIM(xmax.Address1)) <> ''
              --AND updatedate > (GETDATE() - 2) 
              --AND Patron = '102394' 
 
       ) a 
 
) 
 







GO
