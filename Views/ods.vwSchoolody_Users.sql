SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create view [ods].[vwSchoolody_Users]
as 
With UserBase 
 as (

SELECT 
	[uid] 
	,[name-display]
	,[school-uid]
	,synced
	,0 Inactive
FROM [Westminster].[ods].[Schoology_users] 
UNION ALL
SELECT 
	uid	
	,name
	,school_uid
	,synced
	,1 Inactive
FROM [ods].[Schoology_users_inactive]
--order by 1
)


Select * from UserBase a
--LEFT JOIN ods.Schoology_courses_sections b
GO
