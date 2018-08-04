CREATE TABLE [ods].[Snapshot_BlackBaud_ratings]
(
[BlackBaud_ratingsSK] [int] NOT NULL IDENTITY(1, 1),
[RatingID] [int] NULL,
[RatingCategory] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RatingComment] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Constituent_ID] [int] NULL,
[RatingDate] [datetime2] NULL,
[Inactive] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RatingSource] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RatingType] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RatingValue] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_CreatedOn] [datetime] NULL,
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_UpdatedOn] [datetime] NULL,
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RecordEndDate] [datetime] NULL
)
GO
ALTER TABLE [ods].[Snapshot_BlackBaud_ratings] ADD CONSTRAINT [PK__Snapshot__1B15A5BD2CD448C7] PRIMARY KEY CLUSTERED  ([BlackBaud_ratingsSK])
GO
