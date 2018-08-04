CREATE TABLE [ods].[Snapshot_BlackBaud_appeals]
(
[BlackBaud_appealsSK] [int] NOT NULL IDENTITY(1, 1),
[AppealID] [int] NULL,
[DateAdded] [datetime2] NULL,
[DateModified] [datetime2] NULL,
[Description] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Inactive] [bit] NULL,
[LookupID] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EndDate] [datetime2] NULL,
[StartDate] [datetime2] NULL,
[GoalValue] [float] NULL,
[ETL_CreatedOn] [datetime] NULL,
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_UpdatedOn] [datetime] NULL,
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RecordEndDate] [datetime] NULL
)
GO
ALTER TABLE [ods].[Snapshot_BlackBaud_appeals] ADD CONSTRAINT [PK__Snapshot__705ADE5E431AFAAC] PRIMARY KEY CLUSTERED  ([BlackBaud_appealsSK])
GO
