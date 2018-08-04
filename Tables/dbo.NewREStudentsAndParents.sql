CREATE TABLE [dbo].[NewREStudentsAndParents]
(
[SS_SSID] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SS_SSBID] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SS_CustomerType] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RE_SSID] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RE_SSBID] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[NewConstituentPost] [bit] NULL CONSTRAINT [DF__NewREStud__NewCo__6B696757] DEFAULT ((0)),
[NewEmailPost] [bit] NULL CONSTRAINT [DF__NewREStud__NewEm__6C5D8B90] DEFAULT ((0)),
[NewPhonePost] [bit] NULL CONSTRAINT [DF__NewREStud__NewPh__6D51AFC9] DEFAULT ((0)),
[NewAddressPost] [bit] NULL CONSTRAINT [DF__NewREStud__NewAd__6E45D402] DEFAULT ((0)),
[NewEducationPost] [bit] NULL CONSTRAINT [DF__NewREStud__NewEd__6F39F83B] DEFAULT ((0)),
[NewConstituentCodePost] [bit] NULL CONSTRAINT [DF__NewREStud__NewCo__702E1C74] DEFAULT ((0)),
[NewConstituentCustomFieldPost] [bit] NULL CONSTRAINT [DF__NewREStud__NewCo__712240AD] DEFAULT ((0)),
[NewRelationshipsPost] [bit] NULL CONSTRAINT [DF__NewREStud__NewRe__721664E6] DEFAULT ((0))
)
GO
