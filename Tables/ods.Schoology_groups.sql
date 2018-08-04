CREATE TABLE [ods].[Schoology_groups]
(
[groupid] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[title] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[description] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[website] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[access-code] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[category] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[group_code] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[privacy_level] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[picture_url] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[school_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[building_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_CreatedOn] [datetime] NOT NULL CONSTRAINT [DF__Schoology__ETL_C__10CB707D] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__Schoology__ETL_C__11BF94B6] DEFAULT (suser_sname()),
[ETL_UpdatedOn] [datetime] NOT NULL CONSTRAINT [DF__Schoology__ETL_U__12B3B8EF] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__Schoology__ETL_U__13A7DD28] DEFAULT (suser_sname())
)
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

----------- CREATE TRIGGER -----------
CREATE TRIGGER [ods].[Snapshot_Schoology_groupsUpdate] ON [ods].[Schoology_groups]
AFTER UPDATE, DELETE

AS
BEGIN

DECLARE @ETL_UpdatedOn DATETIME = (SELECT [etl].[ConvertToLocalTime](CAST(GETDATE() AS DATETIME2(0))))
DECLARE @ETL_UpdatedBy NVARCHAR(400) = (SELECT SYSTEM_USER)

UPDATE t SET
[ETL_UpdatedOn] = @ETL_UpdatedOn
,[ETL_UpdatedBy] = @ETL_UpdatedBy
FROM [ods].[Schoology_groups] t
	JOIN inserted i ON  t.[groupid] = i.[groupid]

INSERT INTO [ods].[Snapshot_Schoology_groups] ([groupid],[title],[description],[website],[access-code],[category],[group_code],[privacy_level],[picture_url],[school_id],[building_id],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate])
SELECT a.*,dateadd(s,-1,@ETL_UpdatedOn)
FROM deleted a

END
GO
ALTER TABLE [ods].[Schoology_groups] ADD CONSTRAINT [PK__Schoolog__88C40F8575530EF1] PRIMARY KEY CLUSTERED  ([groupid])
GO
