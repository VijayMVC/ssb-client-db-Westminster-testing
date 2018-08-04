CREATE TABLE [dbo].[BizRule_Issues_Snapshot]
(
[IssueID] [bigint] NOT NULL,
[SSID] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SourceSystem] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[BizRuleSK] [int] NOT NULL,
[BizRuleSubscriptionSK] [int] NOT NULL,
[IssueIsApproved] [bit] NOT NULL,
[IssueIsIgnore] [bit] NOT NULL,
[IssueIsCompleted] [bit] NOT NULL,
[Issue_OpenedOn] [datetime] NOT NULL,
[Issue_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Issue_UpdatedOn] [datetime] NOT NULL,
[Issue_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Constituent_ID] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EntityNo] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UID] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[OtherID] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SourceOtherID] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FieldHash] [binary] (32) NULL,
[unichk] [uniqueidentifier] NOT NULL,
[InsertDate] [datetime] NOT NULL CONSTRAINT [DF__BizRule_I__Inser__4A9F6EDA] DEFAULT (getdate())
)
GO
