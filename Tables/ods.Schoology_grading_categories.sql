CREATE TABLE [ods].[Schoology_grading_categories]
(
[grading_category_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[title] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[delta] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[realm] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[section_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[calculation_type] [int] NULL,
[default_max_points] [float] NULL,
[default_grading_scale_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[drop_lowest] [int] NULL,
[weight] [float] NULL,
[ETL_CreatedOn] [datetime] NOT NULL CONSTRAINT [DF__Schoology__ETL_C__646BCCE1] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__Schoology__ETL_C__655FF11A] DEFAULT (suser_sname()),
[ETL_UpdatedOn] [datetime] NOT NULL CONSTRAINT [DF__Schoology__ETL_U__66541553] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__Schoology__ETL_U__6748398C] DEFAULT (suser_sname())
)
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

----------- CREATE TRIGGER -----------
CREATE TRIGGER [ods].[Snapshot_Schoology_grading_categoriesUpdate] ON [ods].[Schoology_grading_categories]
AFTER UPDATE, DELETE

AS
BEGIN

DECLARE @ETL_UpdatedOn DATETIME = (SELECT [etl].[ConvertToLocalTime](CAST(GETDATE() AS DATETIME2(0))))
DECLARE @ETL_UpdatedBy NVARCHAR(400) = (SELECT SYSTEM_USER)

UPDATE t SET
[ETL_UpdatedOn] = @ETL_UpdatedOn
,[ETL_UpdatedBy] = @ETL_UpdatedBy
FROM [ods].[Schoology_grading_categories] t
	JOIN inserted i ON  t.[grading_category_id] = i.[grading_category_id] AND t.[section_id] = i.[section_id]

INSERT INTO [ods].[Snapshot_Schoology_grading_categories] ([grading_category_id],[title],[delta],[realm],[section_id],[calculation_type],[default_max_points],[default_grading_scale_id],[drop_lowest],[weight],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate])
SELECT a.*,dateadd(s,-1,@ETL_UpdatedOn)
FROM deleted a

END
GO
ALTER TABLE [ods].[Schoology_grading_categories] ADD CONSTRAINT [PK__Schoolog__3E60B29425F0D1F2] PRIMARY KEY CLUSTERED  ([grading_category_id], [section_id])
GO
