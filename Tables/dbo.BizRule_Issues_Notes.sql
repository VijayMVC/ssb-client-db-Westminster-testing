CREATE TABLE [dbo].[BizRule_Issues_Notes]
(
[IssueNoteID] [bigint] NOT NULL IDENTITY(1, 1),
[IssueID] [bigint] NOT NULL,
[NoteText] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsApproval] [bit] NOT NULL CONSTRAINT [DF__Note1] DEFAULT ((0)),
[IsIgnore] [bit] NOT NULL CONSTRAINT [DF__Note4] DEFAULT ((0)),
[Note_CreatedOn] [datetime] NOT NULL CONSTRAINT [DF__Note2] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[Note_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__Note3] DEFAULT (suser_sname())
)
GO
ALTER TABLE [dbo].[BizRule_Issues_Notes] ADD CONSTRAINT [PK_BizRule_Issues_Notes] PRIMARY KEY CLUSTERED  ([IssueNoteID])
GO
ALTER TABLE [dbo].[BizRule_Issues_Notes] ADD CONSTRAINT [FK_BizRule_Issues_Notes_BizRule_Issues] FOREIGN KEY ([IssueID]) REFERENCES [dbo].[BizRule_Issues] ([IssueID])
GO
