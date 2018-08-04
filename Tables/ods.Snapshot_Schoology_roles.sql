CREATE TABLE [ods].[Snapshot_Schoology_roles]
(
[Schoology_rolesSK] [int] NOT NULL IDENTITY(1, 1),
[role_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[role_title] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[role_faculty] [int] NULL,
[ETL_CreatedOn] [datetime] NULL,
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_UpdatedOn] [datetime] NULL,
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RecordEndDate] [datetime] NULL
)
GO
ALTER TABLE [ods].[Snapshot_Schoology_roles] ADD CONSTRAINT [PK__Snapshot__7F03413D087D8E7D] PRIMARY KEY CLUSTERED  ([Schoology_rolesSK])
GO
