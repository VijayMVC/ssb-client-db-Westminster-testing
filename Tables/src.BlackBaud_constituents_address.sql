CREATE TABLE [src].[BlackBaud_constituents_address]
(
[SK] [bigint] NULL,
[ETL__multi_query_value_for_audit] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address_id] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[constituent_id] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address_type] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address_formatted-address] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address_preferred] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address_do-not-mail] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address_address-lines] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address_city] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address_state] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address_postal-code] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address_county] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address_country] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
