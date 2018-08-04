CREATE TABLE [etl].[API_IDs_Queue]
(
[QueueID] [int] NOT NULL IDENTITY(1, 1),
[APIName] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[APIEntity] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[EndpointName] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SourceID] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[IsCompleted] [bit] NOT NULL CONSTRAINT [DF__API_IDs_Q__IsCom__51DDD427] DEFAULT ((0)),
[Queue_CreatedOn] [datetime] NOT NULL CONSTRAINT [DF__API_IDs_Q__Queue__52D1F860] DEFAULT (getdate())
)
GO
