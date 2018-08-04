CREATE TABLE [ods].[SeniorSystems_persons_Relationships]
(
[EntityNo] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[StudentId] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[StudentEntityNo] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[FamilyID] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Relationship] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_CreatedOn] [datetime] NOT NULL CONSTRAINT [DF__SeniorSys__ETL_C__7875B8C2] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__SeniorSys__ETL_C__7969DCFB] DEFAULT (suser_sname()),
[ETL_UpdatedOn] [datetime] NOT NULL CONSTRAINT [DF__SeniorSys__ETL_U__7A5E0134] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__SeniorSys__ETL_U__7B52256D] DEFAULT (suser_sname())
)
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

----------- CREATE TRIGGER -----------
CREATE TRIGGER [ods].[Snapshot_SeniorSystems_persons_RelationshipsUpdate] ON [ods].[SeniorSystems_persons_Relationships]
AFTER UPDATE, DELETE

AS
BEGIN

DECLARE @ETL_UpdatedOn DATETIME = (SELECT [etl].[ConvertToLocalTime](CAST(GETDATE() AS DATETIME2(0))))
DECLARE @ETL_UpdatedBy NVARCHAR(400) = (SELECT SYSTEM_USER)

UPDATE t SET
[ETL_UpdatedOn] = @ETL_UpdatedOn
,[ETL_UpdatedBy] = @ETL_UpdatedBy
FROM [ods].[SeniorSystems_persons_Relationships] t
	JOIN inserted i ON  t.[EntityNo] = i.[EntityNo] AND t.[StudentEntityNo] = i.[StudentEntityNo]

INSERT INTO [ods].[Snapshot_SeniorSystems_persons_Relationships] ([EntityNo],[StudentId],[StudentEntityNo],[FamilyID],[Relationship],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate])
SELECT a.*,dateadd(s,-1,@ETL_UpdatedOn)
FROM deleted a

END
GO
ALTER TABLE [ods].[SeniorSystems_persons_Relationships] ADD CONSTRAINT [PK__SeniorSy__D6D22B3ADBB7A82B] PRIMARY KEY CLUSTERED  ([EntityNo], [StudentEntityNo])
GO
