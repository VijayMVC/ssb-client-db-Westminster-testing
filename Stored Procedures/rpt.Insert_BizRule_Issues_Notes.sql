SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROC [rpt].[Insert_BizRule_Issues_Notes] (@IssueID INT,@NoteText VARCHAR(MAX),@IsAction INT,@CreatedDateTime DATETIME,@CreatedBy VARCHAR(200))
AS

--SELECT * FROM [Westminster].[rpt].[test_BizRule_Issues_Notes]

/*
DECLARE @IssueID INT = 1
DECLARE @NoteText VARCHAR(MAX) = 'Test2'
DECLARE @CreatedDateTime DATETIME = getdate()
DECLARE @CreatedBy VARCHAR(200) = 'aoneil'
*/
DECLARE @IsApproval BIT 
DECLARE @IsIgnore BIT 

IF(@IsAction = '-2')
BEGIN
SET @IsApproval = 0
SET @IsIgnore = 0
END

IF(@IsAction = '1')
BEGIN
SET @IsApproval = 1
SET @IsIgnore = 0
UPDATE dbo.BizRule_Issues_Logi SET Logi_Approval = 1
	WHERE IssueID = @IssueID
END


IF(@IsAction = '2')
BEGIN
SET @IsApproval = 0
SET @IsIgnore = 1
UPDATE dbo.BizRule_Issues_Logi SET Logi_Ignore = 1
	WHERE IssueID = @IssueID
END


INSERT INTO [Westminster].dbo.[BizRule_Issues_Notes] 
(IssueID, NoteText, IsApproval, IsIgnore, Note_CreatedOn, Note_CreatedBy)
VALUES(@IssueID, @NoteText, @IsApproval, @IsIgnore, @CreatedDateTime, @CreatedBy)
GO
