CREATE TABLE [ods].[Schoology_users_inactive]
(
[uid] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[name] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[school_uid] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[synced] [int] NULL,
[inactive_timestamp] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[modified_by_uid] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_CreatedOn] [datetime] NOT NULL CONSTRAINT [DF__Schoology__ETL_C__1007C42E] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__Schoology__ETL_C__10FBE867] DEFAULT (suser_sname()),
[ETL_UpdatedOn] [datetime] NOT NULL CONSTRAINT [DF__Schoology__ETL_U__11F00CA0] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__Schoology__ETL_U__12E430D9] DEFAULT (suser_sname())
)
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

----------- CREATE TRIGGER -----------
CREATE TRIGGER [ods].[Snapshot_Schoology_users_inactiveUpdate] ON [ods].[Schoology_users_inactive]
AFTER UPDATE, DELETE

AS
BEGIN

DECLARE @ETL_UpdatedOn DATETIME = (SELECT [etl].[ConvertToLocalTime](CAST(GETDATE() AS DATETIME2(0))))
DECLARE @ETL_UpdatedBy NVARCHAR(400) = (SELECT SYSTEM_USER)

UPDATE t SET
[ETL_UpdatedOn] = @ETL_UpdatedOn
,[ETL_UpdatedBy] = @ETL_UpdatedBy
FROM [ods].[Schoology_users_inactive] t
	JOIN inserted i ON  t.[uid] = i.[uid]

INSERT INTO [ods].[Snapshot_Schoology_users_inactive] ([uid],[name],[school_uid],[synced],[inactive_timestamp],[modified_by_uid],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate])
SELECT a.*,dateadd(s,-1,@ETL_UpdatedOn)
FROM deleted a

END
GO
ALTER TABLE [ods].[Schoology_users_inactive] ADD CONSTRAINT [PK__Schoolog__DD701264D27CA72F] PRIMARY KEY CLUSTERED  ([uid])
GO
