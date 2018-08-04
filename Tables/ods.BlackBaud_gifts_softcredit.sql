CREATE TABLE [ods].[BlackBaud_gifts_softcredit]
(
[giftid] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[soft-credits_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[soft-credits_constituent-id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[soft-credits_gift-id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[soft-credits_amount_value] [float] NULL,
[ETL_CreatedOn] [datetime] NOT NULL CONSTRAINT [DF__BlackBaud__ETL_C__329743F3] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__BlackBaud__ETL_C__338B682C] DEFAULT (suser_sname()),
[ETL_UpdatedOn] [datetime] NOT NULL CONSTRAINT [DF__BlackBaud__ETL_U__347F8C65] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__BlackBaud__ETL_U__3573B09E] DEFAULT (suser_sname())
)
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

----------- CREATE TRIGGER -----------
CREATE TRIGGER [ods].[Snapshot_BlackBaud_gifts_softcreditUpdate] ON [ods].[BlackBaud_gifts_softcredit]
AFTER UPDATE, DELETE

AS
BEGIN

DECLARE @ETL_UpdatedOn DATETIME = (SELECT [etl].[ConvertToLocalTime](CAST(GETDATE() AS DATETIME2(0))))
DECLARE @ETL_UpdatedBy NVARCHAR(400) = (SELECT SYSTEM_USER)

UPDATE t SET
[ETL_UpdatedOn] = @ETL_UpdatedOn
,[ETL_UpdatedBy] = @ETL_UpdatedBy
FROM [ods].[BlackBaud_gifts_softcredit] t
	JOIN inserted i ON  t.[giftid] = i.[giftid] AND t.[soft-credits_id] = i.[soft-credits_id]

INSERT INTO [ods].[Snapshot_BlackBaud_gifts_softcredit] ([giftid],[soft-credits_id],[soft-credits_constituent-id],[soft-credits_gift-id],[soft-credits_amount_value],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate])
SELECT a.*,dateadd(s,-1,@ETL_UpdatedOn)
FROM deleted a

END
GO
ALTER TABLE [ods].[BlackBaud_gifts_softcredit] ADD CONSTRAINT [PK__BlackBau__DD65AF16A0C96264] PRIMARY KEY CLUSTERED  ([giftid], [soft-credits_id])
GO
