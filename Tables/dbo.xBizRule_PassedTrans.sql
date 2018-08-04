CREATE TABLE [dbo].[xBizRule_PassedTrans]
(
[SSID] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SourceSystem] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[BatchSK] [int] NOT NULL,
[BizRuleSK] [int] NOT NULL,
[BizRuleSubscriptionSK] [int] NOT NULL
)
GO
ALTER TABLE [dbo].[xBizRule_PassedTrans] ADD CONSTRAINT [PK__BizRule___32151C6130F15B80] PRIMARY KEY CLUSTERED  ([SSID], [SourceSystem], [BatchSK], [BizRuleSK], [BizRuleSubscriptionSK])
GO
ALTER TABLE [dbo].[xBizRule_PassedTrans] ADD CONSTRAINT [fk_BizRulePassedTrans_HeaderSK] FOREIGN KEY ([BizRuleSK]) REFERENCES [dbo].[BizRule_Header] ([BizRuleSK])
GO
