CREATE TABLE [ods].[Snapshot_BlackBaud_gifts_softcredit]
(
[BlackBaud_gifts_softcreditSK] [int] NOT NULL IDENTITY(1, 1),
[giftid] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[soft-credits_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[soft-credits_constituent-id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[soft-credits_gift-id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[soft-credits_amount_value] [float] NULL,
[ETL_CreatedOn] [datetime] NULL,
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_UpdatedOn] [datetime] NULL,
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RecordEndDate] [datetime] NULL
)
GO
ALTER TABLE [ods].[Snapshot_BlackBaud_gifts_softcredit] ADD CONSTRAINT [PK__Snapshot__83E6ABABC7A83736] PRIMARY KEY CLUSTERED  ([BlackBaud_gifts_softcreditSK])
GO
