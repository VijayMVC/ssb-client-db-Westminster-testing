CREATE TABLE [ods].[Snapshot_SeniorSystems_persons_student]
(
[SeniorSystems_persons_studentSK] [int] NOT NULL IDENTITY(1, 1),
[EntityNo] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[StudentCurrentGrade] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[StudentNextGrade] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[StudentID] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[StudentCurrentSchool] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AcademicGroup] [nvarchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ARGroup] [nvarchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[HomeRoom] [nvarchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[HomeRoomTeacherID] [nvarchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FacultyAdvisorID] [nvarchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EnrollmentStatus] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[AdmissionsYr] [nvarchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BoardDayCode] [nvarchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[StudentTelephoneNumber] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_CreatedOn] [datetime] NULL,
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_UpdatedOn] [datetime] NULL,
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RecordEndDate] [datetime] NULL
)
GO
ALTER TABLE [ods].[Snapshot_SeniorSystems_persons_student] ADD CONSTRAINT [PK__Snapshot__27490855F88E5ADB] PRIMARY KEY CLUSTERED  ([SeniorSystems_persons_studentSK])
GO
