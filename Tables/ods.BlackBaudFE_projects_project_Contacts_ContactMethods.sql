CREATE TABLE [ods].[BlackBaudFE_projects_project_Contacts_ContactMethods]
(
[project_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[contacts_contact_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[address_contact_methods_contact_method_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[address_contact_methods_contact_type] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address_contact_methods_contact_info] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_CreatedOn] [datetime] NOT NULL CONSTRAINT [DF__BlackBaud__ETL_C__797C91ED] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__BlackBaud__ETL_C__7A70B626] DEFAULT (suser_sname()),
[ETL_UpdatedOn] [datetime] NOT NULL CONSTRAINT [DF__BlackBaud__ETL_U__7B64DA5F] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__BlackBaud__ETL_U__7C58FE98] DEFAULT (suser_sname())
)
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

----------- CREATE TRIGGER -----------
CREATE TRIGGER [ods].[Snapshot_BlackBaudFE_projects_project_Contacts_ContactMethodsUpdate] ON [ods].[BlackBaudFE_projects_project_Contacts_ContactMethods]
AFTER UPDATE, DELETE

AS
BEGIN

DECLARE @ETL_UpdatedOn DATETIME = (SELECT [etl].[ConvertToLocalTime](CAST(GETDATE() AS DATETIME2(0))))
DECLARE @ETL_UpdatedBy NVARCHAR(400) = (SELECT SYSTEM_USER)

UPDATE t SET
[ETL_UpdatedOn] = @ETL_UpdatedOn
,[ETL_UpdatedBy] = @ETL_UpdatedBy
FROM [ods].[BlackBaudFE_projects_project_Contacts_ContactMethods] t
	JOIN inserted i ON  t.[project_id] = i.[project_id] AND t.[contacts_contact_id] = i.[contacts_contact_id] AND t.[address_contact_methods_contact_method_id] = i.[address_contact_methods_contact_method_id]

INSERT INTO [ods].[Snapshot_BlackBaudFE_projects_project_Contacts_ContactMethods] ([project_id],[contacts_contact_id],[address_contact_methods_contact_method_id],[address_contact_methods_contact_type],[address_contact_methods_contact_info],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate])
SELECT a.*,dateadd(s,-1,@ETL_UpdatedOn)
FROM deleted a

END
GO
ALTER TABLE [ods].[BlackBaudFE_projects_project_Contacts_ContactMethods] ADD CONSTRAINT [PK__BlackBau__B9320EE98E5C6120] PRIMARY KEY CLUSTERED  ([project_id], [contacts_contact_id], [address_contact_methods_contact_method_id])
GO
