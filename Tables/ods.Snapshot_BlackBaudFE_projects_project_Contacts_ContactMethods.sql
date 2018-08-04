CREATE TABLE [ods].[Snapshot_BlackBaudFE_projects_project_Contacts_ContactMethods]
(
[BlackBaudFE_projects_project_Contacts_ContactMethodsSK] [int] NOT NULL IDENTITY(1, 1),
[project_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[contacts_contact_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address_contact_methods_contact_method_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address_contact_methods_contact_type] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address_contact_methods_contact_info] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_CreatedOn] [datetime] NULL,
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_UpdatedOn] [datetime] NULL,
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RecordEndDate] [datetime] NULL
)
GO
ALTER TABLE [ods].[Snapshot_BlackBaudFE_projects_project_Contacts_ContactMethods] ADD CONSTRAINT [PK__Snapshot__8DF664C8A7DD24C9] PRIMARY KEY CLUSTERED  ([BlackBaudFE_projects_project_Contacts_ContactMethodsSK])
GO
