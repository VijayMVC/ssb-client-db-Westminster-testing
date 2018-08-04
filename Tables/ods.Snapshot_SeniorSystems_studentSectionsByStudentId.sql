CREATE TABLE [ods].[Snapshot_SeniorSystems_studentSectionsByStudentId]
(
[SeniorSystems_studentSectionsByStudentIdSK] [int] NOT NULL IDENTITY(1, 1),
[StudentID] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SectionID] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[WithdrawMarkingPeriod] [bit] NULL,
[CurrentYear] [int] NULL,
[ETL_CreatedOn] [datetime] NULL,
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_UpdatedOn] [datetime] NULL,
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RecordEndDate] [datetime] NULL
)
GO
ALTER TABLE [ods].[Snapshot_SeniorSystems_studentSectionsByStudentId] ADD CONSTRAINT [PK__Snapshot__1932727D8BB82345] PRIMARY KEY CLUSTERED  ([SeniorSystems_studentSectionsByStudentIdSK])
GO
