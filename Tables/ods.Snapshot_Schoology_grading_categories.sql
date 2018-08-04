CREATE TABLE [ods].[Snapshot_Schoology_grading_categories]
(
[Schoology_grading_categoriesSK] [int] NOT NULL IDENTITY(1, 1),
[grading_category_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[title] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[delta] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[realm] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[section_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[calculation_type] [int] NULL,
[default_max_points] [float] NULL,
[default_grading_scale_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[drop_lowest] [int] NULL,
[weight] [float] NULL,
[ETL_CreatedOn] [datetime] NULL,
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_UpdatedOn] [datetime] NULL,
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RecordEndDate] [datetime] NULL
)
GO
ALTER TABLE [ods].[Snapshot_Schoology_grading_categories] ADD CONSTRAINT [PK__Snapshot__A2E217E2B81E9A9E] PRIMARY KEY CLUSTERED  ([Schoology_grading_categoriesSK])
GO
