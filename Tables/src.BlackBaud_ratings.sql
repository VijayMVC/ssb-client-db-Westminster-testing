CREATE TABLE [src].[BlackBaud_ratings]
(
[SK] [bigint] NULL,
[ETL__multi_query_value_for_audit] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RatingID] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RatingCategory] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RatingComment] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Constituent_ID] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RatingDate] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Inactive] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RatingSource] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RatingType] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RatingValue] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
