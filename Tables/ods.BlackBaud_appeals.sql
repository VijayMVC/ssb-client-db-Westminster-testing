CREATE TABLE [ods].[BlackBaud_appeals]
(
[AppealID] [int] NOT NULL,
[DateAdded] [datetime2] NULL,
[DateModified] [datetime2] NULL,
[Description] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Inactive] [bit] NULL,
[LookupID] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EndDate] [datetime2] NULL,
[StartDate] [datetime2] NULL,
[GoalValue] [float] NULL,
[ETL_CreatedOn] [datetime] NOT NULL CONSTRAINT [DF__BlackBaud__ETL_C__788BC47C] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__BlackBaud__ETL_C__797FE8B5] DEFAULT (suser_sname()),
[ETL_UpdatedOn] [datetime] NOT NULL CONSTRAINT [DF__BlackBaud__ETL_U__7A740CEE] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__BlackBaud__ETL_U__7B683127] DEFAULT (suser_sname())
)
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

----------- CREATE TRIGGER -----------
CREATE TRIGGER [ods].[Snapshot_BlackBaud_appealsUpdate] ON [ods].[BlackBaud_appeals]
AFTER UPDATE, DELETE

AS
BEGIN

DECLARE @ETL_UpdatedOn DATETIME = (SELECT [etl].[ConvertToLocalTime](CAST(GETDATE() AS DATETIME2(0))))
DECLARE @ETL_UpdatedBy NVARCHAR(400) = (SELECT SYSTEM_USER)

UPDATE t SET
[ETL_UpdatedOn] = @ETL_UpdatedOn
,[ETL_UpdatedBy] = @ETL_UpdatedBy
FROM [ods].[BlackBaud_appeals] t
	JOIN inserted i ON  t.[AppealID] = i.[AppealID]

INSERT INTO [ods].[Snapshot_BlackBaud_appeals] ([AppealID],[DateAdded],[DateModified],[Description],[Inactive],[LookupID],[EndDate],[StartDate],[GoalValue],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate])
SELECT a.*,dateadd(s,-1,@ETL_UpdatedOn)
FROM deleted a

END
GO
ALTER TABLE [ods].[BlackBaud_appeals] ADD CONSTRAINT [PK__BlackBau__BB684E10D65D54B3] PRIMARY KEY CLUSTERED  ([AppealID])
GO
