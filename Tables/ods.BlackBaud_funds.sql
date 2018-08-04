CREATE TABLE [ods].[BlackBaud_funds]
(
[FundID] [int] NOT NULL,
[DateAdded] [datetime2] NULL,
[DateModified] [datetime2] NULL,
[Description] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Inactive] [bit] NULL,
[LookupID] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[StartDate] [datetime2] NULL,
[Category] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EndDate] [datetime2] NULL,
[GoalValue] [float] NULL,
[ETL_CreatedOn] [datetime] NOT NULL CONSTRAINT [DF__BlackBaud__ETL_C__09B6507E] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__BlackBaud__ETL_C__0AAA74B7] DEFAULT (suser_sname()),
[ETL_UpdatedOn] [datetime] NOT NULL CONSTRAINT [DF__BlackBaud__ETL_U__0B9E98F0] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__BlackBaud__ETL_U__0C92BD29] DEFAULT (suser_sname())
)
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

----------- CREATE TRIGGER -----------
CREATE TRIGGER [ods].[Snapshot_BlackBaud_fundsUpdate] ON [ods].[BlackBaud_funds]
AFTER UPDATE, DELETE

AS
BEGIN

DECLARE @ETL_UpdatedOn DATETIME = (SELECT [etl].[ConvertToLocalTime](CAST(GETDATE() AS DATETIME2(0))))
DECLARE @ETL_UpdatedBy NVARCHAR(400) = (SELECT SYSTEM_USER)

UPDATE t SET
[ETL_UpdatedOn] = @ETL_UpdatedOn
,[ETL_UpdatedBy] = @ETL_UpdatedBy
FROM [ods].[BlackBaud_funds] t
	JOIN inserted i ON  t.[FundID] = i.[FundID]

INSERT INTO [ods].[Snapshot_BlackBaud_funds] ([FundID],[DateAdded],[DateModified],[Description],[Inactive],[LookupID],[StartDate],[Category],[EndDate],[GoalValue],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate])
SELECT a.*,dateadd(s,-1,@ETL_UpdatedOn)
FROM deleted a

END
GO
ALTER TABLE [ods].[BlackBaud_funds] ADD CONSTRAINT [PK__BlackBau__830DFC7A1042FDF7] PRIMARY KEY CLUSTERED  ([FundID])
GO
