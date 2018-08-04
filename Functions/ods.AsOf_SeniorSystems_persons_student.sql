SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

/*
-- Get the status of your table 20 minutes ago...
DECLARE @AsOfDate DATETIME = (SELECT [etl].[ConvertToLocalTime](DATEADD(MINUTE,-20,GETDATE())))
SELECT * FROM [ods].[AsOf_SeniorSystems_persons_student] (@AsOfDate)
*/

CREATE FUNCTION [ods].[AsOf_SeniorSystems_persons_student] (@AsOfDate DATETIME)

RETURNS @Results TABLE
(
[EntityNo] [nvarchar](50) NULL,
[StudentCurrentGrade] [nvarchar](10) NULL,
[StudentNextGrade] [nvarchar](10) NULL,
[StudentID] [nvarchar](50) NULL,
[StudentCurrentSchool] [nvarchar](10) NULL,
[AcademicGroup] [nvarchar](25) NULL,
[ARGroup] [nvarchar](25) NULL,
[HomeRoom] [nvarchar](25) NULL,
[HomeRoomTeacherID] [nvarchar](25) NULL,
[FacultyAdvisorID] [nvarchar](25) NULL,
[EnrollmentStatus] [nvarchar](50) NULL,
[AdmissionsYr] [nvarchar](25) NULL,
[BoardDayCode] [nvarchar](25) NULL,
[StudentTelephoneNumber] [nvarchar](50) NULL,
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
SELECT [EntityNo],[StudentCurrentGrade],[StudentNextGrade],[StudentID],[StudentCurrentSchool],[AcademicGroup],[ARGroup],[HomeRoom],[HomeRoomTeacherID],[FacultyAdvisorID],[EnrollmentStatus],[AdmissionsYr],[BoardDayCode],[StudentTelephoneNumber],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy]
FROM
	(
	SELECT [EntityNo],[StudentCurrentGrade],[StudentNextGrade],[StudentID],[StudentCurrentSchool],[AcademicGroup],[ARGroup],[HomeRoom],[HomeRoomTeacherID],[FacultyAdvisorID],[EnrollmentStatus],[AdmissionsYr],[BoardDayCode],[StudentTelephoneNumber],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],@EndDate [RecordEndDate]
	FROM [ods].[SeniorSystems_persons_student] t
	UNION ALL
	SELECT [EntityNo],[StudentCurrentGrade],[StudentNextGrade],[StudentID],[StudentCurrentSchool],[AcademicGroup],[ARGroup],[HomeRoom],[HomeRoomTeacherID],[FacultyAdvisorID],[EnrollmentStatus],[AdmissionsYr],[BoardDayCode],[StudentTelephoneNumber],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate]
	FROM [ods].[Snapshot_SeniorSystems_persons_student]
	) a
WHERE
	@AsOfDate BETWEEN [ETL_UpdatedOn] AND [RecordEndDate]
	AND [ETL_CreatedOn] <= @AsOfDate

RETURN

END
GO
