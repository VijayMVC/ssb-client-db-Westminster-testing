CREATE TABLE [ods].[Snapshot_Schoology_grading_groups]
(
[Schoology_grading_groupsSK] [int] NOT NULL IDENTITY(1, 1),
[groups_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[title] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[section_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_CreatedOn] [datetime] NULL,
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_UpdatedOn] [datetime] NULL,
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RecordEndDate] [datetime] NULL
)
GO
ALTER TABLE [ods].[Snapshot_Schoology_grading_groups] ADD CONSTRAINT [PK__Snapshot__E14F354A279A1BCA] PRIMARY KEY CLUSTERED  ([Schoology_grading_groupsSK])
GO
