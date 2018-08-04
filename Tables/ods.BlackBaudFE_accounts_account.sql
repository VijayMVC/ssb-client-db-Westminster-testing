CREATE TABLE [ods].[BlackBaudFE_accounts_account]
(
[Account_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[account_number] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[description] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[prevent_data_entry] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[prevent_posting_date] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[class] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[cashflow] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[working_capital] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[default_transaction_codes_name] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[default_transaction_codes_value] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_CreatedOn] [datetime] NOT NULL CONSTRAINT [DF__BlackBaud__ETL_C__50ADEFD6] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__BlackBaud__ETL_C__51A2140F] DEFAULT (suser_sname()),
[ETL_UpdatedOn] [datetime] NOT NULL CONSTRAINT [DF__BlackBaud__ETL_U__52963848] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__BlackBaud__ETL_U__538A5C81] DEFAULT (suser_sname())
)
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

----------- CREATE TRIGGER -----------
CREATE TRIGGER [ods].[Snapshot_BlackBaudFE_accounts_accountUpdate] ON [ods].[BlackBaudFE_accounts_account]
AFTER UPDATE, DELETE

AS
BEGIN

DECLARE @ETL_UpdatedOn DATETIME = (SELECT [etl].[ConvertToLocalTime](CAST(GETDATE() AS DATETIME2(0))))
DECLARE @ETL_UpdatedBy NVARCHAR(400) = (SELECT SYSTEM_USER)

UPDATE t SET
[ETL_UpdatedOn] = @ETL_UpdatedOn
,[ETL_UpdatedBy] = @ETL_UpdatedBy
FROM [ods].[BlackBaudFE_accounts_account] t
	JOIN inserted i ON  t.[Account_id] = i.[Account_id]

INSERT INTO [ods].[Snapshot_BlackBaudFE_accounts_account] ([Account_id],[account_number],[description],[prevent_data_entry],[prevent_posting_date],[class],[cashflow],[working_capital],[default_transaction_codes_name],[default_transaction_codes_value],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate])
SELECT a.*,dateadd(s,-1,@ETL_UpdatedOn)
FROM deleted a

END
GO
ALTER TABLE [ods].[BlackBaudFE_accounts_account] ADD CONSTRAINT [PK__BlackBau__B19D4181BCE3C948] PRIMARY KEY CLUSTERED  ([Account_id])
GO
