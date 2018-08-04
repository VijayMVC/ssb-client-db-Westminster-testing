CREATE TABLE [ods].[BlackBaudFE_budgets_projects]
(
[Budget_scenario_ID] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[budget_category] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[account_number] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ui_project_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[fiscal_year] [nvarchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[total_amount] [float] NULL,
[fiscal_period] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[period_amount] [float] NULL,
[period_percent] [float] NULL,
[ETL_CreatedOn] [datetime] NOT NULL CONSTRAINT [DF__BlackBaud__ETL_C__53A363CD] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__BlackBaud__ETL_C__54978806] DEFAULT (suser_sname()),
[ETL_UpdatedOn] [datetime] NOT NULL CONSTRAINT [DF__BlackBaud__ETL_U__558BAC3F] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__BlackBaud__ETL_U__567FD078] DEFAULT (suser_sname())
)
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

----------- CREATE TRIGGER -----------
CREATE TRIGGER [ods].[Snapshot_BlackBaudFE_budgets_projectsUpdate] ON [ods].[BlackBaudFE_budgets_projects]
AFTER UPDATE, DELETE

AS
BEGIN

DECLARE @ETL_UpdatedOn DATETIME = (SELECT [etl].[ConvertToLocalTime](CAST(GETDATE() AS DATETIME2(0))))
DECLARE @ETL_UpdatedBy NVARCHAR(400) = (SELECT SYSTEM_USER)

UPDATE t SET
[ETL_UpdatedOn] = @ETL_UpdatedOn
,[ETL_UpdatedBy] = @ETL_UpdatedBy
FROM [ods].[BlackBaudFE_budgets_projects] t
	JOIN inserted i ON  t.[Budget_scenario_ID] = i.[Budget_scenario_ID] AND t.[budget_category] = i.[budget_category] AND t.[account_number] = i.[account_number] AND t.[ui_project_id] = i.[ui_project_id] AND t.[fiscal_year] = i.[fiscal_year] AND t.[fiscal_period] = i.[fiscal_period]

INSERT INTO [ods].[Snapshot_BlackBaudFE_budgets_projects] ([Budget_scenario_ID],[budget_category],[account_number],[ui_project_id],[fiscal_year],[total_amount],[fiscal_period],[period_amount],[period_percent],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate])
SELECT a.*,dateadd(s,-1,@ETL_UpdatedOn)
FROM deleted a

END
GO
ALTER TABLE [ods].[BlackBaudFE_budgets_projects] ADD CONSTRAINT [PK__BlackBau__7F2A9F45D5DDEB8F] PRIMARY KEY CLUSTERED  ([Budget_scenario_ID], [budget_category], [account_number], [ui_project_id], [fiscal_year], [fiscal_period])
GO
