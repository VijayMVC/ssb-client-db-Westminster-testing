CREATE TABLE [ods].[Schoology_grade_items]
(
[section_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[assignment_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[title] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[description] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[due] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[grading_scale] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[grading_period] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[grading_category] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[max_points] [float] NULL,
[factor] [float] NULL,
[is_final] [bit] NULL,
[show_comments] [bit] NULL,
[grade_stats] [bit] NULL,
[allow_dropbox] [bit] NULL,
[allow_discussion] [bit] NULL,
[published] [bit] NULL,
[type] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[grade_item_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[available] [bit] NULL,
[completed] [bit] NULL,
[dropbox_locked] [bit] NULL,
[grading_scale_type] [int] NULL,
[show_rubric] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[display_weight] [int] NULL,
[folder_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[num_assignees] [int] NULL,
[last_updated] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[completion_status] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[topic_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_CreatedOn] [datetime] NOT NULL CONSTRAINT [DF__Schoology__ETL_C__47437FDD] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__Schoology__ETL_C__4837A416] DEFAULT (suser_sname()),
[ETL_UpdatedOn] [datetime] NOT NULL CONSTRAINT [DF__Schoology__ETL_U__492BC84F] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__Schoology__ETL_U__4A1FEC88] DEFAULT (suser_sname())
)
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
----------- CREATE TRIGGER -----------
CREATE TRIGGER [ods].[Snapshot_Schoology_grade_itemsUpdate] ON [ods].[Schoology_grade_items]
AFTER UPDATE, DELETE

AS
BEGIN

DECLARE @ETL_UpdatedOn DATETIME = (SELECT [etl].[ConvertToLocalTime](CAST(GETDATE() AS DATETIME2(0))))
DECLARE @ETL_UpdatedBy NVARCHAR(400) = (SELECT SYSTEM_USER)

UPDATE t SET
[ETL_UpdatedOn] = @ETL_UpdatedOn
,[ETL_UpdatedBy] = @ETL_UpdatedBy
FROM [ods].[Schoology_grade_items] t
	JOIN inserted i ON  t.[section_id] = i.[section_id] AND t.[assignment_id] = i.[assignment_id]

INSERT INTO [ods].[Snapshot_Schoology_grade_items] ([section_id],[assignment_id],[title],[description],[due],[grading_scale],[grading_period],[grading_category],[max_points],[factor],[is_final],[show_comments],[grade_stats],[allow_dropbox],[allow_discussion],[published],[type],[grade_item_id],[available],[completed],[dropbox_locked],[grading_scale_type],[show_rubric],[display_weight],[folder_id],[num_assignees],[last_updated],[completion_status],[topic_id],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate])
SELECT a.*,dateadd(s,-1,@ETL_UpdatedOn)
FROM deleted a

END
GO
ALTER TABLE [ods].[Schoology_grade_items] ADD CONSTRAINT [PK__Schoolog__A5EAF6EB6B7D9D4B] PRIMARY KEY CLUSTERED  ([section_id], [assignment_id])
GO
