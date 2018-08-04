CREATE TABLE [ods].[Snapshot_SeniorSystems_schools]
(
[SeniorSystems_schoolsSK] [int] NOT NULL IDENTITY(1, 1),
[SchoolID] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SchoolName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsAcademicSchool] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsSummerSchool] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CurrentAcademicYear] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_CreatedOn] [datetime] NULL,
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_UpdatedOn] [datetime] NULL,
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RecordEndDate] [datetime] NULL
)
GO
ALTER TABLE [ods].[Snapshot_SeniorSystems_schools] ADD CONSTRAINT [PK__Snapshot__A95CA0C05EA2A9C9] PRIMARY KEY CLUSTERED  ([SeniorSystems_schoolsSK])
GO
