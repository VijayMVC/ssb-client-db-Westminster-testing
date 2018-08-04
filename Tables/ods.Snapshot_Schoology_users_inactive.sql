CREATE TABLE [ods].[Snapshot_Schoology_users_inactive]
(
[Schoology_users_inactiveSK] [int] NOT NULL IDENTITY(1, 1),
[uid] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[name] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[school_uid] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[synced] [int] NULL,
[inactive_timestamp] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[modified_by_uid] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_CreatedOn] [datetime] NULL,
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_UpdatedOn] [datetime] NULL,
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RecordEndDate] [datetime] NULL
)
GO
ALTER TABLE [ods].[Snapshot_Schoology_users_inactive] ADD CONSTRAINT [PK__Snapshot__449EFFE4F8173646] PRIMARY KEY CLUSTERED  ([Schoology_users_inactiveSK])
GO
