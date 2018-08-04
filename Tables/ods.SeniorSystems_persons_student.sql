CREATE TABLE [ods].[SeniorSystems_persons_student]
(
[EntityNo] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[StudentCurrentGrade] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[StudentNextGrade] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[StudentID] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
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
[ETL_CreatedOn] [datetime] NOT NULL CONSTRAINT [DF__SeniorSys__ETL_C__3726238F] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__SeniorSys__ETL_C__381A47C8] DEFAULT (suser_sname()),
[ETL_UpdatedOn] [datetime] NOT NULL CONSTRAINT [DF__SeniorSys__ETL_U__390E6C01] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__SeniorSys__ETL_U__3A02903A] DEFAULT (suser_sname())
)
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

----------- CREATE TRIGGER -----------
CREATE TRIGGER [ods].[Snapshot_SeniorSystems_persons_studentUpdate] ON [ods].[SeniorSystems_persons_student]
AFTER UPDATE, DELETE

AS
BEGIN

DECLARE @ETL_UpdatedOn DATETIME = (SELECT [etl].[ConvertToLocalTime](CAST(GETDATE() AS DATETIME2(0))))
DECLARE @ETL_UpdatedBy NVARCHAR(400) = (SELECT SYSTEM_USER)

UPDATE t SET
[ETL_UpdatedOn] = @ETL_UpdatedOn
,[ETL_UpdatedBy] = @ETL_UpdatedBy
FROM [ods].[SeniorSystems_persons_student] t
	JOIN inserted i ON  t.[StudentID] = i.[StudentID]

INSERT INTO [ods].[Snapshot_SeniorSystems_persons_student] ([EntityNo],[StudentCurrentGrade],[StudentNextGrade],[StudentID],[StudentCurrentSchool],[AcademicGroup],[ARGroup],[HomeRoom],[HomeRoomTeacherID],[FacultyAdvisorID],[EnrollmentStatus],[AdmissionsYr],[BoardDayCode],[StudentTelephoneNumber],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate])
SELECT a.*,dateadd(s,-1,@ETL_UpdatedOn)
FROM deleted a

END
GO
ALTER TABLE [ods].[SeniorSystems_persons_student] ADD CONSTRAINT [PK__SeniorSy__32C52A79CA23133B] PRIMARY KEY CLUSTERED  ([StudentID])
GO
