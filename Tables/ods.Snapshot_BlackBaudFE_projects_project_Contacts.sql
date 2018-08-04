CREATE TABLE [ods].[Snapshot_BlackBaudFE_projects_project_Contacts]
(
[BlackBaudFE_projects_project_ContactsSK] [int] NOT NULL IDENTITY(1, 1),
[project_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[contacts_contact_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[contacts_description] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[contacts_country] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[contacts_city] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[contacts_county] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[contacts_state] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[contacts_address_line] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[contacts_postal] [nvarchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[contacts_title] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[contacts_first_name] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[contacts_middle_name] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[contacts_last_name] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[contacts_suffix] [nvarchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[contacts_position] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_CreatedOn] [datetime] NULL,
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_UpdatedOn] [datetime] NULL,
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RecordEndDate] [datetime] NULL
)
GO
ALTER TABLE [ods].[Snapshot_BlackBaudFE_projects_project_Contacts] ADD CONSTRAINT [PK__Snapshot__D62E67DDA2FA0E1F] PRIMARY KEY CLUSTERED  ([BlackBaudFE_projects_project_ContactsSK])
GO
