CREATE TABLE [ods].[Schoology_groups_enrollments]
(
[Group_ID] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[enrollment_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[uid] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[school_uid] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[name_title] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[name_title_show] [bit] NULL,
[name_first] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[name_first_preferred] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[use_preferred_first_name] [bit] NULL,
[name_middle] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[name_middle_show] [bit] NULL,
[name_last] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[name_display] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[admin] [bit] NULL,
[status] [bit] NULL,
[picture_url] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[links_self] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_CreatedOn] [datetime] NOT NULL CONSTRAINT [DF__Schoology__ETL_C__0DFAEDEB] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__Schoology__ETL_C__0EEF1224] DEFAULT (suser_sname()),
[ETL_UpdatedOn] [datetime] NOT NULL CONSTRAINT [DF__Schoology__ETL_U__0FE3365D] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__Schoology__ETL_U__10D75A96] DEFAULT (suser_sname())
)
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

----------- CREATE TRIGGER -----------
CREATE TRIGGER [ods].[Snapshot_Schoology_groups_enrollmentsUpdate] ON [ods].[Schoology_groups_enrollments]
AFTER UPDATE, DELETE

AS
BEGIN

DECLARE @ETL_UpdatedOn DATETIME = (SELECT [etl].[ConvertToLocalTime](CAST(GETDATE() AS DATETIME2(0))))
DECLARE @ETL_UpdatedBy NVARCHAR(400) = (SELECT SYSTEM_USER)

UPDATE t SET
[ETL_UpdatedOn] = @ETL_UpdatedOn
,[ETL_UpdatedBy] = @ETL_UpdatedBy
FROM [ods].[Schoology_groups_enrollments] t
	JOIN inserted i ON  t.[enrollment_id] = i.[enrollment_id]

INSERT INTO [ods].[Snapshot_Schoology_groups_enrollments] ([Group_ID],[enrollment_id],[uid],[school_uid],[name_title],[name_title_show],[name_first],[name_first_preferred],[use_preferred_first_name],[name_middle],[name_middle_show],[name_last],[name_display],[admin],[status],[picture_url],[links_self],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate])
SELECT a.*,dateadd(s,-1,@ETL_UpdatedOn)
FROM deleted a

END
GO
ALTER TABLE [ods].[Schoology_groups_enrollments] ADD CONSTRAINT [PK__Schoolog__6D24AA7A169CB6AD] PRIMARY KEY CLUSTERED  ([enrollment_id])
GO
