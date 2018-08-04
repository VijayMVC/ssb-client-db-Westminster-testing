CREATE TABLE [ods].[Snapshot_SeniorSystems_persons]
(
[SeniorSystems_personsSK] [int] NOT NULL IDENTITY(1, 1),
[EntityNo] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
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
[ETL_CreatedOn] [datetime] NULL,
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_UpdatedOn] [datetime] NULL,
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RecordEndDate] [datetime] NULL,
[IsDeleted] [bit] NOT NULL CONSTRAINT [DF__Snapshot___IsDel__005C610D] DEFAULT ((0))
)
GO
ALTER TABLE [ods].[Snapshot_SeniorSystems_persons] ADD CONSTRAINT [PK__Snapshot__1482AF55F22B644C] PRIMARY KEY CLUSTERED  ([SeniorSystems_personsSK])
GO
