CREATE TABLE [rpt].[BusinessRulesBucketsOutput]
(
[ID] [int] NOT NULL IDENTITY(1, 1),
[SSB_CRMSYSTEM_CONTACT_ID] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BusinessRule] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BR_Count] [int] NULL,
[BR_Weight] [float] NULL,
[AsOfDate] [datetime] NULL
)
GO
