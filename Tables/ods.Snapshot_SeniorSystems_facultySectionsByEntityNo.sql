CREATE TABLE [ods].[Snapshot_SeniorSystems_facultySectionsByEntityNo]
(
[SeniorSystems_facultySectionsByEntityNoSK] [int] NOT NULL IDENTITY(1, 1),
[EntityNo] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FacultyHierarcy] [int] NULL,
[SectionID] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CurrentYear] [int] NULL,
[ETL_CreatedOn] [datetime] NULL,
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_UpdatedOn] [datetime] NULL,
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RecordEndDate] [datetime] NULL
)
GO
ALTER TABLE [ods].[Snapshot_SeniorSystems_facultySectionsByEntityNo] ADD CONSTRAINT [PK__Snapshot__A29EBFA3EB4991D9] PRIMARY KEY CLUSTERED  ([SeniorSystems_facultySectionsByEntityNoSK])
GO
