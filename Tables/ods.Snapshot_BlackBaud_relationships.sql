CREATE TABLE [ods].[Snapshot_BlackBaud_relationships]
(
[BlackBaud_relationshipsSK] [int] NOT NULL IDENTITY(1, 1),
[Relationship_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
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
[ETL_CreatedOn] [datetime] NULL,
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ETL_UpdatedOn] [datetime] NULL,
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RecordEndDate] [datetime] NULL
)
GO
ALTER TABLE [ods].[Snapshot_BlackBaud_relationships] ADD CONSTRAINT [PK__Snapshot__154104672716AFD6] PRIMARY KEY CLUSTERED  ([BlackBaud_relationshipsSK])
GO
