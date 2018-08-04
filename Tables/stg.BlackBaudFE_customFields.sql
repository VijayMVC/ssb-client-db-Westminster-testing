CREATE TABLE [stg].[BlackBaudFE_customFields]
(
[ETL__session_id] [uniqueidentifier] NOT NULL,
[ETL__insert_datetime] [datetime] NOT NULL CONSTRAINT [DF__BlackBaud__ETL____5EDF0F2E] DEFAULT (getutcdate()),
[ETL__multi_query_value_for_audit] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[json_payload] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsLoaded] [bit] NULL CONSTRAINT [DF__BlackBaud__IsLoa__2FEF161B] DEFAULT ((0)),
[ID] [int] NOT NULL IDENTITY(1, 1)
)
GO
