SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROC [dbo].[OutputDownstreamChanges] 
	@IssueID	INT 
	AS
--[dbo].[OutputDownstreamChanges] 6937  11430
--SELECT * FROM dbo.BizRule_Issues WHERE bizrulesk = 18

SELECT CASE WHEN p.IsStudent = 'true' THEN 'Student' WHEN p.IsFaculty = 'true' THEN 'Faculty/Staff'  ELSE 'Parent'  END [Constituent Type]
, p.FullName [Full Name]
,bri.EntityNo
,sis.FieldName [Field Name]
,sis.Current_Value [Current Value]
,sis.Previous_Value [Previous Value]
, CASE WHEN sis.ParentSSID IS NOT NULL THEN 'True' ELSE 'False' END [Is Parent Related]
,ISNULL(pp.FullName,'') [Related Parent Name]
FROM dbo.BizRule_Issues bri
INNER JOIN (SELECT *,ROW_NUMBER() OVER(PARTITION BY SSID, FieldName ORDER BY ChangeDate DESC) RN
			FROM dbo.SIS_DataChanges) sis 
	ON sis.SSID = SUBSTRING(bri.SSID, 1,CHARINDEX('-',bri.SSID)-1)
	AND sis.FieldName = SUBSTRING(bri.SSID, CHARINDEX('-',bri.SSID)+ 1, 99)
	AND sis.rn = 1	
INNER JOIN ods.SeniorSystems_persons p
	ON SIS.SSID = p.EntityNo
LEFT JOIN ods.SeniorSystems_persons pp
	ON sis.ParentSSID = pp.EntityNo 
WHERE bri.IssueID = @IssueID


--DELETE dbo.BizRule_Issues_Notes WHERE IssueID IN (SELECT IssueID FROM dbo.BizRule_Issues WHERE BizRuleSK = 18)
--DELETE FROM dbo.BizRule_Issues WHERE BizRuleSK = 18
--DELETE dbo.BizRule_Issues_Logi WHERE IssueID IN (SELECT IssueID FROM dbo.BizRule_Issues WHERE BizRuleSK = 18)
--EXEC dbo.BizRuleMaster
GO
