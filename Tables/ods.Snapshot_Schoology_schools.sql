CREATE TABLE [ods].[Snapshot_Schoology_schools]
(
[Schoology_schoolsSK] [int] NOT NULL IDENTITY(1, 1),
[schoolid] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[title] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address1] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address2] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[city] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[state] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[postal-code] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[country] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[website] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[phone] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fax] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[building-code] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[picture-url] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_CreatedOn] [datetime] NULL,
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_UpdatedOn] [datetime] NULL,
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RecordEndDate] [datetime] NULL
)
GO
ALTER TABLE [ods].[Snapshot_Schoology_schools] ADD CONSTRAINT [PK__Snapshot__155948E63981B95D] PRIMARY KEY CLUSTERED  ([Schoology_schoolsSK])
GO
