CREATE TABLE [ods].[Snapshot_BlackBaudFE_accounts_account]
(
[BlackBaudFE_accounts_accountSK] [int] NOT NULL IDENTITY(1, 1),
[Account_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[account_number] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[description] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[prevent_data_entry] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[prevent_posting_date] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[class] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[cashflow] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[working_capital] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[default_transaction_codes_name] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[default_transaction_codes_value] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_CreatedOn] [datetime] NULL,
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_UpdatedOn] [datetime] NULL,
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RecordEndDate] [datetime] NULL
)
GO
ALTER TABLE [ods].[Snapshot_BlackBaudFE_accounts_account] ADD CONSTRAINT [PK__Snapshot__DBEA0B614502FC16] PRIMARY KEY CLUSTERED  ([BlackBaudFE_accounts_accountSK])
GO
