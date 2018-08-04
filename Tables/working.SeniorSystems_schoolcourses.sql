CREATE TABLE [working].[SeniorSystems_schoolcourses]
(
[StageTable] [nvarchar] (4000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ETL__session_id] [uniqueidentifier] NOT NULL,
[ETL__insert_datetime] [datetime] NOT NULL,
[ETL__multi_query_value_for_audit] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[id] [int] NOT NULL IDENTITY(1, 1),
[parent] [int] NOT NULL,
[name] [nvarchar] (4000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[name_Raw] [nvarchar] (4000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[kind] [nvarchar] (4000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[value] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[HName] [nvarchar] (4000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Length] [int] NULL,
[IsJSON] [int] NULL,
[Level] [int] NOT NULL
)
GO
ALTER TABLE [working].[SeniorSystems_schoolcourses] ADD CONSTRAINT [PK__SeniorSy__3213E83F4D6F06B3] PRIMARY KEY CLUSTERED  ([id])
GO
CREATE NONCLUSTERED INDEX [IX_Working__IsJSONLevel] ON [working].[SeniorSystems_schoolcourses] ([IsJSON], [Level]) INCLUDE ([id], [parent])
GO
CREATE NONCLUSTERED INDEX [ix_parent] ON [working].[SeniorSystems_schoolcourses] ([parent])
GO
