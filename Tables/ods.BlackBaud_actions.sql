CREATE TABLE [ods].[BlackBaud_actions]
(
[action_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[constituent_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[category] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[date] [datetime2] NULL,
[summary] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[type] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[description] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[completed] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[status] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[date_added] [datetime2] NULL,
[date_modified] [datetime2] NULL,
[completed_date] [datetime2] NULL,
[opportunity_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_CreatedOn] [datetime] NOT NULL CONSTRAINT [DF__BlackBaud__ETL_C__7BE62D87] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__BlackBaud__ETL_C__7CDA51C0] DEFAULT (suser_sname()),
[ETL_UpdatedOn] [datetime] NOT NULL CONSTRAINT [DF__BlackBaud__ETL_U__7DCE75F9] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__BlackBaud__ETL_U__7EC29A32] DEFAULT (suser_sname())
)
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

----------- CREATE TRIGGER -----------
CREATE TRIGGER [ods].[Snapshot_BlackBaud_actionsUpdate] ON [ods].[BlackBaud_actions]
AFTER UPDATE, DELETE

AS
BEGIN

DECLARE @ETL_UpdatedOn DATETIME = (SELECT [etl].[ConvertToLocalTime](CAST(GETDATE() AS DATETIME2(0))))
DECLARE @ETL_UpdatedBy NVARCHAR(400) = (SELECT SYSTEM_USER)

UPDATE t SET
[ETL_UpdatedOn] = @ETL_UpdatedOn
,[ETL_UpdatedBy] = @ETL_UpdatedBy
FROM [ods].[BlackBaud_actions] t
	JOIN inserted i ON  t.[action_id] = i.[action_id]

INSERT INTO [ods].[Snapshot_BlackBaud_actions] ([action_id],[constituent_id],[category],[date],[summary],[type],[description],[completed],[status],[date_added],[date_modified],[completed_date],[opportunity_id],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate])
SELECT a.*,dateadd(s,-1,@ETL_UpdatedOn)
FROM deleted a

END
GO
ALTER TABLE [ods].[BlackBaud_actions] ADD CONSTRAINT [PK__BlackBau__74EFC217AB675F66] PRIMARY KEY CLUSTERED  ([action_id])
GO
