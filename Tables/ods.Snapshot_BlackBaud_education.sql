CREATE TABLE [ods].[Snapshot_BlackBaud_education]
(
[BlackBaud_educationSK] [int] NOT NULL IDENTITY(1, 1),
[Edcucationid] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[constituent_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[school] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[type] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[class_of] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[primary] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[degree] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[majors] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Date_Entered] [date] NULL,
[ETL_CreatedOn] [datetime] NULL,
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_UpdatedOn] [datetime] NULL,
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RecordEndDate] [datetime] NULL,
[campus] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[gpa] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[status] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SocialOrganization] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[KnownName] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DateAdded] [datetime2] NULL,
[DateModified] [datetime2] NULL,
[Date_Graduated] [date] NULL,
[Date_Left] [date] NULL
)
GO
ALTER TABLE [ods].[Snapshot_BlackBaud_education] ADD CONSTRAINT [PK__Snapshot__20981A9D3A372DF2] PRIMARY KEY CLUSTERED  ([BlackBaud_educationSK])
GO
