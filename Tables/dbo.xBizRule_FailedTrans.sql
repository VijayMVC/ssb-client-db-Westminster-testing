CREATE TABLE [dbo].[xBizRule_FailedTrans]
(
[SSID] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SourceSystem] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[BatchSK] [int] NOT NULL,
[BizRuleSK] [int] NOT NULL,
[BizRuleSubscriptionSK] [int] NOT NULL CONSTRAINT [DF_BizRule_FailedTrans_BizRuleSubscriptionSK] DEFAULT ((-1))
)
GO
ALTER TABLE [dbo].[xBizRule_FailedTrans] ADD CONSTRAINT [PK_BizRule_FailedTrans] PRIMARY KEY CLUSTERED  ([SSID], [SourceSystem], [BatchSK], [BizRuleSK], [BizRuleSubscriptionSK])
GO
ALTER TABLE [dbo].[xBizRule_FailedTrans] ADD CONSTRAINT [fk_BizRuleFailedTrans_HeaderSK] FOREIGN KEY ([BizRuleSK]) REFERENCES [dbo].[BizRule_Header] ([BizRuleSK])
GO
