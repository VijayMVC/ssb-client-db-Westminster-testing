CREATE TABLE [src].[SeniorSystems_schoolcourses]
(
[SK] [bigint] NULL,
[ETL__multi_query_value_for_audit] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SchoolID] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SchoolName] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CourseID] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CourseName] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FullName] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Abbreviation] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Description] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[GradeLevel] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Department_DepartmentID] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Department_Name] [nvarchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
