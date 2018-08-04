CREATE TABLE [ods].[Snapshot_Schoology_users]
(
[Schoology_usersSK] [int] NOT NULL IDENTITY(1, 1),
[uid] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
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
[ETL_CreatedOn] [datetime] NULL,
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_UpdatedOn] [datetime] NULL,
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RecordEndDate] [datetime] NULL,
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
[IsDeleted] [bit] NULL CONSTRAINT [DF__Snapshot___IsDel__0A4FDF9B] DEFAULT ((0))
)
GO
ALTER TABLE [ods].[Snapshot_Schoology_users] ADD CONSTRAINT [PK__Snapshot__5C19AF791198816E] PRIMARY KEY CLUSTERED  ([Schoology_usersSK])
GO