CREATE TABLE [ods].[Snapshot_SeniorSystems_schoolMarkingPeriods]
(
[SeniorSystems_schoolMarkingPeriodsSK] [int] NOT NULL IDENTITY(1, 1),
[Name] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TermID] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Abbreviation] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SchoolID] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CurrentYear] [int] NULL,
[ETL_CreatedOn] [datetime] NULL,
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_UpdatedOn] [datetime] NULL,
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RecordEndDate] [datetime] NULL
)
GO
ALTER TABLE [ods].[Snapshot_SeniorSystems_schoolMarkingPeriods] ADD CONSTRAINT [PK__Snapshot__1544BEC00FE8E6A8] PRIMARY KEY CLUSTERED  ([SeniorSystems_schoolMarkingPeriodsSK])
GO
