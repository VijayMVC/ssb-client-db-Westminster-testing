CREATE TABLE [dbo].[BizRule_Header]
(
[BizRuleSK] [int] NOT NULL IDENTITY(1, 1),
[Name] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[FullDescription] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ProcName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SortOrder] [int] NOT NULL,
[IsActive] [bit] NULL,
[IsMultiSubRule] [bit] NOT NULL CONSTRAINT [DF__BizRule_H__IsMul__2A1CC558] DEFAULT ((0))
)
GO
ALTER TABLE [dbo].[BizRule_Header] ADD CONSTRAINT [PK__BizRule___B9FC93D75E3747C7] PRIMARY KEY CLUSTERED  ([BizRuleSK])
GO
ALTER TABLE [dbo].[BizRule_Header] ADD CONSTRAINT [uk_SortOrder_BizRules] UNIQUE NONCLUSTERED  ([SortOrder])
GO
