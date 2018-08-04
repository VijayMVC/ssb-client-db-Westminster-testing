SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
--[ODS].[Schoology_users]

CREATE VIEW [preODS].[Schoology_users]
AS

SELECT
	[uid]  [uid_K]
	,[Userid]
	,[school-id]
	,[synced]
	,[school-uid]
	,[building-id]
	,[name-title]
	,[name-title-show]
	,[name-first]
	,[name-first-preferred]
	,[use-preferred-first-name]
	,[name-middle]
	,[name-middle-show]
	,[name-last]
	,[name-display]
	,[username]
	,[primary-email]
	,[picture-url]
	,[gender]
	,[position]
	,[grad-year]
	,[password]
	,[role-id]
	,[tz-offset]
	,[tz-name]
	,[parents]
	,[child-uids]
	,[language]
	,[additional-buildings]
	,CONVERT(NVARCHAR(MAX),[bio]) [bio]
	,CONVERT(NVARCHAR(MAX),[phone]) [phone]
	,CONVERT(NVARCHAR(MAX),[subjects-taught]) [subjects_taught]
	,CONVERT(NVARCHAR(MAX),[website]) [website]
	,CONVERT(NVARCHAR(MAX),[address]) [address]
	,CONVERT(NVARCHAR(MAX),[grades-taught]) [grades_taught]
	,CONVERT(NVARCHAR(MAX),[interests]) [interests]
	,CONVERT(NVARCHAR(MAX),[bio-position]) [bio_position]
	,CONVERT(NVARCHAR(MAX),[activities]) [activities]
	,CONVERT(NVARCHAR(MAX),[department]) [department]
	,TRY_CAST(NULLIF([birthday-date],'') AS date) [birthday_date]
	,CONVERT(NVARCHAR(MAX),[birthday]) [birthday]
FROM [src].Schoology_users
WHERE [uid] IS NOT NULL
--where  constituent_id = '16271'


GO
