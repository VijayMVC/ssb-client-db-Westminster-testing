SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
--USE [Westminster]
--GO
--/****** Object:  StoredProcedure [etl].[DimCustomer_MasterLoad]    Script Date: 1/4/2018 12:40:44 PM ******/
--SET ANSI_NULLS ON
--GO
--SET QUOTED_IDENTIFIER ON
--GO


CREATE PROCEDURE [dbo].[Detect_SIS_DataChanges]

AS
DECLARE @DaysBack INT = 7
DECLARE @person TABLE (EntityNo INT, Tablesk INT)
DECLARE @guts TABLE (EntityNo INT, FieldName VARCHAR(MAX), FieldValue VARCHAR(MAX), Record VARCHAR(10), ChangeDate DATE)

DECLARE @VerticalResults TABLE (EntityNo INT, FieldName VARCHAR(MAX), FieldValue VARCHAR(MAX), Record VARCHAR(10), ChangeDate DATE, ChangeType VARCHAR(50), Parent_EntityNo VARCHAR(50))
DECLARE @sen_stu TABLE (EntityNo INT , FamilyID VARCHAR(50), HouseholdID VARCHAR(50))

--Person
INSERT INTO @person SELECT EntityNo, MAX(SeniorSystems_personsSK) SeniorSystems_personsSK FROM ods.Snapshot_SeniorSystems_persons 
								WHERE CAST(RecordEndDate AS DATE) >  CAST(DATEADD(DAY,-ABS(@DaysBack),GETDATE()) AS DATE)
								GROUP BY EntityNo

	INSERT INTO @sen_stu
	SELECT DISTINCT a.EntityNo,a.FamilyID,a.HouseholdID FROM ods.SeniorSystems_persons a
		JOIN ods.SeniorSystems_persons_student b ON b.EntityNo = a.EntityNo
		WHERE a.IsDeleted = 0 AND b.StudentID IN (
					SELECT DISTINCT StudentID FROM ods.SeniorSystems_studentSectionsByStudentId
					WHERE CurrentYear = (SELECT TOP 1 CurrentYear FROM ods.SeniorSystems_schoolCurrentAcademicYear
												ORDER BY Pull_Date DESC) AND WithdrawMarkingPeriod = 0)


INSERT INTO @guts
SELECT * FROM (
		SELECT * FROM 
			(SELECT EntityNo,up.FieldName, up.FieldValue, 'Current' Record, xdate FROM 
										(SELECT a.EntityNo  , CAST(Title as varchar(MAX)) Title
															, CAST(FirstName as varchar(MAX)) FirstName
															,CAST(MiddleName		 as varchar(MAX)) MiddleName
															,CAST(LastName			 as varchar(MAX)) LastName
															,CAST(Suffix			 as varchar(MAX)) Suffix
															,CAST(PrefferedName		 as varchar(MAX)) PrefferedName
															,CAST(FullName			 as varchar(MAX)) FullName
															,CAST(Gender			 as varchar(MAX)) Gender
															,CAST(a.FamilyID			 as varchar(MAX)) FamilyID
															,CAST(a.HouseholdID		 as varchar(MAX)) HouseholdID
															,CAST(ParentType		 as varchar(MAX)) ParentType
															,CAST(ParentNameGroup	 as varchar(MAX)) ParentNameGroup
															,CAST(BirthDate			 as varchar(MAX)) BirthDate
															,CAST(ConstituentClassYr as varchar(MAX)) ConstituentClassYr
															,CAST(StudentEmail		 as varchar(MAX)) StudentEmail
															,CAST(a.IsDeleted		 as varchar(MAX)) IsDeleted
															,CAST(CASE WHEN a.IsDeleted = 1 AND bb.StudentNextGrade = '' AND a.ETL_UpdatedOn > '1/1/18' THEN 'Withdrawn' END AS VARCHAR(MAX)) IsWithdrawn
															,CAST(a.ETL_UpdatedOn AS DATE) AS xdate
											FROM ods.SeniorSystems_persons a 
											LEFT JOIN @person b ON b.EntityNo = a.EntityNo 
											LEFT JOIN ods.SeniorSystems_persons_student bb ON a.EntityNo = bb.EntityNo
											LEFT JOIN @sen_stu C ON C.EntityNo = a.EntityNo
											WHERE b.EntityNo IS NOT NULL OR CAST(a.ETL_CreatedOn AS DATE) >  CAST(DATEADD(DAY,-ABS(@DaysBack),GETDATE()) AS DATE)  
												) cp
					UNPIVOT
					(FieldValue FOR FieldName IN (Title,FirstName,MiddleName,LastName,Suffix,PrefferedName,FullName,Gender,FamilyID,HouseholdID,ParentType,ParentNameGroup,BirthDate,ConstituentClassYr,StudentEmail,IsDeleted,IsWithdrawn)
					) AS up
					) x
					UNION ALL 
			SELECT * FROM 
					(SELECT EntityNo,up.FieldName, up.FieldValue, 'Previous' Record,xdate  FROM 
										(SELECT a.EntityNo  , CAST(Title as varchar(MAX)) Title
															, CAST(FirstName as varchar(MAX)) FirstName
															,CAST(MiddleName		 as varchar(MAX)) MiddleName
															,CAST(LastName			 as varchar(MAX)) LastName
															,CAST(Suffix			 as varchar(MAX)) Suffix
															,CAST(PrefferedName		 as varchar(MAX)) PrefferedName
															,CAST(FullName			 as varchar(MAX)) FullName
															,CAST(Gender			 as varchar(MAX)) Gender
															,CAST(FamilyID			 as varchar(MAX)) FamilyID
															,CAST(HouseholdID		 as varchar(MAX)) HouseholdID
															,CAST(ParentType		 as varchar(MAX)) ParentType
															,CAST(ParentNameGroup	 as varchar(MAX)) ParentNameGroup
															,CAST(BirthDate			 as varchar(MAX)) BirthDate
															,CAST(ConstituentClassYr as varchar(MAX)) ConstituentClassYr
															,CAST(StudentEmail		 as varchar(MAX)) StudentEmail
															,CAST(a.IsDeleted		 as varchar(MAX)) IsDeleted
															,CAST(a.RecordEndDate AS DATE) AS xdate
											FROM ods.Snapshot_SeniorSystems_persons a JOIN @person b ON b.Tablesk = a.SeniorSystems_personsSK ) cp
					UNPIVOT
					(FieldValue FOR FieldName IN (Title,FirstName,MiddleName,LastName,Suffix,PrefferedName,FullName,Gender,FamilyID,HouseholdID,ParentType,ParentNameGroup,BirthDate,ConstituentClassYr,StudentEmail,IsDeleted)
					) AS up
					) y

		)z


INSERT INTO @VerticalResults
SELECT aa.*,CASE WHEN bb.Row_Count = 2 THEN 'Data chage'
				WHEN aa.Record ='Current' THEN 'Data Added'
				WHEN aa.Record ='Previous' THEN 'Data Added' 
			END AS ChangeType
			,NULL Parent_EntityNo
			--INTO #temp
		FROM @guts aa
	INNER JOIN (
		SELECT EntityNo, z.FieldName
				,COUNT(1) Row_Count
				,COUNT(DISTINCT z.FieldValue) value_Count
				--,MAX(z.xdate) xDate
					 FROM @guts z
		GROUP BY EntityNo, z.FieldName
		HAVING COUNT(1) = 1 OR COUNT(1) = 2 AND COUNT(DISTINCT z.FieldValue) = 2
		)bb 
			ON bb.EntityNo = aa.EntityNo AND bb.FieldName = aa.FieldName
		WHERE NOT (aa.fieldname = 'isdeleted' AND ChangeDate < '2017-10-16')
			


--Address
DELETE  @person
DELETE  @guts

INSERT INTO @person SELECT EntityNo, MAX(SeniorSystems_persons_addressSK) Tablesk FROM ods.Snapshot_SeniorSystems_persons_address
								WHERE CAST(RecordEndDate AS DATE) >  CAST(DATEADD(DAY,-ABS(@DaysBack),GETDATE()) AS DATE)
								GROUP BY EntityNo

INSERT INTO @guts
SELECT * FROM (
		SELECT * FROM 
			(SELECT EntityNo,up.FieldName, up.FieldValue, 'Current' Record, xdate FROM 
										(SELECT a.EntityNo  , CAST(CASE WHEN a.AddressCode = 'Residential' 
																	THEN CONCAT(a.Address1,' ',a.Address2,' ',a.City,' ',a.State,' ',a.zip) END as varchar(MAX)) Address
															, CASE WHEN ((p.ParentNameGroup ='Name1' AND a.InternalAddressCode = 'P1FW:' )
																OR  (p.ParentNameGroup ='Name2' AND a.InternalAddressCode = 'P1MW:' ))
																	THEN  CAST(CONCAT(a.Address1,' ',a.Address2,' ',a.City,' ',a.State,' ',a.zip) as varchar(MAX)) END BusinessAddress
															--, CAST(a.Address2 as varchar(MAX)) Address2
															--, CAST(a.City as varchar(MAX)) City
															--, CAST(a.State as varchar(MAX)) State
															--, CAST(a.zip as varchar(MAX)) zip
															, CAST(a.Phone as varchar(MAX)) Phone
															, CASE WHEN p.ParentNameGroup ='Name1' THEN CAST(a.Email1 as varchar(MAX)) END Email1
															, CASE WHEN p.ParentNameGroup ='Name2' THEN CAST(a.Email2 as varchar(MAX)) END Email2
															, CASE WHEN p.ParentNameGroup ='Name1' THEN CAST(CONCAT(a.OtherNumberType1,': ', a.OtherNumber1) as varchar(MAX)) END OtherNumber1
															, CASE WHEN p.ParentNameGroup ='Name2' THEN CAST(CONCAT(a.OtherNumberType2,': ',a.OtherNumber2) as varchar(MAX)) END OtherNumber2
															, CAST(CONCAT(a.OtherNumberType3,': ', a.OtherNumber3) as varchar(MAX)) OtherNumber3
															, CAST(CONCAT(a.OtherNumberType4,': ',a.OtherNumber4) as varchar(MAX)) OtherNumber4
															, CASE WHEN ((p.ParentNameGroup ='Name1' AND a.InternalAddressCode = 'P1FW:' )
																OR  (p.ParentNameGroup ='Name2' AND a.InternalAddressCode = 'P1MW:' ))
																	THEN   CAST(a.CompanyName as varchar(MAX)) END CompanyName
															, CASE WHEN ((p.ParentNameGroup ='Name1' AND a.InternalAddressCode = 'P1FW:') 
																OR  (p.ParentNameGroup ='Name2' AND a.InternalAddressCode = 'P1MW:' ))
																	THEN CAST(a.JobTitle as varchar(MAX)) END JobTitle
															,CAST(a.ETL_UpdatedOn AS DATE) AS xdate
											FROM ods.SeniorSystems_persons_address a 
											JOIN ods.SeniorSystems_persons p ON p.EntityNo = a.EntityNo
											LEFT JOIN @person b ON b.EntityNo = a.EntityNo 
											WHERE b.EntityNo IS NOT NULL OR CAST(a.ETL_CreatedOn AS DATE) >  CAST(DATEADD(DAY,-ABS(@DaysBack),GETDATE()) AS DATE)  ) cp
					UNPIVOT
					(FieldValue FOR FieldName IN (Address,Phone,Email1,Email2,OtherNumber1,OtherNumber2,OtherNumber3,OtherNumber4,CompanyName,JobTitle,BusinessAddress)
					) AS up
					) x
					UNION ALL 
			SELECT * FROM 
					(SELECT EntityNo,up.FieldName, up.FieldValue, 'Previous' Record,xdate  FROM 
										(SELECT a.EntityNo  , CAST(CASE WHEN a.AddressCode = 'Residential' 
																	THEN CONCAT(a.Address1,' ',a.Address2,' ',a.City,' ',a.State,' ',a.zip) END as varchar(MAX)) Address
															, CASE WHEN ((p.ParentNameGroup ='Name1' AND a.InternalAddressCode = 'P1FW:' )
																OR  (p.ParentNameGroup ='Name2' AND a.InternalAddressCode = 'P1MW:' ))
																	THEN  CAST(CONCAT(a.Address1,' ',a.Address2,' ',a.City,' ',a.State,' ',a.zip) as varchar(MAX)) END BusinessAddress
															--, CAST(a.Address2 as varchar(MAX)) Address2
															--, CAST(a.City as varchar(MAX)) City
															--, CAST(a.State as varchar(MAX)) State
															--, CAST(a.zip as varchar(MAX)) zip
															, CAST(a.Phone as varchar(MAX)) Phone
															, CASE WHEN p.ParentNameGroup ='Name1' THEN CAST(a.Email1 as varchar(MAX)) END Email1
															, CASE WHEN p.ParentNameGroup ='Name2' THEN CAST(a.Email2 as varchar(MAX)) END Email2
															, CASE WHEN p.ParentNameGroup ='Name1' THEN CAST(CONCAT(a.OtherNumberType1,': ', a.OtherNumber1) as varchar(MAX)) END OtherNumber1
															, CASE WHEN p.ParentNameGroup ='Name2' THEN CAST(CONCAT(a.OtherNumberType2,': ',a.OtherNumber2) as varchar(MAX)) END OtherNumber2
															, CAST(CONCAT(a.OtherNumberType3,': ', a.OtherNumber3) as varchar(MAX)) OtherNumber3
															, CAST(CONCAT(a.OtherNumberType4,': ',a.OtherNumber4) as varchar(MAX)) OtherNumber4
															, CASE WHEN ((p.ParentNameGroup ='Name1' AND a.InternalAddressCode = 'P1FW:' )
																OR  (p.ParentNameGroup ='Name2' AND a.InternalAddressCode = 'P1MW:' ))
																	THEN   CAST(a.CompanyName as varchar(MAX)) END CompanyName
															, CASE WHEN ((p.ParentNameGroup ='Name1' AND a.InternalAddressCode = 'P1FW:') 
																OR  (p.ParentNameGroup ='Name2' AND a.InternalAddressCode = 'P1MW:' ))
																	THEN CAST(a.JobTitle as varchar(MAX)) END JobTitle
															,CAST(a.RecordEndDate AS DATE) AS xdate
											FROM ods.Snapshot_SeniorSystems_persons_address a 
											JOIN ods.SeniorSystems_persons p ON p.EntityNo = a.EntityNo
											JOIN @person b ON b.Tablesk = a.SeniorSystems_persons_addressSK ) cp
					UNPIVOT
					(FieldValue FOR FieldName IN (Address,Phone,Email1,Email2,OtherNumber1,OtherNumber2,OtherNumber3,OtherNumber4,CompanyName,JobTitle,BusinessAddress)
					) AS up
					) y

		)z


INSERT INTO @VerticalResults
SELECT aa.*,CASE WHEN bb.Row_Count = 2 THEN 'Data chage'
				WHEN aa.Record ='Current' THEN 'Data Added'
				WHEN aa.Record ='Previous' THEN 'Data Added' 
			END AS ChangeType
			,NULL Parent_EntityNo
			--INTO #temp
		FROM @guts aa
	INNER JOIN (
		SELECT EntityNo, z.FieldName
				,COUNT(1) Row_Count
				,COUNT(DISTINCT z.FieldValue) value_Count
				--,MAX(z.xdate) xDate
					 FROM @guts z
		GROUP BY EntityNo, z.FieldName
		HAVING COUNT(1) = 1 OR COUNT(1) = 2 AND COUNT(DISTINCT z.FieldValue) = 2
		)bb 
			ON bb.EntityNo = aa.EntityNo AND bb.FieldName = aa.FieldName
		WHERE NOT (aa.fieldname = 'isdeleted' AND ChangeDate < '2017-10-16')
			

--Students
DELETE  @person
DELETE  @guts

INSERT INTO @person SELECT EntityNo, MAX(SeniorSystems_persons_studentSK) Tablesk FROM ods.Snapshot_SeniorSystems_persons_student
								WHERE CAST(RecordEndDate AS DATE) >  CAST(DATEADD(DAY,-ABS(@DaysBack),GETDATE()) AS DATE)
								GROUP BY EntityNo

INSERT INTO @guts
SELECT * FROM (
		SELECT * FROM 
			(SELECT EntityNo,up.FieldName, up.FieldValue, 'Current' Record, xdate FROM 
										(SELECT a.EntityNo  , CAST(a.AcademicGroup as varchar(MAX)) AcademicGroup
															, CAST(a.StudentTelephoneNumber AS varchar(MAX)) StudentTelephoneNumber
															, CAST(a.EnrollmentStatus as varchar(MAX)) EnrollmentStatus
															, CAST(a.AdmissionsYr as varchar(MAX)) AdmissionsYr
															,CAST(a.ETL_UpdatedOn AS DATE) AS xdate
											FROM ods.Snapshot_SeniorSystems_persons_student a 
											LEFT JOIN @person b ON b.EntityNo = a.EntityNo 
											WHERE b.EntityNo IS NOT NULL OR CAST(a.ETL_CreatedOn AS DATE) >  CAST(DATEADD(DAY,-ABS(@DaysBack),GETDATE()) AS DATE)  ) cp
					UNPIVOT
					(FieldValue FOR FieldName IN (AcademicGroup,StudentTelephoneNumber,EnrollmentStatus,AdmissionsYr)
					) AS up
					) x
					UNION ALL 
			SELECT * FROM 
					(SELECT EntityNo,up.FieldName, up.FieldValue, 'Previous' Record,xdate  FROM 
										(SELECT a.EntityNo  , CAST(a.AcademicGroup as varchar(MAX)) AcademicGroup
															, CAST(a.StudentTelephoneNumber AS varchar(MAX)) StudentTelephoneNumber
															, CAST(a.EnrollmentStatus as varchar(MAX)) EnrollmentStatus
															, CAST(a.AdmissionsYr as varchar(MAX)) AdmissionsYr
															,CAST(a.RecordEndDate AS DATE) AS xdate
											FROM ods.Snapshot_SeniorSystems_persons_student a JOIN @person b ON b.Tablesk = a.SeniorSystems_persons_studentSK ) cp
					UNPIVOT
					(FieldValue FOR FieldName IN (AcademicGroup,StudentTelephoneNumber,EnrollmentStatus,AdmissionsYr)
					) AS up
					) y

		)z


INSERT INTO @VerticalResults
SELECT aa.*,CASE WHEN bb.Row_Count = 2 THEN 'Data chage'
				WHEN aa.Record ='Current' THEN 'Data Added'
				WHEN aa.Record ='Previous' THEN 'Data Added' 
			END AS ChangeType
			,NULL Parent_EntityNo
			--,bb.*
			--INTO #temp
		FROM @guts aa
	INNER JOIN (
		SELECT EntityNo, z.FieldName
				,COUNT(1) Row_Count
				,COUNT(DISTINCT z.FieldValue) value_Count
				--,MAX(z.xdate) xDate
					 FROM @guts z
		GROUP BY EntityNo, z.FieldName
		HAVING COUNT(1) = 1 OR COUNT(1) = 2 AND COUNT(DISTINCT z.FieldValue) = 2
		)bb 
			ON bb.EntityNo = aa.EntityNo AND bb.FieldName = aa.FieldName

--Relationships
DELETE  @person
DELETE  @guts

INSERT INTO @person SELECT StudentEntityNo, MAX(SeniorSystems_persons_RelationshipsSK) Tablesk FROM ods.Snapshot_SeniorSystems_persons_Relationships
								WHERE CAST(RecordEndDate AS DATE) >  CAST(DATEADD(DAY,-ABS(@DaysBack),GETDATE()) AS DATE)
								GROUP BY StudentEntityNo

INSERT INTO @guts
SELECT * FROM (
		SELECT * FROM 
			(SELECT StudentEntityNo,up.FieldName, up.FieldValue, 'Current' Record, xdate FROM 
										(SELECT a.StudentEntityNo 
															, CAST(a.FamilyID as varchar(MAX)) FamilyID
															, CAST(a.Relationship AS varchar(MAX)) Relationship
															, CAST(a.EntityNo as varchar(MAX)) ParentEntityNo
															,CAST(a.ETL_UpdatedOn AS DATE) AS xdate
											FROM ods.Snapshot_SeniorSystems_persons_Relationships a 
											LEFT JOIN @person b ON b.EntityNo = a.StudentEntityNo 
											WHERE b.EntityNo IS NOT NULL OR CAST(a.ETL_CreatedOn AS DATE) >  CAST(DATEADD(DAY,-ABS(@DaysBack),GETDATE()) AS DATE)  ) cp
					UNPIVOT
					(FieldValue FOR FieldName IN (FamilyID,Relationship,ParentEntityNo)
					) AS up
					) x
					UNION ALL 
			SELECT * FROM 
					(SELECT StudentEntityNo,up.FieldName, up.FieldValue, 'Previous' Record,xdate  FROM 
										(SELECT a.StudentEntityNo  
															, CAST(a.FamilyID as varchar(MAX)) FamilyID
															, CAST(a.Relationship AS varchar(MAX)) Relationship
															, CAST(a.EntityNo as varchar(MAX)) ParentEntityNo
															,CAST(a.RecordEndDate AS DATE) AS xdate
											FROM ods.Snapshot_SeniorSystems_persons_Relationships a JOIN @person b ON b.Tablesk = a.SeniorSystems_persons_RelationshipsSK ) cp
					UNPIVOT
					(FieldValue FOR FieldName IN (FamilyID,Relationship,ParentEntityNo)
					) AS up
					) y

		)z


INSERT INTO @VerticalResults
SELECT aa.*,CASE WHEN bb.Row_Count = 2 THEN 'Data chage'
				WHEN aa.Record ='Current' THEN 'Data Added'
				WHEN aa.Record ='Previous' THEN 'Data Added' 
			END AS ChangeType
			,NULL Parent_EntityNo
			--,bb.*
			--INTO #temp
		FROM @guts aa
	INNER JOIN (
		SELECT EntityNo, z.FieldName
				,COUNT(1) Row_Count
				,COUNT(DISTINCT z.FieldValue) value_Count
				--,MAX(z.xdate) xDate
					 FROM @guts z
		GROUP BY EntityNo, z.FieldName
		HAVING COUNT(1) = 1 OR COUNT(1) = 2 AND COUNT(DISTINCT z.FieldValue) = 2
		)bb 
			ON bb.EntityNo = aa.EntityNo AND bb.FieldName = aa.FieldName

INSERT INTO @VerticalResults
SELECT DISTINCT c.EntityNo,a.FieldName, a.FieldValue,a.Record,a.ChangeDate,a.ChangeType ,b.EntityNo Parent_SSID
	FROM @VerticalResults a JOIN ods.SeniorSystems_persons b ON a.EntityNo = b.EntityNo JOIN ods.SeniorSystems_persons c ON b.FamilyID = c.FamilyID OR b.HouseholdID = c.HouseholdID 
		WHERE b.IsStudent = 'false' AND c.IsStudent = 'true'
		AND a.FieldName IN ('IsDeleted','Email1','Email2')
		ORDER BY 5,1,2,4 desc
	
	
	INSERT INTO dbo.SIS_DataChanges
	
	SELECT new.EntityNo,
           new.ChangeDate,
           new.FieldName,
           new.CurrentValue,
           new.PreviousValue,
           new.ChangeType,
           NULLIF(new.Parent_EntityNo,0)
	FROM (	
	SELECT ISNULL(a.EntityNo,b.EntityNo) EntityNo, ISNULL(a.ChangeDate, b.ChangeDate) ChangeDate, REPLACE(ISNULL(a.FieldName,b.FieldName),'PrefferedName','PreferredName') FieldName, a.FieldValue CurrentValue, b.FieldValue PreviousValue
			,ISNULL(a.ChangeType,b.ChangeType) ChangeType 
			--,ISNULL(a.Parent_EntityNo,b.Parent_EntityNo) Parent_EntityNo
			,MIN(COALESCE(a.Parent_EntityNo,b.Parent_EntityNo,0)) Parent_EntityNo
			FROM 
			(SELECT * FROM @VerticalResults WHERE Record ='Current') a
			FULL OUTER JOIN (SELECT * FROM @VerticalResults WHERE Record ='Previous') b
				ON b.EntityNo = a.EntityNo
					AND b.FieldName = a.FieldName
		GROUP BY ISNULL(a.EntityNo,b.EntityNo), ISNULL(a.ChangeDate, b.ChangeDate), ISNULL(a.FieldName,b.FieldName), a.FieldValue, b.FieldValue
		,ISNULL(a.ChangeType,b.ChangeType) 
					) new
			LEFT JOIN dbo.SIS_DataChanges old
				ON new.EntityNo = old.SSID
				AND old.FieldName = new.FieldName
				AND old.ChangeDate = new.ChangeDate
			WHERE old.SSID IS NULL 
			AND  NOT (new.CurrentValue = ':' AND new.PreviousValue IS NULL)
			AND NOT (ISNULL(new.CurrentValue,'') = '' AND ISNULL(new.PreviousValue,'') = '' )
			
			ORDER BY 2, 1,3


			--truncate table SIS_DataChanges
			--SELECT * FROM dbo.SIS_DataChanges ORDER BY 3,4
			--SELECT * FROM dbo.SIS_DataChanges WHERE ssid = 5903


			


		
GO
