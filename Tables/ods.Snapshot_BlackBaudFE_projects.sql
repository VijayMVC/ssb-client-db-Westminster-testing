CREATE TABLE [ods].[Snapshot_BlackBaudFE_projects]
(
[BlackBaudFE_projectsSK] [int] NOT NULL IDENTITY(1, 1),
[project_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[description] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ui_project_id] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[start-date] [datetime2] NULL,
[end-date] [datetime2] NULL,
[location] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[division] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[department] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[status] [nvarchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[date-added] [datetime2] NULL,
[date-modified] [datetime2] NULL,
[added-by] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[modified-by] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_CreatedOn] [datetime] NULL,
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_UpdatedOn] [datetime] NULL,
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RecordEndDate] [datetime] NULL
)
GO
ALTER TABLE [ods].[Snapshot_BlackBaudFE_projects] ADD CONSTRAINT [PK__Snapshot__B906DA850EDA59C7] PRIMARY KEY CLUSTERED  ([BlackBaudFE_projectsSK])
GO
