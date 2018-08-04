CREATE TYPE [dbo].[UploadTestFileStaging_Type] AS TABLE
(
[SessionId] [uniqueidentifier] NULL,
[DynamicData] [xml] NULL,
[Name] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Email] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FiscalPeriod] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
