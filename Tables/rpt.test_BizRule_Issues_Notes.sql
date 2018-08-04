CREATE TABLE [rpt].[test_BizRule_Issues_Notes]
(
[IssueNoteID] [bigint] NOT NULL IDENTITY(1, 1),
[IssueID] [bigint] NULL,
[NoteText] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsApproval] [bit] NULL,
[IsIgnore] [bit] NULL,
[Note_CreatedOn] [datetime] NULL,
[Note_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
