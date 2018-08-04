CREATE TABLE [ods].[Snapshot_BlackBaud_campaigns]
(
[BlackBaud_campaignsSK] [int] NOT NULL IDENTITY(1, 1),
[CampaignID] [int] NULL,
[DateAdded] [datetime2] NULL,
[DateModified] [datetime2] NULL,
[Description] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Inactive] [bit] NULL,
[lookupID] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[StartDate] [datetime2] NULL,
[GoalValue] [float] NULL,
[ETL_CreatedOn] [datetime] NULL,
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_UpdatedOn] [datetime] NULL,
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RecordEndDate] [datetime] NULL
)
GO
ALTER TABLE [ods].[Snapshot_BlackBaud_campaigns] ADD CONSTRAINT [PK__Snapshot__81F32FB33AE038E6] PRIMARY KEY CLUSTERED  ([BlackBaud_campaignsSK])
GO
