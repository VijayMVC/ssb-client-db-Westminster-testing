CREATE TABLE [ods].[SeniorSystems_studentSectionsByStudentId]
(
[StudentID] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SectionID] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[WithdrawMarkingPeriod] [bit] NULL,
[CurrentYear] [int] NOT NULL,
[ETL_CreatedOn] [datetime] NOT NULL CONSTRAINT [DF__SeniorSys__ETL_C__20447E51] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__SeniorSys__ETL_C__2138A28A] DEFAULT (suser_sname()),
[ETL_UpdatedOn] [datetime] NOT NULL CONSTRAINT [DF__SeniorSys__ETL_U__222CC6C3] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__SeniorSys__ETL_U__2320EAFC] DEFAULT (suser_sname())
)
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

----------- CREATE TRIGGER -----------
CREATE TRIGGER [ods].[Snapshot_SeniorSystems_studentSectionsByStudentIdUpdate] ON [ods].[SeniorSystems_studentSectionsByStudentId]
AFTER UPDATE, DELETE

AS
BEGIN

DECLARE @ETL_UpdatedOn DATETIME = (SELECT [etl].[ConvertToLocalTime](CAST(GETDATE() AS DATETIME2(0))))
DECLARE @ETL_UpdatedBy NVARCHAR(400) = (SELECT SYSTEM_USER)

UPDATE t SET
[ETL_UpdatedOn] = @ETL_UpdatedOn
,[ETL_UpdatedBy] = @ETL_UpdatedBy
FROM [ods].[SeniorSystems_studentSectionsByStudentId] t
	JOIN inserted i ON  t.[StudentID] = i.[StudentID] AND t.[SectionID] = i.[SectionID] AND t.[CurrentYear] = i.[CurrentYear]

INSERT INTO [ods].[Snapshot_SeniorSystems_studentSectionsByStudentId] ([StudentID],[SectionID],[WithdrawMarkingPeriod],[CurrentYear],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate])
SELECT a.*,dateadd(s,-1,@ETL_UpdatedOn)
FROM deleted a

END
GO
ALTER TABLE [ods].[SeniorSystems_studentSectionsByStudentId] ADD CONSTRAINT [PK__SeniorSy__61A18E93F8C356C6] PRIMARY KEY CLUSTERED  ([StudentID], [SectionID], [CurrentYear])
GO
CREATE NONCLUSTERED INDEX [IX_odsSeniorStudentSect_WithdrawMarkingPeriod] ON [ods].[SeniorSystems_studentSectionsByStudentId] ([WithdrawMarkingPeriod], [CurrentYear]) INCLUDE ([StudentID])
GO
