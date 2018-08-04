SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE VIEW [preODS].[SeniorSystems_persons_student]
AS

SELECT DISTINCT
	CONVERT(NVARCHAR(50),[EntityNo]) [EntityNo]
	--,CONVERT(NVARCHAR(MAX),[StudentsBillingAccess_]) [StudentsBillingAccess_]
	,CONVERT(NVARCHAR(10),[StudentAccounts_StudentCurrentGrade]) [StudentCurrentGrade]
	,CONVERT(NVARCHAR(10),[StudentAccounts_StudentNextGrade]) [StudentNextGrade]
	,CONVERT(NVARCHAR(50),[StudentAccounts_StudentID]) [StudentID_K]
	,CONVERT(NVARCHAR(10),[StudentAccounts_StudentCurrentSchool]) [StudentCurrentSchool]
	,CONVERT(NVARCHAR(25),[StudentAccounts_AcademicGroup]) [AcademicGroup]
	,CONVERT(NVARCHAR(25),[StudentAccounts_ARGroup]) [ARGroup]
	,CONVERT(NVARCHAR(25),[StudentAccounts_HomeRoom]) [HomeRoom]
	,CONVERT(NVARCHAR(25),[StudentAccounts_HomeRoomTeacherID]) [HomeRoomTeacherID]
	,CONVERT(NVARCHAR(25),[StudentAccounts_FacultyAdvisorID]) [FacultyAdvisorID]
	,CONVERT(NVARCHAR(50),[StudentAccounts_EnrollmentStatus]) [EnrollmentStatus]
	,CONVERT(NVARCHAR(25),[StudentAccounts_AdmissionsYr]) [AdmissionsYr]
	,CONVERT(NVARCHAR(25),[StudentAccounts_BoardDayCode]) [BoardDayCode]
	,CONVERT(NVARCHAR(50),[StudentAccounts_StudentTelephoneNumber]) [StudentTelephoneNumber]
FROM [src].[SeniorSystems_persons] WITH (NOLOCK)
WHERE StudentAccounts_StudentID IS NOT NULL

GO
