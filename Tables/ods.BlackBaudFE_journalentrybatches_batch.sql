CREATE TABLE [ods].[BlackBaudFE_journalentrybatches_batch]
(
[journal_entry_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[batch_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ui_batch_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[type_code] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[line_number] [int] NULL,
[account_number] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[post_date] [datetime2] NULL,
[encumbrance] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[journal] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[reference] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[amount] [float] NULL,
[notes] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_CreatedOn] [datetime] NOT NULL CONSTRAINT [DF__BlackBaud__ETL_C__5D8CC0BA] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__BlackBaud__ETL_C__5E80E4F3] DEFAULT (suser_sname()),
[ETL_UpdatedOn] [datetime] NOT NULL CONSTRAINT [DF__BlackBaud__ETL_U__5F75092C] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__BlackBaud__ETL_U__60692D65] DEFAULT (suser_sname())
)
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

----------- CREATE TRIGGER -----------
CREATE TRIGGER [ods].[Snapshot_BlackBaudFE_journalentrybatches_batchUpdate] ON [ods].[BlackBaudFE_journalentrybatches_batch]
AFTER UPDATE, DELETE

AS
BEGIN

DECLARE @ETL_UpdatedOn DATETIME = (SELECT [etl].[ConvertToLocalTime](CAST(GETDATE() AS DATETIME2(0))))
DECLARE @ETL_UpdatedBy NVARCHAR(400) = (SELECT SYSTEM_USER)

UPDATE t SET
[ETL_UpdatedOn] = @ETL_UpdatedOn
,[ETL_UpdatedBy] = @ETL_UpdatedBy
FROM [ods].[BlackBaudFE_journalentrybatches_batch] t
	JOIN inserted i ON  t.[journal_entry_id] = i.[journal_entry_id]

INSERT INTO [ods].[Snapshot_BlackBaudFE_journalentrybatches_batch] ([journal_entry_id],[batch_id],[ui_batch_id],[type_code],[line_number],[account_number],[post_date],[encumbrance],[journal],[reference],[amount],[notes],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate])
SELECT a.*,dateadd(s,-1,@ETL_UpdatedOn)
FROM deleted a

END
GO
ALTER TABLE [ods].[BlackBaudFE_journalentrybatches_batch] ADD CONSTRAINT [PK__BlackBau__97DD235E44BFE7B3] PRIMARY KEY CLUSTERED  ([journal_entry_id])
GO
