CREATE TABLE [dbo].[BizRule_Issues_Logi]
(
[IssueID] [bigint] NOT NULL,
[SSID] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SourceSystem] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[BizRulePriority] [int] NULL,
[BizRuleDesc] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Name] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[KeyFieldName] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[KeyFieldValue] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ValidationFieldName] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ValidationFieldValue] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SourceFieldName] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SourceFieldValue] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Issue_OpenedOn] [datetime] NOT NULL,
[Issue_UpdatedOn] [datetime] NOT NULL,
[Logi_Approval] [bit] NULL,
[Logi_Ignore] [bit] NULL,
[BizRuleSubscriptionSK] [int] NOT NULL,
[FullName] [varchar] (600) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsTwoButton] [bit] NOT NULL CONSTRAINT [DF__BizRule_I__IsTwo__282F1F4F] DEFAULT ((0))
)
GO
