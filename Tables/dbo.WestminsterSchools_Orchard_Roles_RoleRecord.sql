CREATE TABLE [dbo].[WestminsterSchools_Orchard_Roles_RoleRecord]
(
[Id] [int] NOT NULL,
[Name] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
ALTER TABLE [dbo].[WestminsterSchools_Orchard_Roles_RoleRecord] ADD CONSTRAINT [PK__Westmins__3214EC073B2FE3FF] PRIMARY KEY CLUSTERED  ([Id])
GO
