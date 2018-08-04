CREATE TABLE [ods].[BlackBaudFE_projects_project_Contacts]
(
[project_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[contacts_contact_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
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
[ETL_CreatedOn] [datetime] NOT NULL CONSTRAINT [DF__BlackBaud__ETL_C__6FF327B3] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__BlackBaud__ETL_C__70E74BEC] DEFAULT (suser_sname()),
[ETL_UpdatedOn] [datetime] NOT NULL CONSTRAINT [DF__BlackBaud__ETL_U__71DB7025] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__BlackBaud__ETL_U__72CF945E] DEFAULT (suser_sname())
)
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

----------- CREATE TRIGGER -----------
CREATE TRIGGER [ods].[Snapshot_BlackBaudFE_projects_project_ContactsUpdate] ON [ods].[BlackBaudFE_projects_project_Contacts]
AFTER UPDATE, DELETE

AS
BEGIN

DECLARE @ETL_UpdatedOn DATETIME = (SELECT [etl].[ConvertToLocalTime](CAST(GETDATE() AS DATETIME2(0))))
DECLARE @ETL_UpdatedBy NVARCHAR(400) = (SELECT SYSTEM_USER)

UPDATE t SET
[ETL_UpdatedOn] = @ETL_UpdatedOn
,[ETL_UpdatedBy] = @ETL_UpdatedBy
FROM [ods].[BlackBaudFE_projects_project_Contacts] t
	JOIN inserted i ON  t.[project_id] = i.[project_id] AND t.[contacts_contact_id] = i.[contacts_contact_id]

INSERT INTO [ods].[Snapshot_BlackBaudFE_projects_project_Contacts] ([project_id],[contacts_contact_id],[contacts_description],[contacts_country],[contacts_city],[contacts_county],[contacts_state],[contacts_address_line],[contacts_postal],[contacts_title],[contacts_first_name],[contacts_middle_name],[contacts_last_name],[contacts_suffix],[contacts_position],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate])
SELECT a.*,dateadd(s,-1,@ETL_UpdatedOn)
FROM deleted a

END
GO
ALTER TABLE [ods].[BlackBaudFE_projects_project_Contacts] ADD CONSTRAINT [PK__BlackBau__FF15095B9BB923ED] PRIMARY KEY CLUSTERED  ([project_id], [contacts_contact_id])
GO
