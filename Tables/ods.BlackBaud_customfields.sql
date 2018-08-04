CREATE TABLE [ods].[BlackBaud_customfields]
(
[CustomField_id] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[parent_id] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[category] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[type] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[date] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[comment] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[customvalue] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[date-added] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[date-modified] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_CreatedOn] [datetime] NOT NULL CONSTRAINT [DF__BlackBaud__ETL_C__06B7F65E] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__BlackBaud__ETL_C__07AC1A97] DEFAULT (suser_sname()),
[ETL_UpdatedOn] [datetime] NOT NULL CONSTRAINT [DF__BlackBaud__ETL_U__08A03ED0] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__BlackBaud__ETL_U__09946309] DEFAULT (suser_sname())
)
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

----------- CREATE TRIGGER -----------
CREATE TRIGGER [ods].[Snapshot_BlackBaud_customfieldsUpdate] ON [ods].[BlackBaud_customfields]
AFTER UPDATE, DELETE

AS
BEGIN

DECLARE @ETL_UpdatedOn DATETIME = (SELECT [etl].[ConvertToLocalTime](CAST(GETDATE() AS DATETIME2(0))))
DECLARE @ETL_UpdatedBy NVARCHAR(400) = (SELECT SYSTEM_USER)

UPDATE t SET
[ETL_UpdatedOn] = @ETL_UpdatedOn
,[ETL_UpdatedBy] = @ETL_UpdatedBy
FROM [ods].[BlackBaud_customfields] t
	JOIN inserted i ON  t.[CustomField_id] = i.[CustomField_id]

INSERT INTO [ods].[Snapshot_BlackBaud_customfields] ([CustomField_id],[parent_id],[category],[type],[date],[comment],[customvalue],[date-added],[date-modified],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate])
SELECT a.*,dateadd(s,-1,@ETL_UpdatedOn)
FROM deleted a

END
GO
ALTER TABLE [ods].[BlackBaud_customfields] ADD CONSTRAINT [PK__BlackBau__DA98660D61D9294B] PRIMARY KEY CLUSTERED  ([CustomField_id])
GO
