CREATE TABLE [ods].[BlackBaud_phones]
(
[Phoneid] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[constituent_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[type] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[number] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[do_not_call] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[primary] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[inactive] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[date_added] [datetime2] NULL,
[date_modified] [datetime2] NULL,
[ETL_CreatedOn] [datetime] NOT NULL CONSTRAINT [DF__BlackBaud__ETL_C__69D4F5B5] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__BlackBaud__ETL_C__6AC919EE] DEFAULT (suser_sname()),
[ETL_UpdatedOn] [datetime] NOT NULL CONSTRAINT [DF__BlackBaud__ETL_U__6BBD3E27] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__BlackBaud__ETL_U__6CB16260] DEFAULT (suser_sname())
)
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

----------- CREATE TRIGGER -----------
CREATE TRIGGER [ods].[Snapshot_BlackBaud_phonesUpdate] ON [ods].[BlackBaud_phones]
AFTER UPDATE, DELETE

AS
BEGIN

DECLARE @ETL_UpdatedOn DATETIME = (SELECT [etl].[ConvertToLocalTime](CAST(GETDATE() AS DATETIME2(0))))
DECLARE @ETL_UpdatedBy NVARCHAR(400) = (SELECT SYSTEM_USER)

UPDATE t SET
[ETL_UpdatedOn] = @ETL_UpdatedOn
,[ETL_UpdatedBy] = @ETL_UpdatedBy
FROM [ods].[BlackBaud_phones] t
	JOIN inserted i ON  t.[Phoneid] = i.[Phoneid]

INSERT INTO [ods].[Snapshot_BlackBaud_phones] ([Phoneid],[constituent_id],[type],[number],[do_not_call],[primary],[inactive],[date_added],[date_modified],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate])
SELECT a.*,dateadd(s,-1,@ETL_UpdatedOn)
FROM deleted a

END
GO
ALTER TABLE [ods].[BlackBaud_phones] ADD CONSTRAINT [PK__BlackBau__F21137281EA32569] PRIMARY KEY CLUSTERED  ([Phoneid])
GO
