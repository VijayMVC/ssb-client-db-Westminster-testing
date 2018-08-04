CREATE TABLE [ods].[SeniorSystems_facultySectionsByEntityNo]
(
[EntityNo] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[FacultyHierarcy] [int] NOT NULL,
[SectionID] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[CurrentYear] [int] NULL,
[ETL_CreatedOn] [datetime] NOT NULL CONSTRAINT [DF__SeniorSys__ETL_C__777772E8] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__SeniorSys__ETL_C__786B9721] DEFAULT (suser_sname()),
[ETL_UpdatedOn] [datetime] NOT NULL CONSTRAINT [DF__SeniorSys__ETL_U__795FBB5A] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__SeniorSys__ETL_U__7A53DF93] DEFAULT (suser_sname())
)
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

----------- CREATE TRIGGER -----------
CREATE TRIGGER [ods].[Snapshot_SeniorSystems_facultySectionsByEntityNoUpdate] ON [ods].[SeniorSystems_facultySectionsByEntityNo]
AFTER UPDATE, DELETE

AS
BEGIN

DECLARE @ETL_UpdatedOn DATETIME = (SELECT [etl].[ConvertToLocalTime](CAST(GETDATE() AS DATETIME2(0))))
DECLARE @ETL_UpdatedBy NVARCHAR(400) = (SELECT SYSTEM_USER)

UPDATE t SET
[ETL_UpdatedOn] = @ETL_UpdatedOn
,[ETL_UpdatedBy] = @ETL_UpdatedBy
FROM [ods].[SeniorSystems_facultySectionsByEntityNo] t
	JOIN inserted i ON  t.[EntityNo] = i.[EntityNo] AND t.[FacultyHierarcy] = i.[FacultyHierarcy] AND t.[SectionID] = i.[SectionID]

INSERT INTO [ods].[Snapshot_SeniorSystems_facultySectionsByEntityNo] ([EntityNo],[FacultyHierarcy],[SectionID],[CurrentYear],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate])
SELECT a.*,dateadd(s,-1,@ETL_UpdatedOn)
FROM deleted a

END
GO
ALTER TABLE [ods].[SeniorSystems_facultySectionsByEntityNo] ADD CONSTRAINT [PK__SeniorSy__7BBD16304C9024F4] PRIMARY KEY CLUSTERED  ([EntityNo], [FacultyHierarcy], [SectionID])
GO
