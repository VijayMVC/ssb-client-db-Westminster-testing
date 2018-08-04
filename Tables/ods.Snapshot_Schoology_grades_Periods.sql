CREATE TABLE [ods].[Snapshot_Schoology_grades_Periods]
(
[Schoology_grades_PeriodsSK] [int] NOT NULL IDENTITY(1, 1),
[section_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[period_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[period_title] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[period_weight] [float] NULL,
[ETL_CreatedOn] [datetime] NULL,
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_UpdatedOn] [datetime] NULL,
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RecordEndDate] [datetime] NULL
)
GO
ALTER TABLE [ods].[Snapshot_Schoology_grades_Periods] ADD CONSTRAINT [PK__Snapshot__3880D5C306AF3F4D] PRIMARY KEY CLUSTERED  ([Schoology_grades_PeriodsSK])
GO
