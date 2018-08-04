CREATE TABLE [ods].[Snapshot_BlackBaud_gifts_splits]
(
[BlackBaud_gifts_splitsSK] [int] NOT NULL IDENTITY(1, 1),
[giftid] [int] NULL,
[FundID] [int] NULL,
[CampaignID] [int] NULL,
[AppealID] [int] NULL,
[amount_value] [float] NULL,
[ETL_CreatedOn] [datetime] NULL,
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_UpdatedOn] [datetime] NULL,
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RecordEndDate] [datetime] NULL
)
GO
ALTER TABLE [ods].[Snapshot_BlackBaud_gifts_splits] ADD CONSTRAINT [PK__Snapshot__24E2C7D476394740] PRIMARY KEY CLUSTERED  ([BlackBaud_gifts_splitsSK])
GO
