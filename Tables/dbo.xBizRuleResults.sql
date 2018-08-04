CREATE TABLE [dbo].[xBizRuleResults]
(
[BatchSK] [int] NOT NULL,
[BizRuleSK] [int] NOT NULL,
[Result] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Updated_DTM] [datetime] NOT NULL,
[HasChanged] [bit] NULL
)
GO
ALTER TABLE [dbo].[xBizRuleResults] ADD CONSTRAINT [PK_BizRuleResults] PRIMARY KEY CLUSTERED  ([BatchSK], [BizRuleSK])
GO
ALTER TABLE [dbo].[xBizRuleResults] ADD CONSTRAINT [fk_BizRuleResults_HeaderSK] FOREIGN KEY ([BizRuleSK]) REFERENCES [dbo].[BizRule_Header] ([BizRuleSK])
GO
