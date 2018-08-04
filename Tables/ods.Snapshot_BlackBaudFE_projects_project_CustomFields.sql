CREATE TABLE [ods].[Snapshot_BlackBaudFE_projects_project_CustomFields]
(
[BlackBaudFE_projects_project_CustomFieldsSK] [int] NOT NULL IDENTITY(1, 1),
[project_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[custom_fields_custom_field_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[custom_fields_field_name] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[custom_fields_value] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[custom_fields_comments] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[custom_fields_type] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[custom_fields_date] [datetime2] NULL,
[ETL_CreatedOn] [datetime] NULL,
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_UpdatedOn] [datetime] NULL,
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RecordEndDate] [datetime] NULL
)
GO
ALTER TABLE [ods].[Snapshot_BlackBaudFE_projects_project_CustomFields] ADD CONSTRAINT [PK__Snapshot__22BB715FAC5E995B] PRIMARY KEY CLUSTERED  ([BlackBaudFE_projects_project_CustomFieldsSK])
GO
