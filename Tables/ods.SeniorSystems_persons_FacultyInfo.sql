CREATE TABLE [ods].[SeniorSystems_persons_FacultyInfo]
(
[EntityNo] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Faculty_ID] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[DepartmentID] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DepartmentName] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[JobTitle] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[InternalTelNo] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[HireDate] [datetime2] NULL,
[MajorTeachingArea] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MinorTeachingArea] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FacultyType] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FacultyStatus] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ExperienceLevel] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Location] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsActive] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EMail] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DisplayInDirectory] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_CreatedOn] [datetime] NOT NULL CONSTRAINT [DF__SeniorSys__ETL_C__2136E270] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__SeniorSys__ETL_C__222B06A9] DEFAULT (suser_sname()),
[ETL_UpdatedOn] [datetime] NOT NULL CONSTRAINT [DF__SeniorSys__ETL_U__231F2AE2] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__SeniorSys__ETL_U__24134F1B] DEFAULT (suser_sname())
)
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

----------- CREATE TRIGGER -----------
CREATE TRIGGER [ods].[Snapshot_SeniorSystems_persons_FacultyInfoUpdate] ON [ods].[SeniorSystems_persons_FacultyInfo]
AFTER UPDATE, DELETE

AS
BEGIN

DECLARE @ETL_UpdatedOn DATETIME = (SELECT [etl].[ConvertToLocalTime](CAST(GETDATE() AS DATETIME2(0))))
DECLARE @ETL_UpdatedBy NVARCHAR(400) = (SELECT SYSTEM_USER)

UPDATE t SET
[ETL_UpdatedOn] = @ETL_UpdatedOn
,[ETL_UpdatedBy] = @ETL_UpdatedBy
FROM [ods].[SeniorSystems_persons_FacultyInfo] t
	JOIN inserted i ON  t.[Faculty_ID] = i.[Faculty_ID]

INSERT INTO [ods].[Snapshot_SeniorSystems_persons_FacultyInfo] ([EntityNo],[Faculty_ID],[DepartmentID],[DepartmentName],[JobTitle],[InternalTelNo],[HireDate],[MajorTeachingArea],[MinorTeachingArea],[FacultyType],[FacultyStatus],[ExperienceLevel],[Location],[IsActive],[EMail],[DisplayInDirectory],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate])
SELECT a.*,dateadd(s,-1,@ETL_UpdatedOn)
FROM deleted a

END
GO
ALTER TABLE [ods].[SeniorSystems_persons_FacultyInfo] ADD CONSTRAINT [PK__SeniorSy__4EFCEA4A2CDEAC3B] PRIMARY KEY CLUSTERED  ([Faculty_ID])
GO
