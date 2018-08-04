CREATE TABLE [ods].[Snapshot_Schoology_groups_enrollments]
(
[Schoology_groups_enrollmentsSK] [int] NOT NULL IDENTITY(1, 1),
[Group_ID] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[enrollment_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[uid] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[school_uid] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[name_title] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[name_title_show] [bit] NULL,
[name_first] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[name_first_preferred] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[use_preferred_first_name] [bit] NULL,
[name_middle] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[name_middle_show] [bit] NULL,
[name_last] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[name_display] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[admin] [bit] NULL,
[status] [bit] NULL,
[picture_url] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[links_self] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_CreatedOn] [datetime] NULL,
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_UpdatedOn] [datetime] NULL,
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RecordEndDate] [datetime] NULL
)
GO
ALTER TABLE [ods].[Snapshot_Schoology_groups_enrollments] ADD CONSTRAINT [PK__Snapshot__E7BFEE170BA44332] PRIMARY KEY CLUSTERED  ([Schoology_groups_enrollmentsSK])
GO
