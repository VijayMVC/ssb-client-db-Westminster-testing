CREATE TABLE [ods].[BlackBaud_relationships]
(
[Relationship_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Relationship_count] [int] NULL,
[constituent_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[relation_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[name] [nvarchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[type] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[reciprocal_type] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[is_spouse] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[is_organization_contact] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[is_primary_business] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[position] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[comment] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[organization_contact_type] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Start_Date] [date] NULL,
[End_Date] [date] NULL,
[ETL_CreatedOn] [datetime] NOT NULL CONSTRAINT [DF__BlackBaud__ETL_C__0D269379] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__BlackBaud__ETL_C__0E1AB7B2] DEFAULT (suser_sname()),
[ETL_UpdatedOn] [datetime] NOT NULL CONSTRAINT [DF__BlackBaud__ETL_U__0F0EDBEB] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__BlackBaud__ETL_U__10030024] DEFAULT (suser_sname())
)
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

----------- CREATE TRIGGER -----------
CREATE TRIGGER [ods].[Snapshot_BlackBaud_relationshipsUpdate] ON [ods].[BlackBaud_relationships]
AFTER UPDATE, DELETE

AS
BEGIN

DECLARE @ETL_UpdatedOn DATETIME = (SELECT [etl].[ConvertToLocalTime](CAST(GETDATE() AS DATETIME2(0))))
DECLARE @ETL_UpdatedBy NVARCHAR(400) = (SELECT SYSTEM_USER)

UPDATE t SET
[ETL_UpdatedOn] = @ETL_UpdatedOn
,[ETL_UpdatedBy] = @ETL_UpdatedBy
FROM [ods].[BlackBaud_relationships] t
	JOIN inserted i ON  t.[Relationship_id] = i.[Relationship_id]

INSERT INTO [ods].[Snapshot_BlackBaud_relationships] ([Relationship_id],[Relationship_count],[constituent_id],[relation_id],[name],[type],[reciprocal_type],[is_spouse],[is_organization_contact],[is_primary_business],[position],[comment],[organization_contact_type],[Start_Date],[End_Date],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate])
SELECT a.*,dateadd(s,-1,@ETL_UpdatedOn)
FROM deleted a

END
GO
ALTER TABLE [ods].[BlackBaud_relationships] ADD CONSTRAINT [PK__BlackBau__1D4D88B8B3BB7523] PRIMARY KEY CLUSTERED  ([Relationship_id])
GO
