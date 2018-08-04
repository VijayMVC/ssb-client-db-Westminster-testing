CREATE TABLE [ods].[Snapshot_BlackBaudFE_accounts]
(
[BlackBaudFE_accountsSK] [int] NOT NULL IDENTITY(1, 1),
[account_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[account_number] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[description] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[date-added] [datetime2] NULL,
[added-by] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[date-modified] [datetime2] NULL,
[modified-by] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_CreatedOn] [datetime] NULL,
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_UpdatedOn] [datetime] NULL,
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RecordEndDate] [datetime] NULL
)
GO
ALTER TABLE [ods].[Snapshot_BlackBaudFE_accounts] ADD CONSTRAINT [PK__Snapshot__C01D5747761A19F7] PRIMARY KEY CLUSTERED  ([BlackBaudFE_accountsSK])
GO
