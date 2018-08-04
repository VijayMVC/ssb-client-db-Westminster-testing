CREATE TABLE [ods].[Snapshot_BlackBaud_funds]
(
[BlackBaud_fundsSK] [int] NOT NULL IDENTITY(1, 1),
[FundID] [int] NULL,
[DateAdded] [datetime2] NULL,
[DateModified] [datetime2] NULL,
[Description] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Inactive] [bit] NULL,
[LookupID] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[StartDate] [datetime2] NULL,
[Category] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EndDate] [datetime2] NULL,
[GoalValue] [float] NULL,
[ETL_CreatedOn] [datetime] NULL,
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_UpdatedOn] [datetime] NULL,
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RecordEndDate] [datetime] NULL
)
GO
ALTER TABLE [ods].[Snapshot_BlackBaud_funds] ADD CONSTRAINT [PK__Snapshot__B9A803D0818553B1] PRIMARY KEY CLUSTERED  ([BlackBaud_fundsSK])
GO
