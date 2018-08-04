CREATE TABLE [ods].[BlackBaudFE_projects_project]
(
[project_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
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
[ETL_CreatedOn] [datetime] NOT NULL CONSTRAINT [DF__BlackBaud__ETL_C__6669BD79] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__BlackBaud__ETL_C__675DE1B2] DEFAULT (suser_sname()),
[ETL_UpdatedOn] [datetime] NOT NULL CONSTRAINT [DF__BlackBaud__ETL_U__685205EB] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__BlackBaud__ETL_U__69462A24] DEFAULT (suser_sname())
)
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

----------- CREATE TRIGGER -----------
CREATE TRIGGER [ods].[Snapshot_BlackBaudFE_projects_projectUpdate] ON [ods].[BlackBaudFE_projects_project]
AFTER UPDATE, DELETE

AS
BEGIN

DECLARE @ETL_UpdatedOn DATETIME = (SELECT [etl].[ConvertToLocalTime](CAST(GETDATE() AS DATETIME2(0))))
DECLARE @ETL_UpdatedBy NVARCHAR(400) = (SELECT SYSTEM_USER)

UPDATE t SET
[ETL_UpdatedOn] = @ETL_UpdatedOn
,[ETL_UpdatedBy] = @ETL_UpdatedBy
FROM [ods].[BlackBaudFE_projects_project] t
	JOIN inserted i ON  t.[project_id] = i.[project_id]

INSERT INTO [ods].[Snapshot_BlackBaudFE_projects_project] ([project_id],[description],[ui_project_id],[start_date],[end_date],[location],[division],[department],[type],[status],[prevent_data_entry],[prevent_posting_after],[posting_date],[account_restrictions_allow_or_restrict],[account_restrictions_criteria],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate])
SELECT a.*,dateadd(s,-1,@ETL_UpdatedOn)
FROM deleted a

END
GO
ALTER TABLE [ods].[BlackBaudFE_projects_project] ADD CONSTRAINT [PK__BlackBau__BC799E1F420BE73A] PRIMARY KEY CLUSTERED  ([project_id])
GO
