CREATE TABLE [ods].[BlackBaud_education]
(
[Edcucationid] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[constituent_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[school] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[type] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[class_of] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[primary] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[degree] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[majors] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Date_Entered] [date] NULL,
[ETL_CreatedOn] [datetime] NOT NULL CONSTRAINT [DF__BlackBaud__ETL_C__25083EAB] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__BlackBaud__ETL_C__25FC62E4] DEFAULT (suser_sname()),
[ETL_UpdatedOn] [datetime] NOT NULL CONSTRAINT [DF__BlackBaud__ETL_U__26F0871D] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__BlackBaud__ETL_U__27E4AB56] DEFAULT (suser_sname()),
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
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

----------- CREATE TRIGGER -----------
CREATE TRIGGER [ods].[Snapshot_BlackBaud_educationUpdate] ON [ods].[BlackBaud_education]
AFTER UPDATE, DELETE

AS
BEGIN

DECLARE @ETL_UpdatedOn DATETIME = (SELECT [etl].[ConvertToLocalTime](CAST(GETDATE() AS DATETIME2(0))))
DECLARE @ETL_UpdatedBy NVARCHAR(400) = (SELECT SYSTEM_USER)

UPDATE t SET
[ETL_UpdatedOn] = @ETL_UpdatedOn
,[ETL_UpdatedBy] = @ETL_UpdatedBy
FROM [ods].[BlackBaud_education] t
	JOIN inserted i ON  t.[Edcucationid] = i.[Edcucationid]

INSERT INTO [ods].[Snapshot_BlackBaud_education] ([Edcucationid],[constituent_id],[school],[type],[class_of],[primary],[degree],[majors],[Date_Entered],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy]
,campus,gpa,status,SocialOrganization,KnownName,DateAdded,DateModified,Date_Graduated,Date_Left,[RecordEndDate])
SELECT a.*,dateadd(s,-1,@ETL_UpdatedOn)
FROM deleted a

END
GO
ALTER TABLE [ods].[BlackBaud_education] ADD CONSTRAINT [PK__BlackBau__F0BF10E19071ADB5] PRIMARY KEY CLUSTERED  ([Edcucationid])
GO
