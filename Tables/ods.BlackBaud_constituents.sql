CREATE TABLE [ods].[BlackBaud_constituents]
(
[constituent_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[type] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[lookup_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[inactive] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[fullname] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[gender] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[deceased] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[date_added] [datetime2] NULL,
[date_modified] [datetime2] NULL,
[gives_anonymously] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[lastname] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[firstname] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[middlename] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[preferred_name] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[title] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[marital_status] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[age] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[suffix] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[address_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[phone_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[email_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[birthdate_year] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[birthdate_month] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[birthdate_day] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[spouse_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[online_presence_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_CreatedOn] [datetime] NOT NULL CONSTRAINT [DF__BlackBaud__ETL_C__7CE6FED2] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__BlackBaud__ETL_C__7DDB230B] DEFAULT (suser_sname()),
[ETL_UpdatedOn] [datetime] NOT NULL CONSTRAINT [DF__BlackBaud__ETL_U__7ECF4744] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__BlackBaud__ETL_U__7FC36B7D] DEFAULT (suser_sname())
)
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

----------- CREATE TRIGGER -----------
CREATE TRIGGER [ods].[Snapshot_BlackBaud_constituentsUpdate] ON [ods].[BlackBaud_constituents]
AFTER UPDATE, DELETE

AS
BEGIN

DECLARE @ETL_UpdatedOn DATETIME = (SELECT [etl].[ConvertToLocalTime](CAST(GETDATE() AS DATETIME2(0))))
DECLARE @ETL_UpdatedBy NVARCHAR(400) = (SELECT SYSTEM_USER)

UPDATE t SET
[ETL_UpdatedOn] = @ETL_UpdatedOn
,[ETL_UpdatedBy] = @ETL_UpdatedBy
FROM [ods].[BlackBaud_constituents] t
	JOIN inserted i ON  t.[constituent_id] = i.[constituent_id]

INSERT INTO [ods].[Snapshot_BlackBaud_constituents] ([constituent_id],[type],[lookup_id],[inactive],[fullname],[gender],[deceased],[date_added],[date_modified],[gives_anonymously],[lastname],[firstname],[middlename],[preferred_name],[title],[marital_status],[age],[suffix],[address_id],[phone_id],[email_id],[birthdate_year],[birthdate_month],[birthdate_day],[spouse_id],[online_presence_id],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate])
SELECT a.*,dateadd(s,-1,@ETL_UpdatedOn)
FROM deleted a

END
GO
ALTER TABLE [ods].[BlackBaud_constituents] ADD CONSTRAINT [PK__BlackBau__3CF5BE40919E13F2] PRIMARY KEY CLUSTERED  ([constituent_id])
GO
