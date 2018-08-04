CREATE TABLE [ods].[BlackBaudFE_journalentrybatches_batch_distributions]
(
[journal_entry_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[distribution_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[distributions_ui_project_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[distributions_account_class] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[distributions_amount] [float] NULL,
[distributions_percent] [float] NULL,
[distributions_transaction_code_values_name] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[distributions_transaction_code_values_value] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_CreatedOn] [datetime] NOT NULL CONSTRAINT [DF__BlackBaud__ETL_C__709F952E] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__BlackBaud__ETL_C__7193B967] DEFAULT (suser_sname()),
[ETL_UpdatedOn] [datetime] NOT NULL CONSTRAINT [DF__BlackBaud__ETL_U__7287DDA0] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__BlackBaud__ETL_U__737C01D9] DEFAULT (suser_sname())
)
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

----------- CREATE TRIGGER -----------
CREATE TRIGGER [ods].[Snapshot_BlackBaudFE_journalentrybatches_batch_distributionsUpdate] ON [ods].[BlackBaudFE_journalentrybatches_batch_distributions]
AFTER UPDATE, DELETE

AS
BEGIN

DECLARE @ETL_UpdatedOn DATETIME = (SELECT [etl].[ConvertToLocalTime](CAST(GETDATE() AS DATETIME2(0))))
DECLARE @ETL_UpdatedBy NVARCHAR(400) = (SELECT SYSTEM_USER)

UPDATE t SET
[ETL_UpdatedOn] = @ETL_UpdatedOn
,[ETL_UpdatedBy] = @ETL_UpdatedBy
FROM [ods].[BlackBaudFE_journalentrybatches_batch_distributions] t
	JOIN inserted i ON  t.[distribution_id] = i.[distribution_id]

INSERT INTO [ods].[Snapshot_BlackBaudFE_journalentrybatches_batch_distributions] ([journal_entry_id],[distribution_id],[distributions_ui_project_id],[distributions_account_class],[distributions_amount],[distributions_percent],[distributions_transaction_code_values_name],[distributions_transaction_code_values_value],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate])
SELECT a.*,dateadd(s,-1,@ETL_UpdatedOn)
FROM deleted a

END
GO
ALTER TABLE [ods].[BlackBaudFE_journalentrybatches_batch_distributions] ADD CONSTRAINT [PK__BlackBau__330512D45D2A660F] PRIMARY KEY CLUSTERED  ([distribution_id])
GO
