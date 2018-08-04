CREATE TABLE [dbo].[BizRule_Issues]
(
[IssueID] [bigint] NOT NULL IDENTITY(1, 1),
[SSID] [varchar] (500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[SourceSystem] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[BizRuleSK] [int] NOT NULL,
[BizRuleSubscriptionSK] [int] NOT NULL,
[IssueIsApproved] [bit] NOT NULL CONSTRAINT [DF__BizRule_F__IsApp__5DAFE149] DEFAULT ((0)),
[IssueIsIgnore] [bit] NOT NULL CONSTRAINT [DF__BizRule_F__IsIgn__5EA40582] DEFAULT ((0)),
[IssueIsCompleted] [bit] NOT NULL CONSTRAINT [DF__BizRule_F__IsNoL__5F9829BB] DEFAULT ((0)),
[Issue_OpenedOn] [datetime] NOT NULL CONSTRAINT [DF__BizRule_F__ETL_C__608C4DF4] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[Issue_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__BizRule_F__ETL_C__6180722D] DEFAULT (suser_sname()),
[Issue_UpdatedOn] [datetime] NOT NULL CONSTRAINT [DF__BizRule_F__ETL_U__62749666] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[Issue_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__BizRule_F__ETL_U__6368BA9F] DEFAULT (suser_sname()),
[Constituent_ID] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EntityNo] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UID] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[OtherID] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SourceOtherID] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FieldHash] [binary] (32) NULL,
[unichk] [uniqueidentifier] NOT NULL CONSTRAINT [DF__BizRule_I__unich__655CBB60] DEFAULT ('00000000-0000-0000-0000-000000000000')
)
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE TRIGGER [dbo].[BizRule_Issue_update] ON [dbo].[BizRule_Issues]
AFTER UPDATE, DELETE

AS
BEGIN

DECLARE @UpdatedOn DATETIME = (SELECT [etl].[ConvertToLocalTime](CAST(GETDATE() AS DATETIME2(0))))
DECLARE @UpdatedBy NVARCHAR(400) = (SELECT SYSTEM_USER)

UPDATE t SET
[Issue_UpdatedOn] = @UpdatedOn
,[Issue_UpdatedBy] = @UpdatedBy
FROM dbo.[BizRule_Issues] t
	JOIN inserted i ON  t.IssueID = i.IssueID


END
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE TRIGGER [dbo].[BizRule_Issues_OnComplete]
   ON  [dbo].[BizRule_Issues]
   AFTER UPDATE
AS 
BEGIN
	SET NOCOUNT ON;
	IF UPDATE (IssueIsCompleted)
	BEGIN
	UPDATE a	
		SET unichk = CASE WHEN i.IssueIsCompleted = 1 THEN NEWID()
						 WHEN i.IssueIsCompleted = 0 THEN '00000000-0000-0000-0000-000000000000'
						 ELSE a.unichk END
		FROM dbo.BizRule_Issues a
		INNER JOIN Inserted i ON a.IssueID = i.IssueID
		INNER JOIN Deleted d ON a.IssueID = d.IssueID
		WHERE i.IssueIsCompleted <> d.IssueIsCompleted

	END


END
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


----------- CREATE TRIGGER -----------
CREATE TRIGGER [dbo].[Snapshot_BizRule_Issues] ON [dbo].[BizRule_Issues]
AFTER UPDATE, DELETE

AS
BEGIN

DECLARE @ETL_UpdatedOn DATETIME = (SELECT [etl].[ConvertToLocalTime](CAST(GETDATE() AS DATETIME2(0))))



INSERT INTO dbo.BizRule_Issues_Snapshot
(
    IssueID,
	SSID,
    SourceSystem,
    BizRuleSK,
    BizRuleSubscriptionSK,
    IssueIsApproved,
    IssueIsIgnore,
    IssueIsCompleted,
    Issue_OpenedOn,
    Issue_CreatedBy,
    Issue_UpdatedOn,
    Issue_UpdatedBy,
    Constituent_ID,
    EntityNo,
    UID,
    OtherID,
    SourceOtherID,
    FieldHash,
    unichk,
    InsertDate
)
SELECT a.*,DATEADD(s,-1,@ETL_UpdatedOn)
FROM deleted a
JOIN Inserted b
	ON b.IssueID = a.IssueID
WHERE 
 ISNULL(a.IssueID,						'') <> ISNULL(b.IssueID,				'')
OR ISNULL(a.SSID,							'') <> ISNULL(b.SSID,					'')
OR ISNULL(a.SourceSystem,					'') <> ISNULL(b.SourceSystem,			'')
OR ISNULL(a.BizRuleSK,						'') <> ISNULL(b.BizRuleSK,				'')
OR ISNULL(a.BizRuleSubscriptionSK,			'') <> ISNULL(b.BizRuleSubscriptionSK,	'')
OR ISNULL(a.IssueIsApproved,				'') <> ISNULL(b.IssueIsApproved,		'')
OR ISNULL(a.IssueIsIgnore,					'') <> ISNULL(b.IssueIsIgnore,			'')
OR ISNULL(a.IssueIsCompleted,					'') <> ISNULL(b.IssueIsCompleted,		'')
OR ISNULL(a.Constituent_ID,				'') <> ISNULL(b.Constituent_ID,		'')	
OR ISNULL(a.EntityNo,						'') <> ISNULL(b.EntityNo,				'')
OR ISNULL(a.UID,							'') <> ISNULL(b.UID,					'')
OR ISNULL(a.OtherID,						'') <> ISNULL(b.OtherID,				'')
OR ISNULL(a.SourceOtherID,					'') <> ISNULL(b.SourceOtherID,			'')
OR a.FieldHash <> b.FieldHash
OR a.unichk <> b.unichk

END													

GO
ALTER TABLE [dbo].[BizRule_Issues] ADD CONSTRAINT [PK_BizRule_Issues] PRIMARY KEY CLUSTERED  ([IssueID])
GO
ALTER TABLE [dbo].[BizRule_Issues] ADD CONSTRAINT [UC_OneOpen_PerRulePerPerson] UNIQUE NONCLUSTERED  ([SSID], [SourceSystem], [BizRuleSK], [BizRuleSubscriptionSK], [unichk])
GO
ALTER TABLE [dbo].[BizRule_Issues] ADD CONSTRAINT [FK_BizRule_Issues_BizRule_Header] FOREIGN KEY ([BizRuleSK]) REFERENCES [dbo].[BizRule_Header] ([BizRuleSK])
GO
