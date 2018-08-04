SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
/****** Script for SelectTopNRows command from SSMS  ******/
CREATE PROCEDURE [rpt].[p_FailedBusinessRules3] (@Name varchar(max), @user VARCHAR(MAX))
AS


CREATE TABLE #PromptBizRuleSubSK (BizSK int)
INSERT INTO #PromptBizRuleSubSK select cast(value as int) from string_split(@Name,',')


DECLARE @SelecterdCount INT = (SELECT COUNT(1) FROM #PromptBizRuleSubSK)

SELECT 
	[Group]	
	,[GroupID]
	,IssueID
	--,SSID [Source ID]
	,FullName [Name]
	,SourceSystem [Source System]
	,BizRuleSubscriptionSK
	,BizRulePriority [Rule Priority]
	,BizRuleDesc [Rule Description]
	,Name	[Rule Name]
	,KeyFieldName	[Key Field Name]
	,KeyFieldValue	[Key Field Value]
	,ValidationFieldName
	,ValidationFieldValue	[Validation Value]
	,SourceFieldName		
	,SourceFieldValue		[Source Value]
	,Issue_OpenedOn			[Issue Opend On]
	,Issue_UpdatedOn		[Issue Last Updated On]
	,Issues
	--,CAST(0 AS BIT) AS IsTwoButton
	,CAST(CASE WHEN IsTwoButton = 1 THEN 0 ELSE 1 END AS BIT) AS IsOneButton
	,IsTwoButton
 FROM (
SELECT x.*
,ROW_NUMBER() OVER(PARTITION BY CASE WHEN [Group] = 'Parent' THEN 2 ELSE 1 END, BizRuleSubscriptionSK ORDER BY BizRulePriority, x.IssueID) RN
,ROW_NUMBER() OVER(PARTITION BY CASE WHEN [Group] = 'Parent' THEN 2 ELSE 1 END ORDER BY BizRulePriority, x.IssueID) RN_All
FROM (
SELECT 
	CASE GROUPING_ID(
		IssueID	,FullName	,SourceSystem	,BizRulePriority	,BizRuleDesc
		,Name	,KeyFieldName	,KeyFieldValue	,ValidationFieldName
		,ValidationFieldValue	,SourceFieldName	,SourceFieldValue
		,Issue_OpenedOn	,Issue_UpdatedOn,IsTwoButton)
		WHEN 0 THEN 'Child'
		ELSE 'Parent' END AS 'Group'
	,GROUPING_ID(
		IssueID	,FullName 	,SourceSystem	,BizRulePriority	,BizRuleDesc
		,Name	,KeyFieldName	,KeyFieldValue	,ValidationFieldName
		,ValidationFieldValue	,SourceFieldName	,SourceFieldValue
		,Issue_OpenedOn	,Issue_UpdatedOn,IsTwoButton) GroupID
	,IssueID
	--,SSID
	,FullName
	,SourceSystem
	,a.BizRuleSubscriptionSK
	,BizRulePriority
	,BizRuleDesc
	--,[Type]
	,Name
	--,TableName
	,KeyFieldName
	,KeyFieldValue
	,ValidationFieldName
	,ValidationFieldValue
	,SourceFieldName
	,SourceFieldValue
	--,IssueIsApproved
	--,IssueIsIgnore
	--,IssueIsCompleted
	,Issue_OpenedOn
	--,Issue_CreatedBy
	,Issue_UpdatedOn
	--,Issue_UpdatedBy
	--,B.DetailRow
	--,b.IssueCount
	--,b.RowType
	,IsTwoButton
	,COUNT(IssueID) Issues
FROM dbo.BizRule_Issues_Logi a
INNER JOIN dbo.WestminsterSchools_Orchard_Users_UserPartRecord us
	ON REPLACE(@user,'user,','') = us.UserName
INNER JOIN dbo.WestminsterSchools_Orchard_Roles_UserRolesPartRecord xlink
	ON us.id = xlink.UserId
LEFT JOIN dbo.BizRule_Security sec
	ON a.BizRuleSubscriptionSK = sec.BizRuleSubscriptionSK
	AND xlink.Role_id = sec.PortalRoleID
WHERE CAST(ISNULL(Logi_Approval,0) AS INT) + CAST(ISNULL(Logi_Ignore,0) AS INT) = 0
	and (a.BizRuleSubscriptionSK IN (SELECT BizSK from #PromptBizRuleSubSK))
	--Role based Security
	AND (xlink.Role_id IN (10,11,12,13)--Administrator,SSBSiteOwner,SSBAdmin,Westminster Admin
		OR sec.BizRuleSecuritySK IS NOT NULL) --If not an admin, only show allowed rules
GROUP BY GROUPING SETS ((BizRulePriority,BizRuleDesc,Name),(
	IssueID
	--,SSID
	,FullName
	,SourceSystem
	,a.BizRuleSubscriptionSK
	,BizRulePriority
	,BizRuleDesc
	,Name
	,KeyFieldName
	,KeyFieldValue
	,ValidationFieldName
	,ValidationFieldValue
	,SourceFieldName
	,SourceFieldValue
	,Issue_OpenedOn
	,Issue_UpdatedOn
	,IsTwoButton))

) x
)y

WHERE y.[Group] = 'Parent' OR ((@SelecterdCount >1 AND RN  < 6) OR (@SelecterdCount =1 ))

ORDER BY BizRulePriority, [Issue Opend On] DESC
GO
