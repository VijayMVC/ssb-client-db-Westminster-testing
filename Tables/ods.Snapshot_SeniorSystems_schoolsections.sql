CREATE TABLE [ods].[Snapshot_SeniorSystems_schoolsections]
(
[SeniorSystems_schoolsectionsSK] [int] NOT NULL IDENTITY(1, 1),
[SectionID] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MeetsPeriod] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MeetsLength] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MeetsGradeSeq] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SchoolID] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SchoolName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CourseID] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CourseName] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FullName] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Abbreviation] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Description] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[GradeLevel] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Department_DepartmentID] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Department_Name] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CurrentYear] [int] NULL,
[ETL_CreatedOn] [datetime] NULL,
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_UpdatedOn] [datetime] NULL,
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RecordEndDate] [datetime] NULL
)
GO
ALTER TABLE [ods].[Snapshot_SeniorSystems_schoolsections] ADD CONSTRAINT [PK__Snapshot__F44EFA9421446EBC] PRIMARY KEY CLUSTERED  ([SeniorSystems_schoolsectionsSK])
GO
