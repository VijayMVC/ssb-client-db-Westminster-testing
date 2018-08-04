CREATE TABLE [src].[BlackBaudFE_accounts_account]
(
[SK] [bigint] NULL,
[ETL__multi_query_value_for_audit] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Account-id] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[account-number] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[description] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[prevent-data-entry] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[prevent-posting-date] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[class] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[cashflow] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[working-capital] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[custom-fields_] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[custom-fields_custom-field-id] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[custom-fields_field-name] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[custom-fields_value] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[custom-fields_comments] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[custom-fields_type] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[custom-fields_date] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[default-transaction-codes_name] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[default-transaction-codes_value] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
