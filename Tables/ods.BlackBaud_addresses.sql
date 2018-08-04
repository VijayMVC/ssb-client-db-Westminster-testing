CREATE TABLE [ods].[BlackBaud_addresses]
(
[address_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[constituent_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[type] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[formatted_address] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[preferred] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[inactive] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[do_not_mail] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address_lines] [nvarchar] (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[city] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[date_added] [datetime2] NULL,
[date_modified] [datetime2] NULL,
[state] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[postal_code] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[county] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[country] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_CreatedOn] [datetime] NOT NULL CONSTRAINT [DF__BlackBaud__ETL_C__26F3128E] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__BlackBaud__ETL_C__27E736C7] DEFAULT (suser_sname()),
[ETL_UpdatedOn] [datetime] NOT NULL CONSTRAINT [DF__BlackBaud__ETL_U__28DB5B00] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__BlackBaud__ETL_U__29CF7F39] DEFAULT (suser_sname())
)
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

----------- CREATE TRIGGER -----------
CREATE TRIGGER [ods].[Snapshot_BlackBaud_addressesUpdate] ON [ods].[BlackBaud_addresses]
AFTER UPDATE, DELETE

AS
BEGIN

DECLARE @ETL_UpdatedOn DATETIME = (SELECT [etl].[ConvertToLocalTime](CAST(GETDATE() AS DATETIME2(0))))
DECLARE @ETL_UpdatedBy NVARCHAR(400) = (SELECT SYSTEM_USER)

UPDATE t SET
[ETL_UpdatedOn] = @ETL_UpdatedOn
,[ETL_UpdatedBy] = @ETL_UpdatedBy
FROM [ods].[BlackBaud_addresses] t
	JOIN inserted i ON  t.[address_id] = i.[address_id]

INSERT INTO [ods].[Snapshot_BlackBaud_addresses] ([address_id],[constituent_id],[type],[formatted_address],[preferred],[inactive],[do_not_mail],[address_lines],[city],[date_added],[date_modified],[state],[postal_code],[county],[country],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate])
SELECT a.*,dateadd(s,-1,@ETL_UpdatedOn)
FROM deleted a

END
GO
ALTER TABLE [ods].[BlackBaud_addresses] ADD CONSTRAINT [PK__BlackBau__CAA247C836E6C7C0] PRIMARY KEY CLUSTERED  ([address_id])
GO
