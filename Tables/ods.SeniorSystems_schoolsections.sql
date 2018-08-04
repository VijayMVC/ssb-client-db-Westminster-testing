CREATE TABLE [ods].[SeniorSystems_schoolsections]
(
[SectionID] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[MeetsPeriod] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MeetsLength] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MeetsGradeSeq] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SchoolID] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SchoolName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CourseID] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CourseName] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FullName] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Abbreviation] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Description] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[GradeLevel] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Department_DepartmentID] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Department_Name] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CurrentYear] [int] NOT NULL,
[ETL_CreatedOn] [datetime] NOT NULL CONSTRAINT [DF__SeniorSys__ETL_C__26FC68D8] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__SeniorSys__ETL_C__27F08D11] DEFAULT (suser_sname()),
[ETL_UpdatedOn] [datetime] NOT NULL CONSTRAINT [DF__SeniorSys__ETL_U__28E4B14A] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__SeniorSys__ETL_U__29D8D583] DEFAULT (suser_sname())
)
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

----------- CREATE TRIGGER -----------
CREATE TRIGGER [ods].[Snapshot_SeniorSystems_schoolsectionsUpdate] ON [ods].[SeniorSystems_schoolsections]
AFTER UPDATE, DELETE

AS
BEGIN

DECLARE @ETL_UpdatedOn DATETIME = (SELECT [etl].[ConvertToLocalTime](CAST(GETDATE() AS DATETIME2(0))))
DECLARE @ETL_UpdatedBy NVARCHAR(400) = (SELECT SYSTEM_USER)

UPDATE t SET
[ETL_UpdatedOn] = @ETL_UpdatedOn
,[ETL_UpdatedBy] = @ETL_UpdatedBy
FROM [ods].[SeniorSystems_schoolsections] t
	JOIN inserted i ON  t.[SectionID] = i.[SectionID] AND t.[CurrentYear] = i.[CurrentYear]

INSERT INTO [ods].[Snapshot_SeniorSystems_schoolsections] ([SectionID],[MeetsPeriod],[MeetsLength],[MeetsGradeSeq],[SchoolID],[SchoolName],[CourseID],[CourseName],[FullName],[Abbreviation],[Description],[GradeLevel],[Department_DepartmentID],[Department_Name],[CurrentYear],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate])
SELECT a.*,dateadd(s,-1,@ETL_UpdatedOn)
FROM deleted a

END
GO
ALTER TABLE [ods].[SeniorSystems_schoolsections] ADD CONSTRAINT [PK__SeniorSy__DCEFD17C5A1956C5] PRIMARY KEY CLUSTERED  ([SectionID], [CurrentYear])
GO
