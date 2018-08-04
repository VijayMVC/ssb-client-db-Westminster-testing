CREATE TABLE [ods].[Schoology_gradingperiods]
(
[gradingperiod_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[title] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[start] [date] NULL,
[end] [date] NULL,
[active] [bit] NULL,
[has_children] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[parentid] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_CreatedOn] [datetime] NOT NULL CONSTRAINT [DF__Schoology__ETL_C__073D7403] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__Schoology__ETL_C__0831983C] DEFAULT (suser_sname()),
[ETL_UpdatedOn] [datetime] NOT NULL CONSTRAINT [DF__Schoology__ETL_U__0925BC75] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__Schoology__ETL_U__0A19E0AE] DEFAULT (suser_sname())
)
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

----------- CREATE TRIGGER -----------
CREATE TRIGGER [ods].[Snapshot_Schoology_gradingperiodsUpdate] ON [ods].[Schoology_gradingperiods]
AFTER UPDATE, DELETE

AS
BEGIN

DECLARE @ETL_UpdatedOn DATETIME = (SELECT [etl].[ConvertToLocalTime](CAST(GETDATE() AS DATETIME2(0))))
DECLARE @ETL_UpdatedBy NVARCHAR(400) = (SELECT SYSTEM_USER)

UPDATE t SET
[ETL_UpdatedOn] = @ETL_UpdatedOn
,[ETL_UpdatedBy] = @ETL_UpdatedBy
FROM [ods].[Schoology_gradingperiods] t
	JOIN inserted i ON  t.[gradingperiod_id] = i.[gradingperiod_id]

INSERT INTO [ods].[Snapshot_Schoology_gradingperiods] ([gradingperiod_id],[title],[start],[end],[active],[has_children],[parentid],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate])
SELECT a.*,dateadd(s,-1,@ETL_UpdatedOn)
FROM deleted a

END
GO
ALTER TABLE [ods].[Schoology_gradingperiods] ADD CONSTRAINT [PK__Schoolog__BBE33CDE72EB6FBB] PRIMARY KEY CLUSTERED  ([gradingperiod_id])
GO
