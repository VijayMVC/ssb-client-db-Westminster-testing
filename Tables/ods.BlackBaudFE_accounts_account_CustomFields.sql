CREATE TABLE [ods].[BlackBaudFE_accounts_account_CustomFields]
(
[Account_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[custom_fields_custom_field_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[custom_fields_field_name] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[custom_fields_value] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[custom_fields_comments] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[custom_fields_type] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[custom_fields_date] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_CreatedOn] [datetime] NOT NULL CONSTRAINT [DF__BlackBaud__ETL_C__5A375A10] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__BlackBaud__ETL_C__5B2B7E49] DEFAULT (suser_sname()),
[ETL_UpdatedOn] [datetime] NOT NULL CONSTRAINT [DF__BlackBaud__ETL_U__5C1FA282] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__BlackBaud__ETL_U__5D13C6BB] DEFAULT (suser_sname())
)
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

----------- CREATE TRIGGER -----------
CREATE TRIGGER [ods].[Snapshot_BlackBaudFE_accounts_account_CustomFieldsUpdate] ON [ods].[BlackBaudFE_accounts_account_CustomFields]
AFTER UPDATE, DELETE

AS
BEGIN

DECLARE @ETL_UpdatedOn DATETIME = (SELECT [etl].[ConvertToLocalTime](CAST(GETDATE() AS DATETIME2(0))))
DECLARE @ETL_UpdatedBy NVARCHAR(400) = (SELECT SYSTEM_USER)

UPDATE t SET
[ETL_UpdatedOn] = @ETL_UpdatedOn
,[ETL_UpdatedBy] = @ETL_UpdatedBy
FROM [ods].[BlackBaudFE_accounts_account_CustomFields] t
	JOIN inserted i ON  t.[custom_fields_custom_field_id] = i.[custom_fields_custom_field_id]

INSERT INTO [ods].[Snapshot_BlackBaudFE_accounts_account_CustomFields] ([Account_id],[custom_fields_custom_field_id],[custom_fields_field_name],[custom_fields_value],[custom_fields_comments],[custom_fields_type],[custom_fields_date],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate])
SELECT a.*,dateadd(s,-1,@ETL_UpdatedOn)
FROM deleted a

END
GO
ALTER TABLE [ods].[BlackBaudFE_accounts_account_CustomFields] ADD CONSTRAINT [PK__BlackBau__05423F4C4990AAB8] PRIMARY KEY CLUSTERED  ([custom_fields_custom_field_id])
GO
