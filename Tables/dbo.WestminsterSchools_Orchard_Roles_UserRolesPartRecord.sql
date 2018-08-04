CREATE TABLE [dbo].[WestminsterSchools_Orchard_Roles_UserRolesPartRecord]
(
[Id] [int] NOT NULL,
[UserId] [int] NULL,
[Role_id] [int] NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
ALTER TABLE [dbo].[WestminsterSchools_Orchard_Roles_UserRolesPartRecord] ADD CONSTRAINT [PK__Westmins__3214EC07D004E268] PRIMARY KEY CLUSTERED  ([Id])
GO
