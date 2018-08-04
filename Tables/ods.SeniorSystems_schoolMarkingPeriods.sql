CREATE TABLE [ods].[SeniorSystems_schoolMarkingPeriods]
(
[Name] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[TermID] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Abbreviation] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SchoolID] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CurrentYear] [int] NOT NULL,
[ETL_CreatedOn] [datetime] NOT NULL CONSTRAINT [DF__SeniorSys__ETL_C__0215C843] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__SeniorSys__ETL_C__0309EC7C] DEFAULT (suser_sname()),
[ETL_UpdatedOn] [datetime] NOT NULL CONSTRAINT [DF__SeniorSys__ETL_U__03FE10B5] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__SeniorSys__ETL_U__04F234EE] DEFAULT (suser_sname())
)
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

----------- CREATE TRIGGER -----------
CREATE TRIGGER [ods].[Snapshot_SeniorSystems_schoolMarkingPeriodsUpdate] ON [ods].[SeniorSystems_schoolMarkingPeriods]
AFTER UPDATE, DELETE

AS
BEGIN

DECLARE @ETL_UpdatedOn DATETIME = (SELECT [etl].[ConvertToLocalTime](CAST(GETDATE() AS DATETIME2(0))))
DECLARE @ETL_UpdatedBy NVARCHAR(400) = (SELECT SYSTEM_USER)

UPDATE t SET
[ETL_UpdatedOn] = @ETL_UpdatedOn
,[ETL_UpdatedBy] = @ETL_UpdatedBy
FROM [ods].[SeniorSystems_schoolMarkingPeriods] t
	JOIN inserted i ON  t.[Name] = i.[Name] AND t.[TermID] = i.[TermID] AND t.[SchoolID] = i.[SchoolID] AND t.[CurrentYear] = i.[CurrentYear]

INSERT INTO [ods].[Snapshot_SeniorSystems_schoolMarkingPeriods] ([Name],[TermID],[Abbreviation],[SchoolID],[CurrentYear],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate])
SELECT a.*,dateadd(s,-1,@ETL_UpdatedOn)
FROM deleted a

END
GO
ALTER TABLE [ods].[SeniorSystems_schoolMarkingPeriods] ADD CONSTRAINT [PK__SeniorSy__A30482AD7202B21F] PRIMARY KEY CLUSTERED  ([Name], [TermID], [SchoolID], [CurrentYear])
GO
