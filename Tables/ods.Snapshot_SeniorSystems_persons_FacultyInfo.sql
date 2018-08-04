CREATE TABLE [ods].[Snapshot_SeniorSystems_persons_FacultyInfo]
(
[SeniorSystems_persons_FacultyInfoSK] [int] NOT NULL IDENTITY(1, 1),
[EntityNo] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Faculty_ID] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DepartmentID] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DepartmentName] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[JobTitle] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[InternalTelNo] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[HireDate] [datetime2] NULL,
[MajorTeachingArea] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MinorTeachingArea] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FacultyType] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FacultyStatus] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ExperienceLevel] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Location] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsActive] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EMail] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DisplayInDirectory] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_CreatedOn] [datetime] NULL,
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_UpdatedOn] [datetime] NULL,
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RecordEndDate] [datetime] NULL
)
GO
ALTER TABLE [ods].[Snapshot_SeniorSystems_persons_FacultyInfo] ADD CONSTRAINT [PK__Snapshot__5EE1895C87E652EA] PRIMARY KEY CLUSTERED  ([SeniorSystems_persons_FacultyInfoSK])
GO
