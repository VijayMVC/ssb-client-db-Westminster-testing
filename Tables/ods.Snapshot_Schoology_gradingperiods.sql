CREATE TABLE [ods].[Snapshot_Schoology_gradingperiods]
(
[Schoology_gradingperiodsSK] [int] NOT NULL IDENTITY(1, 1),
[gradingperiod_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[title] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[start] [date] NULL,
[end] [date] NULL,
[active] [bit] NULL,
[has_children] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[parentid] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_CreatedOn] [datetime] NULL,
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_UpdatedOn] [datetime] NULL,
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RecordEndDate] [datetime] NULL
)
GO
ALTER TABLE [ods].[Snapshot_Schoology_gradingperiods] ADD CONSTRAINT [PK__Snapshot__4C6323B6A676FF9D] PRIMARY KEY CLUSTERED  ([Schoology_gradingperiodsSK])
GO
