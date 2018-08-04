SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROC [dbo].[ValidateSISChanges] 
@BizRuleSK INT
AS
--Exec [dbo].[ValidateSISChanges] 18

EXEC dbo.Detect_SIS_DataChanges

--#RuleResults (SSID,SourceSystem,BizRuleSK,BizRuleSubscriptionSK,Result,Constituent_ID,EntityNo,UID,OtherID,SourceOtherID,FieldHash)
--Define upper and middle students
	IF OBJECT_ID('tempdb..#UpperMiddle') IS NOT NULL 
			DROP TABLE #UpperMiddle  

SELECT a.EntityNo, 'Student' ConstitType INTO #UpperMiddle FROM ods.SeniorSystems_persons a JOIN ods.SeniorSystems_persons_student b ON b.EntityNo = a.EntityNo
WHERE a.IsDeleted = 0 AND StudentCurrentSchool IN ('US','MS')
UNION
SELECT c.EntityNo, 'Parent' ConstitType FROM ods.SeniorSystems_persons a JOIN ods.SeniorSystems_persons_student b ON b.EntityNo = a.EntityNo JOIN ods.SeniorSystems_persons c ON c.FamilyID = a.FamilyID OR c.HouseholdID = a.HouseholdID
WHERE a.IsDeleted = 0 AND StudentCurrentSchool IN ('US','MS') AND c.EntityNo NOT IN (SELECT EntityNo FROM ods.SeniorSystems_persons_student)

	IF OBJECT_ID('tempdb..#changes') IS NOT NULL 
			DROP TABLE #changes  

SELECT DataChangeID, SSID,ChangeDate,FieldName,Current_Value,Previous_Value,ChangeType,ParentSSID 
INTO #changes FROM (SELECT *, ROW_NUMBER() OVER(PARTITION BY SSID, FieldName ORDER BY ChangeDate DESC, LEN(Current_Value)) RN FROM dbo.SIS_DataChanges )x WHERE rn = 1

INSERT INTO dbo.BizRule_SingleValidationResults
	(SSID
	,SourceSystem
	,BizRuleSK
	,BizRuleSubscriptionSK
	,RESULT
	,Constituent_ID
	,EntityNo
	,UID
	,OtherID
	,FieldHash)
SELECT DISTINCT SSID+'-'+a.FieldName,'SeniorSystems' SourceSystem, @BizRuleSK BizRuleSK
,b.BizRuleSubscriptionSK,'n/a' Result,NULL Constituent_ID,SSID,NULL UID,DataChangeID OtherID , HASHBYTES('sha2_256', CAST(DataChangeID AS VARCHAR(20)) )   FieldHash
FROM #changes a
JOIN ods.SeniorSystems_persons p ON a.SSID = p.EntityNo
LEFT JOIN ods.SeniorSystems_persons_student stud ON a.ssid = stud.EntityNo
LEFT JOIN  #UpperMiddle up ON a.SSID = up.EntityNo
CROSS JOIN (SELECT * FROM dbo.BizRule_Subscription WHERE BizRuleSK = @BizRuleSK) b
WHERE a.ChangeDate > = '1/1/18' AND
	--Naviance Rules
	(
	(b.SourceSystem = 'Naviance' AND up.EntityNo IS NOT NULL AND TRY_CAST(stud.StudentCurrentGrade AS INT) >=9)
	--Schoology Rules
	OR (b.SourceSystem = 'Schoology' AND (p.IsStudent = 'true' OR p.IsFaculty = 'true') AND a.FieldName IN ('FirstName','PreferredName','MiddleName','LastName','FullName','Title','Suffix','ConstituentClassYr','Gender'
																												,'StudentEmail','Email1','Email2','BirthDate','AcademicGroup','EnrollmentStatus'))
	--Library Rules
	OR (b.SourceSystem = 'Library System' AND ((p.IsStudent = 'true' AND up.EntityNo IS  NULL AND a.FieldName IN ('FirstName','PreferredName','MiddleName','LastName','FullName','Title','Suffix','FamilyID','HouseholdID'
																													,'ParentNameGroup','ParentType','Email1','Email2','Gender','AcademicGroup','EnrollmentStatus'))
											OR (up.EntityNo IS NOT NULL AND up.ConstitType = 'Student' AND a.FieldName IN ('FirstName','PreferredName','MiddleName','LastName','FullName','Title','Suffix','FamilyID','HouseholdID'
																													,'ParentNameGroup','ParentType','StudentEmail','Gender','AcademicGroup','EnrollmentStatus'))))
	--Athletic Rules
	OR (b.SourceSystem = 'Athletics' AND p.IsStudent = 'true' AND TRY_CAST(stud.StudentCurrentGrade AS INT) >=6
	 AND a.FieldName IN ('FirstName','PreferredName','MiddleName','LastName','FullName','Title','Suffix','Gender','StudentEmail','AcademicGroup','EnrollmentStatus'))
	--Magnus Rules
	OR (b.SourceSystem = 'Magnus' AND p.IsStudent = 'true' AND a.FieldName IN ('FirstName','PreferredName','MiddleName','LastName','FullName','Title','Suffix','Gender','AcademicGroup','EnrollmentStatus','FamilyID','HouseholdID'
																													,'ParentNameGroup','ParentType'))
	--IT/Communications Rules
	OR (b.SourceSystem = 'IT/Communications' AND p.IsStudent = 'true' AND a.FieldName IN ('FirstName','PreferredName','MiddleName','LastName','FullName','Title','Suffix','Gender','AcademicGroup','EnrollmentStatus','FamilyID','HouseholdID'
																													))
	OR a.FieldName = 'IsWithdrawn'
	)
AND a.FieldName NOT IN ('FirstName','MiddleName','LastName','Title','Suffix')
AND NOT (ISNULL(a.Previous_Value,'') ='' AND a.FieldName IN ('FamilyID','HouseholdID','ParentNameGroup','ParentType'))

--	SELECT DISTINCT fieldname FROM dbo.SIS_DataChanges

--AcademicGroup 
--EnrollmentStatus
--	Address
--BirthDate
--ConstituentClassYr
--Email1
--Email2
--FamilyID
--FirstName
--FullName
--Gender
--HouseholdID
--IsDeleted
--LastName
--MiddleName
--OtherNumber1
--OtherNumber2
--ParentNameGroup
--ParentType
--Phone
--PrefferedName
--StudentEmail
--Suffix
--Title
GO
