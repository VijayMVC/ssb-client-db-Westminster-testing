CREATE TABLE [ods].[Snapshot_BlackBaud_gifts]
(
[BlackBaud_giftsSK] [int] NOT NULL IDENTITY(1, 1),
[giftid] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[date] [datetime2] NULL,
[date_added] [datetime2] NULL,
[date_modified] [datetime2] NULL,
[type] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[constituent_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[is_anonymous] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[post_status] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[gift_status] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[reference] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[post_date] [datetime2] NULL,
[subtype] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[amount_value] [float] NULL,
[ETL_CreatedOn] [datetime] NULL,
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_UpdatedOn] [datetime] NULL,
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RecordEndDate] [datetime] NULL
)
GO
ALTER TABLE [ods].[Snapshot_BlackBaud_gifts] ADD CONSTRAINT [PK__Snapshot__AFC4DE789A83875A] PRIMARY KEY CLUSTERED  ([BlackBaud_giftsSK])
GO
