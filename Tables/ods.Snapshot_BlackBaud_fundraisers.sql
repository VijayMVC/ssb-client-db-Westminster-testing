CREATE TABLE [ods].[Snapshot_BlackBaud_fundraisers]
(
[BlackBaud_fundraisersSK] [int] NOT NULL IDENTITY(1, 1),
[constituent_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FundRaiserCount] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FundRaiser_constituent_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FundRaiser_type] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_CreatedOn] [datetime] NULL,
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_UpdatedOn] [datetime] NULL,
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RecordEndDate] [datetime] NULL
)
GO
ALTER TABLE [ods].[Snapshot_BlackBaud_fundraisers] ADD CONSTRAINT [PK__Snapshot__04EB2A02E5160EBF] PRIMARY KEY CLUSTERED  ([BlackBaud_fundraisersSK])
GO
