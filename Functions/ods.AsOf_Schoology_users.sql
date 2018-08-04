SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

/*
-- Get the status of your table 20 minutes ago...
DECLARE @AsOfDate DATETIME = (SELECT [etl].[ConvertToLocalTime](DATEADD(MINUTE,-20,GETDATE())))
SELECT * FROM [ods].[AsOf_Schoology_users] (@AsOfDate)
*/

CREATE FUNCTION [ods].[AsOf_Schoology_users] (@AsOfDate DATETIME)

RETURNS @Results TABLE
(
[uid] [nvarchar](1000) NULL,
[Userid] [nvarchar](1000) NULL,
[school-id] [nvarchar](1000) NULL,
[synced] [nvarchar](1000) NULL,
[school-uid] [nvarchar](1000) NULL,
[building-id] [nvarchar](1000) NULL,
[name-title] [nvarchar](1000) NULL,
[name-title-show] [nvarchar](1000) NULL,
[name-first] [nvarchar](1000) NULL,
[name-first-preferred] [nvarchar](1000) NULL,
[use-preferred-first-name] [nvarchar](1000) NULL,
[name-middle] [nvarchar](1000) NULL,
[name-middle-show] [nvarchar](1000) NULL,
[name-last] [nvarchar](1000) NULL,
[name-display] [nvarchar](1000) NULL,
[username] [nvarchar](1000) NULL,
[primary-email] [nvarchar](1000) NULL,
[picture-url] [nvarchar](1000) NULL,
[gender] [nvarchar](1000) NULL,
[position] [nvarchar](1000) NULL,
[grad-year] [nvarchar](1000) NULL,
[password] [nvarchar](1000) NULL,
[role-id] [nvarchar](1000) NULL,
[tz-offset] [nvarchar](1000) NULL,
[tz-name] [nvarchar](1000) NULL,
[parents] [nvarchar](1000) NULL,
[child-uids] [nvarchar](1000) NULL,
[language] [nvarchar](1000) NULL,
[additional-buildings] [nvarchar](1000) NULL,
[ETL_CreatedOn] [datetime] NOT NULL,
[ETL_CreatedBy] NVARCHAR(400) NOT NULL,
[ETL_UpdatedOn] [datetime] NOT NULL,
[ETL_UpdatedBy] NVARCHAR(400) NOT NULL
)

AS
BEGIN

DECLARE @EndDate DATETIME = (SELECT [etl].[ConvertToLocalTime](CAST(GETDATE() AS datetime2(0))))
SET @AsOfDate = (SELECT CAST(@AsOfDate AS datetime2(0)))

INSERT INTO @Results
SELECT [uid],[Userid],[school-id],[synced],[school-uid],[building-id],[name-title],[name-title-show],[name-first],[name-first-preferred],[use-preferred-first-name],[name-middle],[name-middle-show],[name-last],[name-display],[username],[primary-email],[picture-url],[gender],[position],[grad-year],[password],[role-id],[tz-offset],[tz-name],[parents],[child-uids],[language],[additional-buildings],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy]
FROM
	(
	SELECT [uid],[Userid],[school-id],[synced],[school-uid],[building-id],[name-title],[name-title-show],[name-first],[name-first-preferred],[use-preferred-first-name],[name-middle],[name-middle-show],[name-last],[name-display],[username],[primary-email],[picture-url],[gender],[position],[grad-year],[password],[role-id],[tz-offset],[tz-name],[parents],[child-uids],[language],[additional-buildings],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],@EndDate [RecordEndDate]
	FROM [ods].[Schoology_users] t
	UNION ALL
	SELECT [uid],[Userid],[school-id],[synced],[school-uid],[building-id],[name-title],[name-title-show],[name-first],[name-first-preferred],[use-preferred-first-name],[name-middle],[name-middle-show],[name-last],[name-display],[username],[primary-email],[picture-url],[gender],[position],[grad-year],[password],[role-id],[tz-offset],[tz-name],[parents],[child-uids],[language],[additional-buildings],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate]
	FROM [ods].[Snapshot_Schoology_users]
	) a
WHERE
	@AsOfDate BETWEEN [ETL_UpdatedOn] AND [RecordEndDate]
	AND [ETL_CreatedOn] <= @AsOfDate

RETURN

END
GO
