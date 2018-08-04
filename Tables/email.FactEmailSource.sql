CREATE TABLE [email].[FactEmailSource]
(
[FactEmailSourceId] [int] NOT NULL IDENTITY(-2, 1),
[DimEmailId] [int] NULL,
[SourceSystemId] [int] NULL,
[EffectiveBeginDate] [datetime] NULL,
[EffectiveEndDate] [datetime] NULL,
[CreatedBy] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL CONSTRAINT [DF__FactEmail__Creat__0F07A94F] DEFAULT (user_name()),
[CreatedDate] [datetime] NULL CONSTRAINT [DF__FactEmail__Creat__0FFBCD88] DEFAULT (getdate()),
[UpdatedBy] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL CONSTRAINT [DF__FactEmail__Updat__10EFF1C1] DEFAULT (user_name()),
[UpdatedDate] [datetime] NULL CONSTRAINT [DF__FactEmail__Updat__11E415FA] DEFAULT (getdate())
)
GO
ALTER TABLE [email].[FactEmailSource] ADD CONSTRAINT [PK__FactEmai__11CE7944E1973B1C] PRIMARY KEY CLUSTERED  ([FactEmailSourceId])
GO
CREATE NONCLUSTERED INDEX [idx_FactEmailSource_DimEmailId] ON [email].[FactEmailSource] ([DimEmailId])
GO
ALTER TABLE [email].[FactEmailSource] ADD CONSTRAINT [FK__FactEmail__DimEm__13CC5E6C] FOREIGN KEY ([DimEmailId]) REFERENCES [email].[DimEmail] ([DimEmailID])
GO
ALTER TABLE [email].[FactEmailSource] ADD CONSTRAINT [FK__FactEmail__Sourc__14C082A5] FOREIGN KEY ([SourceSystemId]) REFERENCES [mdm].[SourceSystems] ([SourceSystemID])
GO
