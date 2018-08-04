SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [dbo].[vwConstituent_Tagging]
AS

WITH sen_stu AS (
	SELECT DISTINCT a.EntityNo,a.FamilyID,a.HouseholdID FROM ods.SeniorSystems_persons a
		JOIN ods.SeniorSystems_persons_student b ON b.EntityNo = a.EntityNo
		WHERE a.IsDeleted = 0 AND b.StudentID IN (
					SELECT DISTINCT StudentID FROM ods.SeniorSystems_studentSectionsByStudentId
					WHERE CurrentYear = (SELECT TOP 1 CurrentYear FROM ods.SeniorSystems_schoolCurrentAcademicYear
												ORDER BY Pull_Date DESC) AND WithdrawMarkingPeriod = 0))

SELECT  a.SSID, SourceSystem
, CASE WHEN sen_stu.EntityNo IS NOT NULL THEN 1 ELSE 0 END SS_Current_Student
, CASE WHEN re_stu.constituent_id IS NOT NULL THEN 1 ELSE 0 END RE_Current_Student
, CASE WHEN sen_stu.EntityNo IS NOT NULL OR re_stu.constituent_id IS NOT NULL THEN 1 ELSE 0 END Current_Student
, CASE WHEN sen_par.EntityNo IS NOT NULL THEN 1 ELSE 0 END SS_Current_Parent
, CASE WHEN re_par.constituent_id IS NOT NULL THEN 1 ELSE 0 END RE_Current_Parent
, CASE WHEN sen_par.EntityNo IS NOT NULL OR re_par.constituent_id IS NOT NULL THEN 1 ELSE 0 END Current_Parent
, CASE WHEN sen_fac.EntityNo IS NOT NULL THEN 1 ELSE 0 END SS_Current_FactStaff
, CASE WHEN re_fac.constituent_id IS NOT NULL THEN 1 ELSE 0 END RE_Current_FactStaff
, CASE WHEN sen_fac.EntityNo IS NOT NULL OR re_fac.constituent_id IS NOT NULL THEN 1 ELSE 0 END Current_FactStaff
FROM dbo.vwDimCustomer_ModAcctId a 
--Current SS Students
LEFT JOIN sen_stu ON a.SSID = sen_stu.EntityNo AND a.SourceSystem = 'SeniorSystems'
--Current RE Students
LEFT JOIN
	(
		SELECT DISTINCT a.constituent_id FROM ods.BlackBaud_constituentcodes  a WHERE description IN ('student')
		AND a.constituent_id IN (SELECT DISTINCT parent_id FROM ods.BlackBaud_customfields WHERE category = 'Student Type' AND customvalue ='Current Student')
	) re_stu ON a.SSID = re_stu.constituent_id AND a.SourceSystem = 'RaisersEdge'
--Current RE Parent
LEFT JOIN
	(
	--SELECT DISTINCT constituent_id FROM ods.BlackBaud_relationships WHERE type IN ('Father','Mother','Step-father','Step-mother','Parent','Parents')
	--UNION
	SELECT DISTINCT constituent_id FROM ods.BlackBaud_constituentcodes WHERE description IN ('Current Parent','New Parent')--
	) re_par ON   a.SSID = re_par.constituent_id AND a.SourceSystem = 'RaisersEdge'
--Current SS Parents
LEFT JOIN 
	(
		SELECT DISTINCT a.EntityNo,a.FamilyID,a.HouseholdID 
					FROM ods.SeniorSystems_persons a
					JOIN sen_stu ON (a.FamilyID = sen_stu.FamilyID OR a.HouseholdID = sen_stu.HouseholdID)
			WHERE a.IsParent = 'true'
	) sen_par ON a.SSID = sen_par.EntityNo AND a.SourceSystem = 'SeniorSystems'
--Current RE Parent
LEFT JOIN
	(
	SELECT DISTINCT constituent_id FROM ods.BlackBaud_constituentcodes WHERE description IN ('Faculty','Staff') 
	) re_fac ON   a.SSID = re_fac.constituent_id AND a.SourceSystem = 'RaisersEdge'
--Current SS Parents
LEFT JOIN 
	(
		SELECT DISTINCT a.EntityNo FROM ods.SeniorSystems_persons a
			WHERE a.IsFaculty = 'true'
			AND a.EntityNo NOT IN (SELECT EntityNo FROM ods.SeniorSystems_persons_FacultyInfo WHERE IsActive ='fasle')
	) sen_fac ON a.SSID = sen_fac.EntityNo AND a.SourceSystem = 'SeniorSystems'



	--dbo.vwConstituent_Tagging WHERE SS_Current_Parent = 1

GO
