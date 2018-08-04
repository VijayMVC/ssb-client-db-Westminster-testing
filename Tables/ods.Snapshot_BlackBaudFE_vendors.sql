CREATE TABLE [ods].[Snapshot_BlackBaudFE_vendors]
(
[BlackBaudFE_vendorsSK] [int] NOT NULL IDENTITY(1, 1),
[vendor_id] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
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
[ETL_CreatedOn] [datetime] NULL,
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_UpdatedOn] [datetime] NULL,
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RecordEndDate] [datetime] NULL
)
GO
ALTER TABLE [ods].[Snapshot_BlackBaudFE_vendors] ADD CONSTRAINT [PK__Snapshot__C744B8E0817B175E] PRIMARY KEY CLUSTERED  ([BlackBaudFE_vendorsSK])
GO
