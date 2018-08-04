SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [rpt].[prompt_Name2] (@TableName VARCHAR(255), @user VARCHAR(MAX))
AS

--SELECT 'Select All' Name, '-1' Value
--UNION ALL
SELECT DISTINCT CASE WHEN LEN(CAST(a.PriorityOrder AS VARCHAR(5))) = 1 THEN '0' + CAST(a.PriorityOrder AS VARCHAR(5)) ELSE CAST(a.PriorityOrder AS VARCHAR(5)) END +'-' +a.Name AS Name, a.BizRuleSubscriptionSK Value

FROM dbo.BizRule_Subscription a
INNER JOIN dbo.BizRule_Issues_Logi b ON b.BizRuleSubscriptionSK = a.BizRuleSubscriptionSK
INNER JOIN dbo.WestminsterSchools_Orchard_Users_UserPartRecord us
	ON REPLACE(@user,'user,','') = us.UserName
INNER JOIN dbo.WestminsterSchools_Orchard_Roles_UserRolesPartRecord xlink
	ON us.id = xlink.UserId
LEFT JOIN dbo.BizRule_Security sec
	ON a.BizRuleSubscriptionSK = sec.BizRuleSubscriptionSK
	AND xlink.Role_id = sec.PortalRoleID
WHERE (xlink.Role_id IN (10,11,12,13)--Administrator,SSBSiteOwner,SSBAdmin,Westminster Admin
		OR sec.BizRuleSecuritySK IS NOT NULL) --If not an admin, only show allowed rules
ORDER BY 1
GO
