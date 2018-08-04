CREATE TABLE [ods].[BlackBaud_ratings]
(
[RatingID] [int] NOT NULL,
[RatingCategory] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RatingComment] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Constituent_ID] [int] NULL,
[RatingDate] [datetime2] NULL,
[Inactive] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RatingSource] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RatingType] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RatingValue] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_CreatedOn] [datetime] NOT NULL CONSTRAINT [DF__BlackBaud__ETL_C__3E95F589] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__BlackBaud__ETL_C__3F8A19C2] DEFAULT (suser_sname()),
[ETL_UpdatedOn] [datetime] NOT NULL CONSTRAINT [DF__BlackBaud__ETL_U__407E3DFB] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__BlackBaud__ETL_U__41726234] DEFAULT (suser_sname())
)
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

----------- CREATE TRIGGER -----------
CREATE TRIGGER [ods].[Snapshot_BlackBaud_ratingsUpdate] ON [ods].[BlackBaud_ratings]
AFTER UPDATE, DELETE

AS
BEGIN

DECLARE @ETL_UpdatedOn DATETIME = (SELECT [etl].[ConvertToLocalTime](CAST(GETDATE() AS DATETIME2(0))))
DECLARE @ETL_UpdatedBy NVARCHAR(400) = (SELECT SYSTEM_USER)

UPDATE t SET
[ETL_UpdatedOn] = @ETL_UpdatedOn
,[ETL_UpdatedBy] = @ETL_UpdatedBy
FROM [ods].[BlackBaud_ratings] t
	JOIN inserted i ON  t.[RatingID] = i.[RatingID]

INSERT INTO [ods].[Snapshot_BlackBaud_ratings] ([RatingID],[RatingCategory],[RatingComment],[Constituent_ID],[RatingDate],[Inactive],[RatingSource],[RatingType],[RatingValue],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate])
SELECT a.*,dateadd(s,-1,@ETL_UpdatedOn)
FROM deleted a

END
GO
ALTER TABLE [ods].[BlackBaud_ratings] ADD CONSTRAINT [PK__BlackBau__FCCDF85CA56DD7C3] PRIMARY KEY CLUSTERED  ([RatingID])
GO
