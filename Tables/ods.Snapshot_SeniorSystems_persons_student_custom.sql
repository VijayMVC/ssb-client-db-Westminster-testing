CREATE TABLE [ods].[Snapshot_SeniorSystems_persons_student_custom]
(
[SeniorSystems_persons_student_customSK] [int] NOT NULL IDENTITY(1, 1),
[EntityNo] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RG_FieldNumber] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RG_Prompt] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RG_Value] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_CreatedOn] [datetime] NULL,
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_UpdatedOn] [datetime] NULL,
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RecordEndDate] [datetime] NULL
)
GO
ALTER TABLE [ods].[Snapshot_SeniorSystems_persons_student_custom] ADD CONSTRAINT [PK__Snapshot__FBDB85E2189BCDB4] PRIMARY KEY CLUSTERED  ([SeniorSystems_persons_student_customSK])
GO
