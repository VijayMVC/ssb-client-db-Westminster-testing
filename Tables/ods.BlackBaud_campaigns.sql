CREATE TABLE [ods].[BlackBaud_campaigns]
(
[CampaignID] [int] NOT NULL,
[DateAdded] [datetime2] NULL,
[DateModified] [datetime2] NULL,
[Description] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Inactive] [bit] NULL,
[lookupID] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[StartDate] [datetime2] NULL,
[GoalValue] [float] NULL,
[ETL_CreatedOn] [datetime] NOT NULL CONSTRAINT [DF__BlackBaud__ETL_C__5DD7CE40] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__BlackBaud__ETL_C__5ECBF279] DEFAULT (suser_sname()),
[ETL_UpdatedOn] [datetime] NOT NULL CONSTRAINT [DF__BlackBaud__ETL_U__5FC016B2] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__BlackBaud__ETL_U__60B43AEB] DEFAULT (suser_sname())
)
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

----------- CREATE TRIGGER -----------
CREATE TRIGGER [ods].[Snapshot_BlackBaud_campaignsUpdate] ON [ods].[BlackBaud_campaigns]
AFTER UPDATE, DELETE

AS
BEGIN

DECLARE @ETL_UpdatedOn DATETIME = (SELECT [etl].[ConvertToLocalTime](CAST(GETDATE() AS DATETIME2(0))))
DECLARE @ETL_UpdatedBy NVARCHAR(400) = (SELECT SYSTEM_USER)

UPDATE t SET
[ETL_UpdatedOn] = @ETL_UpdatedOn
,[ETL_UpdatedBy] = @ETL_UpdatedBy
FROM [ods].[BlackBaud_campaigns] t
	JOIN inserted i ON  t.[CampaignID] = i.[CampaignID]

INSERT INTO [ods].[Snapshot_BlackBaud_campaigns] ([CampaignID],[DateAdded],[DateModified],[Description],[Inactive],[lookupID],[StartDate],[GoalValue],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate])
SELECT a.*,dateadd(s,-1,@ETL_UpdatedOn)
FROM deleted a

END
GO
ALTER TABLE [ods].[BlackBaud_campaigns] ADD CONSTRAINT [PK__BlackBau__D3DF5FDAAC155CFF] PRIMARY KEY CLUSTERED  ([CampaignID])
GO
