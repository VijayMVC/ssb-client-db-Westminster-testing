CREATE TABLE [ods].[Snapshot_Schoology_groups]
(
[Schoology_groupsSK] [int] NOT NULL IDENTITY(1, 1),
[groupid] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[title] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[description] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[website] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[access-code] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[category] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[group_code] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[privacy_level] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[picture_url] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[school_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[building_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_CreatedOn] [datetime] NULL,
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_UpdatedOn] [datetime] NULL,
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RecordEndDate] [datetime] NULL
)
GO
ALTER TABLE [ods].[Snapshot_Schoology_groups] ADD CONSTRAINT [PK__Snapshot__2D62F1E111C71D5A] PRIMARY KEY CLUSTERED  ([Schoology_groupsSK])
GO
