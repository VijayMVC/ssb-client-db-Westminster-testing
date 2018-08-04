CREATE TABLE [ods].[BlackBaudFE_budgets_accounts]
(
[Budget_scenario_ID] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[budget_category] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[account_number] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fiscal_year] [nvarchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[total_amount] [float] NULL,
[fiscal_period] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[period_amount] [float] NULL,
[period_percent] [float] NULL,
[ETL_CreatedOn] [datetime] NOT NULL CONSTRAINT [DF__BlackBaud__ETL_C__6B251C4C] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__BlackBaud__ETL_C__6C194085] DEFAULT (suser_sname()),
[ETL_UpdatedOn] [datetime] NOT NULL CONSTRAINT [DF__BlackBaud__ETL_U__6D0D64BE] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__BlackBaud__ETL_U__6E0188F7] DEFAULT (suser_sname())
)
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

----------- CREATE TRIGGER -----------
CREATE TRIGGER [ods].[Snapshot_BlackBaudFE_budgets_accountsUpdate] ON [ods].[BlackBaudFE_budgets_accounts]
AFTER UPDATE, DELETE

AS
BEGIN

DECLARE @ETL_UpdatedOn DATETIME = (SELECT [etl].[ConvertToLocalTime](CAST(GETDATE() AS DATETIME2(0))))
DECLARE @ETL_UpdatedBy NVARCHAR(400) = (SELECT SYSTEM_USER)

UPDATE t SET
[ETL_UpdatedOn] = @ETL_UpdatedOn
,[ETL_UpdatedBy] = @ETL_UpdatedBy
FROM [ods].[BlackBaudFE_budgets_accounts] t
	JOIN inserted i ON  t.[Budget_scenario_ID] = i.[Budget_scenario_ID] AND t.[budget_category] = i.[budget_category] AND t.[account_number] = i.[account_number] AND t.[fiscal_year] = i.[fiscal_year] AND t.[fiscal_period] = i.[fiscal_period]

INSERT INTO [ods].[Snapshot_BlackBaudFE_budgets_accounts] ([Budget_scenario_ID],[budget_category],[account_number],[fiscal_year],[total_amount],[fiscal_period],[period_amount],[period_percent],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate])
SELECT a.*,dateadd(s,-1,@ETL_UpdatedOn)
FROM deleted a

END
GO
ALTER TABLE [ods].[BlackBaudFE_budgets_accounts] ADD CONSTRAINT [PK__BlackBau__3E50201BE973B389] PRIMARY KEY CLUSTERED  ([Budget_scenario_ID], [budget_category], [account_number], [fiscal_year], [fiscal_period])
GO
