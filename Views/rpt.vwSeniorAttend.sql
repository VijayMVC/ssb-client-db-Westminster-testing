SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [rpt].[vwSeniorAttend] AS 

SELECT STUDENT_ID,ACADEMIC_YR,TERM_NO, SUM(CASE WHEN ATTEND_TYPE = 'Tardy' THEN 1 ELSE 0 end) TardyCount
, SUM(CASE WHEN ATTEND_TYPE = 'Excused Absence' THEN 1 ELSE 0 end) ExcusedAbsenceCount
, SUM(CASE WHEN ATTEND_TYPE = 'Illness' THEN 1 ELSE 0 end) IllnessCount
, SUM(CASE WHEN ATTEND_TYPE = 'In at' THEN 1 ELSE 0 end) InAtCount
, SUM(CASE WHEN ATTEND_TYPE = 'Out at' THEN 1 ELSE 0 end) OutAtCount
, SUM(CASE WHEN ATTEND_TYPE = 'Out at' THEN 1 ELSE 0 end) UnexcusedCount
, SUM(CASE WHEN ATTEND_TYPE = 'Late Arrival' THEN 1 ELSE 0 end) LateArrivalCount
, SUM(CASE WHEN ATTEND_TYPE = 'Absent' THEN 1 ELSE 0 end) AbsentCount
, SUM(CASE WHEN ATTEND_TYPE = 'Medical Leave' THEN 1 ELSE 0 end) MedicalLeaveCount
, SUM(CASE WHEN ATTEND_TYPE = 'Honor Suspension' THEN 1 ELSE 0 end) HonorSuspensionCount
, SUM(CASE WHEN ATTEND_TYPE = 'Death in Family' THEN 1 ELSE 0 end) DeathinFamilyCount
, SUM(CASE WHEN ATTEND_TYPE = 'In-School Suspension' THEN 1 ELSE 0 end) InSchoolSuspensionCount
, SUM(CASE WHEN ATTEND_TYPE = 'Unverified' THEN 1 ELSE 0 end) UnverifiedCount
, SUM(CASE WHEN ATTEND_TYPE = 'Discipline Suspension' THEN 1 ELSE 0 end) DisciplineSuspensionCount
,COUNT(1) totalCount
FROM import.Senior_Attendance_Day_History
--WHERE ACADEMIC_YR = 2017
GROUP BY STUDENT_ID,ACADEMIC_YR, TERM_NO

GO
