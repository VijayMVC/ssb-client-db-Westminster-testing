CREATE TABLE [ods].[BlackBaudFE_projects]
(
[project_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[description] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ui_project_id] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[start-date] [datetime2] NULL,
[end-date] [datetime2] NULL,
[location] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[division] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[department] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[status] [nvarchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[date-added] [datetime2] NULL,
[date-modified] [datetime2] NULL,
[added-by] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[modified-by] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_CreatedOn] [datetime] NOT NULL CONSTRAINT [DF__BlackBaud__ETL_C__67F9D2D4] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__BlackBaud__ETL_C__68EDF70D] DEFAULT (suser_sname()),
[ETL_UpdatedOn] [datetime] NOT NULL CONSTRAINT [DF__BlackBaud__ETL_U__69E21B46] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__BlackBaud__ETL_U__6AD63F7F] DEFAULT (suser_sname())
)
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

----------- CREATE TRIGGER -----------
CREATE TRIGGER [ods].[Snapshot_BlackBaudFE_projectsUpdate] ON [ods].[BlackBaudFE_projects]
AFTER UPDATE, DELETE

AS
BEGIN

DECLARE @ETL_UpdatedOn DATETIME = (SELECT [etl].[ConvertToLocalTime](CAST(GETDATE() AS DATETIME2(0))))
DECLARE @ETL_UpdatedBy NVARCHAR(400) = (SELECT SYSTEM_USER)

UPDATE t SET
[ETL_UpdatedOn] = @ETL_UpdatedOn
,[ETL_UpdatedBy] = @ETL_UpdatedBy
FROM [ods].[BlackBaudFE_projects] t
	JOIN inserted i ON  t.[project_id] = i.[project_id]

INSERT INTO [ods].[Snapshot_BlackBaudFE_projects] ([project_id],[description],[ui_project_id],[start-date],[end-date],[location],[division],[department],[status],[date-added],[date-modified],[added-by],[modified-by],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate])
SELECT a.*,dateadd(s,-1,@ETL_UpdatedOn)
FROM deleted a

END
GO
ALTER TABLE [ods].[BlackBaudFE_projects] ADD CONSTRAINT [PK__BlackBau__BC799E1F08EDCF10] PRIMARY KEY CLUSTERED  ([project_id])
GO
