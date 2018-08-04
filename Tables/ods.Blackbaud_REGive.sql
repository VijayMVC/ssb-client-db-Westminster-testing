CREATE TABLE [ods].[Blackbaud_REGive]
(
[SessionId] [uniqueidentifier] NULL,
[RecordCreateDate] [datetime] NOT NULL CONSTRAINT [DF__UploadREG__Recor__41F18521] DEFAULT (getutcdate()),
[Processed] [bit] NOT NULL CONSTRAINT [DF__UploadREG__Proce__42E5A95A] DEFAULT ((0)),
[Bio_ID] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Current_Year_Cash_Pledge_Bal] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Current_WF_Year] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Prior_WF_Year] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[2_Years_Prior_WF] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[3_Year_Prior_WF] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[4_Years_Prior_WF] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[5_Years_Prior_WF] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Prior_Year_Cap_Cash] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[2_Years_Prior_Cap_Cash] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[3_Years_Prior_Cap_Cash] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[4_Years_Prior_Cap_Cash] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[5_Years_Prior_Cap_Cash] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[6_Years_Prior_Cap_Cash] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Lifetime_Giving] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Capital_Cash_(last_10_years)] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Current_Fiscal_Year] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
