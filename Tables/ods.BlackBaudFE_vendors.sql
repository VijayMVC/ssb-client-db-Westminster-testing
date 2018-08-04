CREATE TABLE [ods].[BlackBaudFE_vendors]
(
[vendor_id] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[vendor-name] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[balance-due] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ui-defined-id] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[customer-number] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[vendor-status] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[issue-1099s] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[payment-method] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address-id] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[description] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[country] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[city] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[county] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[state] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[postal] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address-line] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[is-primary] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[is-invoices] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[is-pos] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[is-1099] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[title] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[first-name] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[middle-name] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[last-name] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[suffix] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[position] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address-contact-methods] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_CreatedOn] [datetime] NOT NULL CONSTRAINT [DF__BlackBaud__ETL_C__15FA39EE] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__BlackBaud__ETL_C__16EE5E27] DEFAULT (suser_sname()),
[ETL_UpdatedOn] [datetime] NOT NULL CONSTRAINT [DF__BlackBaud__ETL_U__17E28260] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__BlackBaud__ETL_U__18D6A699] DEFAULT (suser_sname())
)
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

----------- CREATE TRIGGER -----------
CREATE TRIGGER [ods].[Snapshot_BlackBaudFE_vendorsUpdate] ON [ods].[BlackBaudFE_vendors]
AFTER UPDATE, DELETE

AS
BEGIN

DECLARE @ETL_UpdatedOn DATETIME = (SELECT [etl].[ConvertToLocalTime](CAST(GETDATE() AS DATETIME2(0))))
DECLARE @ETL_UpdatedBy NVARCHAR(400) = (SELECT SYSTEM_USER)

UPDATE t SET
[ETL_UpdatedOn] = @ETL_UpdatedOn
,[ETL_UpdatedBy] = @ETL_UpdatedBy
FROM [ods].[BlackBaudFE_vendors] t
	JOIN inserted i ON  t.[vendor_id] = i.[vendor_id]

INSERT INTO [ods].[Snapshot_BlackBaudFE_vendors] ([vendor_id],[vendor-name],[balance-due],[ui-defined-id],[customer-number],[vendor-status],[issue-1099s],[payment-method],[address-id],[description],[country],[city],[county],[state],[postal],[address-line],[is-primary],[is-invoices],[is-pos],[is-1099],[title],[first-name],[middle-name],[last-name],[suffix],[position],[address-contact-methods],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate])
SELECT a.*,dateadd(s,-1,@ETL_UpdatedOn)
FROM deleted a

END
GO
ALTER TABLE [ods].[BlackBaudFE_vendors] ADD CONSTRAINT [PK__BlackBau__0F7D2B78874DC47A] PRIMARY KEY CLUSTERED  ([vendor_id])
GO
