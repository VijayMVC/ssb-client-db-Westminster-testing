SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

/*
-- Get the status of your table 20 minutes ago...
DECLARE @AsOfDate DATETIME = (SELECT [etl].[ConvertToLocalTime](DATEADD(MINUTE,-20,GETDATE())))
SELECT * FROM [ods].[AsOf_Schoology_users_inactive] (@AsOfDate)
*/

CREATE FUNCTION [ods].[AsOf_Schoology_users_inactive] (@AsOfDate DATETIME)

RETURNS @Results TABLE
(
[uid] [nvarchar](50) NULL,
[name] [nvarchar](250) NULL,
[school_uid] [nvarchar](50) NULL,
[synced] [int] NULL,
[inactive_timestamp] [nvarchar](50) NULL,
[modified_by_uid] [nvarchar](50) NULL,
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
SELECT [uid],[name],[school_uid],[synced],[inactive_timestamp],[modified_by_uid],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy]
FROM
	(
	SELECT [uid],[name],[school_uid],[synced],[inactive_timestamp],[modified_by_uid],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],@EndDate [RecordEndDate]
	FROM [ods].[Schoology_users_inactive] t
	UNION ALL
	SELECT [uid],[name],[school_uid],[synced],[inactive_timestamp],[modified_by_uid],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate]
	FROM [ods].[Snapshot_Schoology_users_inactive]
	) a
WHERE
	@AsOfDate BETWEEN [ETL_UpdatedOn] AND [RecordEndDate]
	AND [ETL_CreatedOn] <= @AsOfDate

RETURN

END
GO
