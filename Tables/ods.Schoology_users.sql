CREATE TABLE [ods].[Schoology_users]
(
[uid] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Userid] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[school-id] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[synced] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[school-uid] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[building-id] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[name-title] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[name-title-show] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[name-first] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[name-first-preferred] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[use-preferred-first-name] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[name-middle] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[name-middle-show] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[name-last] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[name-display] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[username] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[primary-email] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[picture-url] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[gender] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[position] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[grad-year] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[password] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[role-id] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[tz-offset] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[tz-name] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[parents] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[child-uids] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[language] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[additional-buildings] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_CreatedOn] [datetime] NOT NULL CONSTRAINT [DF__Schoology__ETL_C__253C7D7E] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__Schoology__ETL_C__2630A1B7] DEFAULT (suser_sname()),
[ETL_UpdatedOn] [datetime] NOT NULL CONSTRAINT [DF__Schoology__ETL_U__2724C5F0] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__Schoology__ETL_U__2818EA29] DEFAULT (suser_sname()),
[bio] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[phone] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[subjects_taught] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[website] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[grades_taught] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[interests] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[bio_position] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[activities] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[department] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[birthday_date] [date] NULL,
[birthday] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsDeleted] [bit] NULL CONSTRAINT [DF__Schoology__IsDel__095BBB62] DEFAULT ((0))
)
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

----------- CREATE TRIGGER -----------
CREATE TRIGGER [ods].[Snapshot_Schoology_usersUpdate] ON [ods].[Schoology_users]
AFTER UPDATE, DELETE

AS
BEGIN

DECLARE @ETL_UpdatedOn DATETIME = (SELECT [etl].[ConvertToLocalTime](CAST(GETDATE() AS DATETIME2(0))))
DECLARE @ETL_UpdatedBy NVARCHAR(400) = (SELECT SYSTEM_USER)

UPDATE t SET
[ETL_UpdatedOn] = @ETL_UpdatedOn
,[ETL_UpdatedBy] = @ETL_UpdatedBy
FROM [ods].[Schoology_users] t
	JOIN inserted i ON  t.[uid] = i.[uid]

INSERT INTO [ods].[Snapshot_Schoology_users] ([uid],[Userid],[school-id],[synced],[school-uid],[building-id],[name-title],[name-title-show],[name-first],[name-first-preferred],[use-preferred-first-name],[name-middle],[name-middle-show],[name-last],[name-display],[username],[primary-email],[picture-url],[gender],[position],[grad-year],[password],[role-id],[tz-offset],[tz-name],[parents],[child-uids],[language],[additional-buildings]
,[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy]
,bio	,phone	,subjects_taught,website	,address	,grades_taught	,interests	,bio_position,activities	,department	,birthday_date ,birthday ,IsDeleted
,[RecordEndDate]
)
SELECT a.*,dateadd(s,-1,@ETL_UpdatedOn)
FROM deleted a

END

GO
ALTER TABLE [ods].[Schoology_users] ADD CONSTRAINT [PK__Schoolog__DD701264C45F1DC0] PRIMARY KEY CLUSTERED  ([uid])
GO
