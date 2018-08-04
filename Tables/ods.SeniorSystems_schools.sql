CREATE TABLE [ods].[SeniorSystems_schools]
(
[SchoolID] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SchoolName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsAcademicSchool] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsSummerSchool] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CurrentAcademicYear] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_CreatedOn] [datetime] NOT NULL CONSTRAINT [DF__SeniorSys__ETL_C__1DD7242C] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__SeniorSys__ETL_C__1ECB4865] DEFAULT (suser_sname()),
[ETL_UpdatedOn] [datetime] NOT NULL CONSTRAINT [DF__SeniorSys__ETL_U__1FBF6C9E] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__SeniorSys__ETL_U__20B390D7] DEFAULT (suser_sname())
)
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

----------- CREATE TRIGGER -----------
CREATE TRIGGER [ods].[Snapshot_SeniorSystems_schoolsUpdate] ON [ods].[SeniorSystems_schools]
AFTER UPDATE, DELETE

AS
BEGIN

DECLARE @ETL_UpdatedOn DATETIME = (SELECT [etl].[ConvertToLocalTime](CAST(GETDATE() AS DATETIME2(0))))
DECLARE @ETL_UpdatedBy NVARCHAR(400) = (SELECT SYSTEM_USER)

UPDATE t SET
[ETL_UpdatedOn] = @ETL_UpdatedOn
,[ETL_UpdatedBy] = @ETL_UpdatedBy
FROM [ods].[SeniorSystems_schools] t
	JOIN inserted i ON  t.[SchoolID] = i.[SchoolID]

INSERT INTO [ods].[Snapshot_SeniorSystems_schools] ([SchoolID],[SchoolName],[IsAcademicSchool],[IsSummerSchool],[CurrentAcademicYear],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate])
SELECT a.*,dateadd(s,-1,@ETL_UpdatedOn)
FROM deleted a

END
GO
ALTER TABLE [ods].[SeniorSystems_schools] ADD CONSTRAINT [PK__SeniorSy__3DA4677B543050F4] PRIMARY KEY CLUSTERED  ([SchoolID])
GO
