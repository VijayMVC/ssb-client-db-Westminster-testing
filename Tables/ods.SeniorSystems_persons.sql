CREATE TABLE [ods].[SeniorSystems_persons]
(
[EntityNo] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Title] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FirstName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MiddleName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LastName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Suffix] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PrefferedName] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FullName] [nvarchar] (300) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Gender] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsParent] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FamilyID] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[HouseholdID] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ParentType] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ParentNameGroup] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsConstituent] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ConstituentRecordNo] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BirthDate] [datetime2] NULL,
[ConstituentClassYr] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsFaculty] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FacultyID] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FacultyDeptID] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FacultyDepartment] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FacultyJobTitle] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FacultyInternalTelNo] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FacultyHireDate] [datetime2] NULL,
[IsStudent] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[StudentEmail] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[WebUserID] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[WebUserNo] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsLDAPAuthenticated] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_CreatedOn] [datetime] NOT NULL CONSTRAINT [DF__SeniorSys__ETL_C__17AD7836] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__SeniorSys__ETL_C__18A19C6F] DEFAULT (suser_sname()),
[ETL_UpdatedOn] [datetime] NOT NULL CONSTRAINT [DF__SeniorSys__ETL_U__1995C0A8] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__SeniorSys__ETL_U__1A89E4E1] DEFAULT (suser_sname()),
[IsDeleted] [bit] NOT NULL CONSTRAINT [DF__SeniorSys__IsDel__01508546] DEFAULT ((0))
)
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

----------- CREATE TRIGGER -----------
CREATE TRIGGER [ods].[Snapshot_SeniorSystems_personsUpdate] ON [ods].[SeniorSystems_persons]
AFTER UPDATE, DELETE

AS
BEGIN

DECLARE @ETL_UpdatedOn DATETIME = (SELECT [etl].[ConvertToLocalTime](CAST(GETDATE() AS DATETIME2(0))))
DECLARE @ETL_UpdatedBy NVARCHAR(400) = (SELECT SYSTEM_USER)

UPDATE t SET
[ETL_UpdatedOn] = @ETL_UpdatedOn
,[ETL_UpdatedBy] = @ETL_UpdatedBy
FROM [ods].[SeniorSystems_persons] t
	JOIN inserted i ON  t.[EntityNo] = i.[EntityNo]

INSERT INTO [ods].[Snapshot_SeniorSystems_persons] ([EntityNo],[Title],[FirstName],[MiddleName],[LastName],[Suffix],[PrefferedName],[FullName],[Gender],[IsParent],[FamilyID],[HouseholdID],[ParentType],[ParentNameGroup],[IsConstituent],[ConstituentRecordNo],[BirthDate],[ConstituentClassYr],[IsFaculty],[FacultyID],[FacultyDeptID],[FacultyDepartment],[FacultyJobTitle],[FacultyInternalTelNo],[FacultyHireDate],[IsStudent],[StudentEmail],[WebUserID],[WebUserNo],[IsLDAPAuthenticated],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[IsDeleted],[RecordEndDate])
SELECT a.*,dateadd(s,-1,@ETL_UpdatedOn)
FROM deleted a

END
GO
ALTER TABLE [ods].[SeniorSystems_persons] ADD CONSTRAINT [PK__SeniorSy__9C89570EF130A8F9] PRIMARY KEY CLUSTERED  ([EntityNo])
GO
CREATE NONCLUSTERED INDEX [IX_SeniorSystems_persons_isparent] ON [ods].[SeniorSystems_persons] ([IsParent]) INCLUDE ([EntityNo], [FamilyID], [HouseholdID])
GO
