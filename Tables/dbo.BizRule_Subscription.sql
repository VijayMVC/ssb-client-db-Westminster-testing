CREATE TABLE [dbo].[BizRule_Subscription]
(
[BizRuleSubscriptionSK] [int] NOT NULL IDENTITY(1, 1),
[BizRuleSK] [int] NULL,
[Name] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[FullDescription] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SourceSystem] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TableName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[KeyFieldName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ValidationFieldName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SourceTableName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SourceKeyFieldName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SourceFieldName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ExpectedResult] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Type] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsDimcustomer] [bit] NOT NULL,
[IsActive] [bit] NULL,
[ToleranceLevel] [decimal] (16, 2) NULL,
[RequiresReview] [bit] NOT NULL,
[OtherID] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SourceOtherID] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[OutputProcedure] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PriorityOrder] [tinyint] NULL,
[QueueProcedure] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsOutboundRule] [bit] NOT NULL CONSTRAINT [DF__BizRule_S__Outbo__66BC8A9B] DEFAULT ((0))
)
GO
ALTER TABLE [dbo].[BizRule_Subscription] ADD CONSTRAINT [PK__BizRule___85F33B152C9D5E94] PRIMARY KEY CLUSTERED  ([BizRuleSubscriptionSK])
GO
ALTER TABLE [dbo].[BizRule_Subscription] ADD CONSTRAINT [FK_BizRule_Subscription_BizRule_Header] FOREIGN KEY ([BizRuleSK]) REFERENCES [dbo].[BizRule_Header] ([BizRuleSK])
GO
