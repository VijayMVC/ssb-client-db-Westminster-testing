CREATE TABLE [dbo].[BizRule_Security]
(
[BizRuleSecuritySK] [int] NOT NULL IDENTITY(1, 1),
[BizRuleSubscriptionSK] [int] NOT NULL,
[PortalRoleID] [int] NOT NULL
)
GO
ALTER TABLE [dbo].[BizRule_Security] ADD CONSTRAINT [PK__BizRule___security] PRIMARY KEY CLUSTERED  ([BizRuleSecuritySK])
GO
ALTER TABLE [dbo].[BizRule_Security] ADD CONSTRAINT [FK_BizRule_Security_role] FOREIGN KEY ([PortalRoleID]) REFERENCES [dbo].[WestminsterSchools_Orchard_Roles_RoleRecord] ([Id])
GO
ALTER TABLE [dbo].[BizRule_Security] ADD CONSTRAINT [FK_BizRule_Security_Subscript] FOREIGN KEY ([BizRuleSubscriptionSK]) REFERENCES [dbo].[BizRule_Subscription] ([BizRuleSubscriptionSK])
GO
