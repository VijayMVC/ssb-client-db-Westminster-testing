CREATE TABLE [dbo].[WestminsterSchools_Orchard_Users_UserPartRecord]
(
[Id] [int] NOT NULL,
[UserName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Email] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[NormalizedUserName] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Password] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PasswordFormat] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[HashAlgorithm] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PasswordSalt] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RegistrationStatus] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EmailStatus] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EmailChallengeToken] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CreatedUtc] [datetime] NULL,
[LastLoginUtc] [datetime] NULL,
[LastLogoutUtc] [datetime] NULL,
[ETL_Sync_DeltaHashKey] [binary] (32) NULL
)
GO
ALTER TABLE [dbo].[WestminsterSchools_Orchard_Users_UserPartRecord] ADD CONSTRAINT [PK__Westmins__3214EC079548A261] PRIMARY KEY CLUSTERED  ([Id])
GO
