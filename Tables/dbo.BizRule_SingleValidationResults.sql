CREATE TABLE [dbo].[BizRule_SingleValidationResults]
(
[SSID] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SourceSystem] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BizRuleSK] [int] NULL,
[BizRuleSubscriptionSK] [int] NULL,
[Result] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[OtherID] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Constituent_ID] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EntityNo] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UID] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FieldHash] [binary] (32) NULL
)
GO
