CREATE TABLE [ods].[Snapshot_Schoology_grading_scales]
(
[Schoology_grading_scalesSK] [int] NOT NULL IDENTITY(1, 1),
[Section_ID] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[gradingscale_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[title] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[type] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[auto_averaging] [bit] NULL,
[hide_numeric] [bit] NULL,
[Grandingscale_level] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[grade] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[cutoff] [float] NULL,
[average] [float] NULL,
[description] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_CreatedOn] [datetime] NULL,
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_UpdatedOn] [datetime] NULL,
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RecordEndDate] [datetime] NULL
)
GO
ALTER TABLE [ods].[Snapshot_Schoology_grading_scales] ADD CONSTRAINT [PK__Snapshot__6C47747BCB264AFF] PRIMARY KEY CLUSTERED  ([Schoology_grading_scalesSK])
GO
