CREATE TABLE [ods].[BlackBaud_gifts_splits]
(
[giftid] [int] NOT NULL,
[FundID] [int] NOT NULL,
[CampaignID] [int] NOT NULL,
[AppealID] [int] NOT NULL,
[amount_value] [float] NULL,
[ETL_CreatedOn] [datetime] NOT NULL CONSTRAINT [DF__BlackBaud__ETL_C__3C20AE2D] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__BlackBaud__ETL_C__3D14D266] DEFAULT (suser_sname()),
[ETL_UpdatedOn] [datetime] NOT NULL CONSTRAINT [DF__BlackBaud__ETL_U__3E08F69F] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__BlackBaud__ETL_U__3EFD1AD8] DEFAULT (suser_sname())
)
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
--USE [Westminster]
--GO

--/****** Object:  Trigger [Snapshot_BlackBaud_gifts_splitsUpdate]    Script Date: 2/2/2018 2:13:58 PM ******/
--DROP TRIGGER [ods].[Snapshot_BlackBaud_gifts_splitsUpdate]
--GO

--/****** Object:  Trigger [ods].[Snapshot_BlackBaud_gifts_splitsUpdate]    Script Date: 2/2/2018 2:13:59 PM ******/
--SET ANSI_NULLS ON
--GO

--SET QUOTED_IDENTIFIER ON
--GO

----------- CREATE TRIGGER -----------
CREATE TRIGGER [ods].[Snapshot_BlackBaud_gifts_splitsUpdate] ON [ods].[BlackBaud_gifts_splits]
AFTER UPDATE, DELETE

AS
BEGIN

DECLARE @ETL_UpdatedOn DATETIME = (SELECT [etl].[ConvertToLocalTime](CAST(GETDATE() AS DATETIME2(0))))
DECLARE @ETL_UpdatedBy NVARCHAR(400) = (SELECT SYSTEM_USER)

UPDATE t SET
[ETL_UpdatedOn] = @ETL_UpdatedOn
,[ETL_UpdatedBy] = @ETL_UpdatedBy
FROM [ods].[BlackBaud_gifts_splits] t
	JOIN inserted i ON  t.[giftid] = i.[giftid] AND t.FundID = i.FundID

INSERT INTO [ods].[Snapshot_BlackBaud_gifts_splits] ([giftid],FundID,CampaignID,AppealID,amount_value,[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate])
SELECT a.*,DATEADD(s,-1,@ETL_UpdatedOn)
FROM deleted a

END

GO
ALTER TABLE [ods].[BlackBaud_gifts_splits] ADD CONSTRAINT [PK__BlackBau__988476E9B52B610C] PRIMARY KEY CLUSTERED  ([giftid], [FundID], [CampaignID], [AppealID])
GO
