CREATE TABLE [src].[BlackBaud_gifts]
(
[SK] [bigint] NULL,
[ETL__multi_query_value_for_audit] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[giftid] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[date] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[date-added] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[date-modified] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[type] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[constituent-id] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[is-anonymous] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[post-status] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[gift-status] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[reference] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[post-date] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[subtype] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[amount_value] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[gift-splits_fund-id] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fundraisers_constituent-id] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[gift-splits_campaign-id] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[gift-splits_appeal-id] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[soft-credits_constituent-id] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[soft-credits_id] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[soft-credits_gift-id] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[gift-splits_amount_value] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[soft-credits_amount_value] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fundraisers_amount_value] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
