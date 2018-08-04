CREATE TABLE [ods].[Snapshot_BlackBaudFE_projects_project]
(
[BlackBaudFE_projects_projectSK] [int] NOT NULL IDENTITY(1, 1),
[project_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[description] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ui_project_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[start_date] [datetime2] NULL,
[end_date] [datetime2] NULL,
[location] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[division] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[department] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[type] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[status] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[prevent_data_entry] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[prevent_posting_after] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[posting_date] [datetime2] NULL,
[account_restrictions_allow_or_restrict] [nvarchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[account_restrictions_criteria] [nvarchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_CreatedOn] [datetime] NULL,
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_UpdatedOn] [datetime] NULL,
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RecordEndDate] [datetime] NULL
)
GO
ALTER TABLE [ods].[Snapshot_BlackBaudFE_projects_project] ADD CONSTRAINT [PK__Snapshot__2F0613E3CEF6FA02] PRIMARY KEY CLUSTERED  ([BlackBaudFE_projects_projectSK])
GO
