CREATE TABLE [ods].[BlackBaudFE_journalentrybatches_batch_customfields]
(
[journal_entry_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[custom_fields_custom_field_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[custom_fields_field_name] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[custom_fields_value] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[custom_fields_comments] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[custom_fields_type] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[custom_fields_date] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_CreatedOn] [datetime] NOT NULL CONSTRAINT [DF__BlackBaud__ETL_C__67162AF4] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__BlackBaud__ETL_C__680A4F2D] DEFAULT (suser_sname()),
[ETL_UpdatedOn] [datetime] NOT NULL CONSTRAINT [DF__BlackBaud__ETL_U__68FE7366] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__BlackBaud__ETL_U__69F2979F] DEFAULT (suser_sname())
)
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

----------- CREATE TRIGGER -----------
CREATE TRIGGER [ods].[Snapshot_BlackBaudFE_journalentrybatches_batch_customfieldsUpdate] ON [ods].[BlackBaudFE_journalentrybatches_batch_customfields]
AFTER UPDATE, DELETE

AS
BEGIN

DECLARE @ETL_UpdatedOn DATETIME = (SELECT [etl].[ConvertToLocalTime](CAST(GETDATE() AS DATETIME2(0))))
DECLARE @ETL_UpdatedBy NVARCHAR(400) = (SELECT SYSTEM_USER)

UPDATE t SET
[ETL_UpdatedOn] = @ETL_UpdatedOn
,[ETL_UpdatedBy] = @ETL_UpdatedBy
FROM [ods].[BlackBaudFE_journalentrybatches_batch_customfields] t
	JOIN inserted i ON  t.[journal_entry_id] = i.[journal_entry_id] AND t.[custom_fields_custom_field_id] = i.[custom_fields_custom_field_id]

INSERT INTO [ods].[Snapshot_BlackBaudFE_journalentrybatches_batch_customfields] ([journal_entry_id],[custom_fields_custom_field_id],[custom_fields_field_name],[custom_fields_value],[custom_fields_comments],[custom_fields_type],[custom_fields_date],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate])
SELECT a.*,dateadd(s,-1,@ETL_UpdatedOn)
FROM deleted a

END
GO
ALTER TABLE [ods].[BlackBaudFE_journalentrybatches_batch_customfields] ADD CONSTRAINT [PK__BlackBau__478900AA92956E3B] PRIMARY KEY CLUSTERED  ([journal_entry_id], [custom_fields_custom_field_id])
GO
