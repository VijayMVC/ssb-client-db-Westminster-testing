CREATE TABLE [ods].[Schoology_grading_scales]
(
[Section_ID] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[gradingscale_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[title] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[type] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[auto_averaging] [bit] NULL,
[hide_numeric] [bit] NULL,
[Grandingscale_level] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[grade] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[cutoff] [float] NULL,
[average] [float] NULL,
[description] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_CreatedOn] [datetime] NOT NULL CONSTRAINT [DF__Schoology__ETL_C__2B3A43CA] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__Schoology__ETL_C__2C2E6803] DEFAULT (suser_sname()),
[ETL_UpdatedOn] [datetime] NOT NULL CONSTRAINT [DF__Schoology__ETL_U__2D228C3C] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__Schoology__ETL_U__2E16B075] DEFAULT (suser_sname())
)
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
----------- CREATE TRIGGER -----------
CREATE TRIGGER [ods].[Snapshot_Schoology_grading_scalesUpdate] ON [ods].[Schoology_grading_scales]
AFTER UPDATE, DELETE

AS
BEGIN

DECLARE @ETL_UpdatedOn DATETIME = (SELECT [etl].[ConvertToLocalTime](CAST(GETDATE() AS DATETIME2(0))))
DECLARE @ETL_UpdatedBy NVARCHAR(400) = (SELECT SYSTEM_USER)

UPDATE t SET
[ETL_UpdatedOn] = @ETL_UpdatedOn
,[ETL_UpdatedBy] = @ETL_UpdatedBy
FROM [ods].[Schoology_grading_scales] t
	JOIN inserted i ON  t.[Section_ID] = i.[Section_ID] AND t.[title] = i.[title] AND t.[grade] = i.[grade]

INSERT INTO [ods].[Snapshot_Schoology_grading_scales] ([Section_ID],[gradingscale_id],[title],[type],[auto_averaging],[hide_numeric],[Grandingscale_level],[grade],[cutoff],[average],[description],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate])
SELECT a.*,dateadd(s,-1,@ETL_UpdatedOn)
FROM deleted a

END
GO
ALTER TABLE [ods].[Schoology_grading_scales] ADD CONSTRAINT [PK__Schoolog__7348667D7A3C5254] PRIMARY KEY CLUSTERED  ([Section_ID], [gradingscale_id], [title], [grade])
GO
