CREATE TABLE [ods].[BlackBaudFE_budgets]
(
[budget_scenario_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[description] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[start-fiscal-year] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[end-fiscal-year] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[start-date] [datetime2] NULL,
[end-date] [datetime2] NULL,
[status] [nvarchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[budget-type] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[locked] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_CreatedOn] [datetime] NOT NULL CONSTRAINT [DF__BlackBaud__ETL_C__287E6C3D] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__BlackBaud__ETL_C__29729076] DEFAULT (suser_sname()),
[ETL_UpdatedOn] [datetime] NOT NULL CONSTRAINT [DF__BlackBaud__ETL_U__2A66B4AF] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__BlackBaud__ETL_U__2B5AD8E8] DEFAULT (suser_sname())
)
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

----------- CREATE TRIGGER -----------
CREATE TRIGGER [ods].[Snapshot_BlackBaudFE_budgetsUpdate] ON [ods].[BlackBaudFE_budgets]
AFTER UPDATE, DELETE

AS
BEGIN

DECLARE @ETL_UpdatedOn DATETIME = (SELECT [etl].[ConvertToLocalTime](CAST(GETDATE() AS DATETIME2(0))))
DECLARE @ETL_UpdatedBy NVARCHAR(400) = (SELECT SYSTEM_USER)

UPDATE t SET
[ETL_UpdatedOn] = @ETL_UpdatedOn
,[ETL_UpdatedBy] = @ETL_UpdatedBy
FROM [ods].[BlackBaudFE_budgets] t
	JOIN inserted i ON  t.[budget_scenario_id] = i.[budget_scenario_id]

INSERT INTO [ods].[Snapshot_BlackBaudFE_budgets] ([budget_scenario_id],[description],[start-fiscal-year],[end-fiscal-year],[start-date],[end-date],[status],[budget-type],[locked],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate])
SELECT a.*,dateadd(s,-1,@ETL_UpdatedOn)
FROM deleted a

END
GO
ALTER TABLE [ods].[BlackBaudFE_budgets] ADD CONSTRAINT [PK__BlackBau__6C64EAA76F903547] PRIMARY KEY CLUSTERED  ([budget_scenario_id])
GO
