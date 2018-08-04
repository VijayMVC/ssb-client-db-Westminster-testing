CREATE TABLE [api].[UploadTestFileStaging]
(
[SessionId] [uniqueidentifier] NULL,
[RecordCreateDate] [datetime] NULL CONSTRAINT [DF__UploadTestFileStaging__RecordCreateDate] DEFAULT (getdate()),
[Processed] [bit] NULL CONSTRAINT [DF__UploadTestFileStaging__Processed] DEFAULT ((0)),
[DynamicData] [xml] NULL,
[Name] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Email] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsDeleted] [bit] NULL CONSTRAINT [DF__UploadTestFileStaging__IsDeleted] DEFAULT ((0)),
[FiscalPeriod] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
