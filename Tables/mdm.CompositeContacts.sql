CREATE TABLE [mdm].[CompositeContacts]
(
[SSB_CRMSYSTEM_CONTACT_ID] [uniqueidentifier] NOT NULL CONSTRAINT [DF_CompositeContacts_compositecontact_id] DEFAULT (newid()),
[nameaddr_id] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[nameemail_id] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[namephone_id] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[cc_id] [int] NOT NULL IDENTITY(1, 1),
[ExtAttribute10_ID] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Dual_Address_ID] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FirstLastBirthID] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FuzzyNameBirth_ID] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PrefLastAdd_ID] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
ALTER TABLE [mdm].[CompositeContacts] ADD CONSTRAINT [PK_CompositeContacts] PRIMARY KEY NONCLUSTERED  ([cc_id])
GO
CREATE NONCLUSTERED INDEX [IX_CompositeContacts_Dual_Address_ID] ON [mdm].[CompositeContacts] ([Dual_Address_ID]) INCLUDE ([SSB_CRMSYSTEM_CONTACT_ID])
GO
CREATE NONCLUSTERED INDEX [IX_CompositeContacts_ExtAttribute10_ID] ON [mdm].[CompositeContacts] ([ExtAttribute10_ID]) INCLUDE ([SSB_CRMSYSTEM_CONTACT_ID])
GO
CREATE NONCLUSTERED INDEX [IX_CompositeContacts_FirstLastBirthID] ON [mdm].[CompositeContacts] ([FirstLastBirthID]) INCLUDE ([SSB_CRMSYSTEM_CONTACT_ID])
GO
CREATE NONCLUSTERED INDEX [IX_CompositeContacts_FuzzyNameBirth_ID] ON [mdm].[CompositeContacts] ([FuzzyNameBirth_ID]) INCLUDE ([SSB_CRMSYSTEM_CONTACT_ID])
GO
CREATE NONCLUSTERED INDEX [IX_CompositeContacts_NameAddr] ON [mdm].[CompositeContacts] ([nameaddr_id]) INCLUDE ([SSB_CRMSYSTEM_CONTACT_ID])
GO
CREATE NONCLUSTERED INDEX [IX_CompositeContacts_NameEmail] ON [mdm].[CompositeContacts] ([nameemail_id]) INCLUDE ([SSB_CRMSYSTEM_CONTACT_ID])
GO
CREATE NONCLUSTERED INDEX [IX_CompositeContacts_NamePhone] ON [mdm].[CompositeContacts] ([namephone_id]) INCLUDE ([SSB_CRMSYSTEM_CONTACT_ID])
GO
CREATE NONCLUSTERED INDEX [IX_CompositeContacts_PrefLastAdd_ID] ON [mdm].[CompositeContacts] ([PrefLastAdd_ID]) INCLUDE ([SSB_CRMSYSTEM_CONTACT_ID])
GO
CREATE CLUSTERED INDEX [IX_CompositeContacts] ON [mdm].[CompositeContacts] ([SSB_CRMSYSTEM_CONTACT_ID])
GO
