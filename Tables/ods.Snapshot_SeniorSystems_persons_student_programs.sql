CREATE TABLE [ods].[Snapshot_SeniorSystems_persons_student_programs]
(
[SeniorSystems_persons_student_programsSK] [int] NOT NULL IDENTITY(1, 1),
[EntityNo] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Programs_ID] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Programs_Name] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Programs_Group] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_CreatedOn] [datetime] NULL,
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_UpdatedOn] [datetime] NULL,
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RecordEndDate] [datetime] NULL
)
GO
ALTER TABLE [ods].[Snapshot_SeniorSystems_persons_student_programs] ADD CONSTRAINT [PK__Snapshot__ED41FF706A6AC61A] PRIMARY KEY CLUSTERED  ([SeniorSystems_persons_student_programsSK])
GO
