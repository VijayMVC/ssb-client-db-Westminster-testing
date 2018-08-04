CREATE TABLE [dbo].[API_OutboundQueue_Test_20180607]
(
[QueueID] [bigint] NOT NULL IDENTITY(1, 1),
[APIName] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[APIEntity] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[EndpointName] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SourceID] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Json_Payload] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[httpAction] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Description] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsCompleted] [bit] NOT NULL,
[IsVerified] [bit] NOT NULL,
[IsAttempted] [int] NULL,
[OutcomeMessage] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Queue_ProcessDate] [datetime] NULL,
[Queue_CreatedOn] [datetime] NOT NULL,
[Queue_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Queue_UpdatedOn] [datetime] NOT NULL,
[Queue_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[IssueID] [bigint] NULL
)
GO
