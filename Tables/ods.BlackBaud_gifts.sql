CREATE TABLE [ods].[BlackBaud_gifts]
(
[giftid] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[date] [datetime2] NULL,
[date_added] [datetime2] NULL,
[date_modified] [datetime2] NULL,
[type] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[constituent_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[is_anonymous] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[post_status] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[gift_status] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[reference] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[post_date] [datetime2] NULL,
[subtype] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[amount_value] [float] NULL,
[ETL_CreatedOn] [datetime] NOT NULL CONSTRAINT [DF__BlackBaud__ETL_C__6F2D1101] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__BlackBaud__ETL_C__7021353A] DEFAULT (suser_sname()),
[ETL_UpdatedOn] [datetime] NOT NULL CONSTRAINT [DF__BlackBaud__ETL_U__71155973] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__BlackBaud__ETL_U__72097DAC] DEFAULT (suser_sname())
)
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

----------- CREATE TRIGGER -----------
CREATE TRIGGER [ods].[Snapshot_BlackBaud_giftsUpdate] ON [ods].[BlackBaud_gifts]
AFTER UPDATE, DELETE

AS
BEGIN

DECLARE @ETL_UpdatedOn DATETIME = (SELECT [etl].[ConvertToLocalTime](CAST(GETDATE() AS DATETIME2(0))))
DECLARE @ETL_UpdatedBy NVARCHAR(400) = (SELECT SYSTEM_USER)

UPDATE t SET
[ETL_UpdatedOn] = @ETL_UpdatedOn
,[ETL_UpdatedBy] = @ETL_UpdatedBy
FROM [ods].[BlackBaud_gifts] t
	JOIN inserted i ON  t.[giftid] = i.[giftid]

INSERT INTO [ods].[Snapshot_BlackBaud_gifts] ([giftid],[date],[date_added],[date_modified],[type],[constituent_id],[is_anonymous],[post_status],[gift_status],[reference],[post_date],[subtype],[amount_value],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate])
SELECT a.*,dateadd(s,-1,@ETL_UpdatedOn)
FROM deleted a

END
GO
ALTER TABLE [ods].[BlackBaud_gifts] ADD CONSTRAINT [PK__BlackBau__06BC013F0949FE13] PRIMARY KEY CLUSTERED  ([giftid])
GO
