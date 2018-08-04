CREATE TABLE [ods].[Snapshot_BlackBaud_gifts_fundraiser]
(
[BlackBaud_gifts_fundraiserSK] [int] NOT NULL IDENTITY(1, 1),
[giftid] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fundraisers_constituent-id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fundraisers_amount_value] [float] NULL,
[ETL_CreatedOn] [datetime] NULL,
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_UpdatedOn] [datetime] NULL,
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RecordEndDate] [datetime] NULL
)
GO
ALTER TABLE [ods].[Snapshot_BlackBaud_gifts_fundraiser] ADD CONSTRAINT [PK__Snapshot__C183B7FA5610F20A] PRIMARY KEY CLUSTERED  ([BlackBaud_gifts_fundraiserSK])
GO
