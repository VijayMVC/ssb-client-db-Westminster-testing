SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

/*
-- Get the status of your table 20 minutes ago...
DECLARE @AsOfDate DATETIME = (SELECT [etl].[ConvertToLocalTime](DATEADD(MINUTE,-20,GETDATE())))
SELECT * FROM [ods].[AsOf_Schoology_groups] (@AsOfDate)
*/

CREATE FUNCTION [ods].[AsOf_Schoology_groups] (@AsOfDate DATETIME)

RETURNS @Results TABLE
(
[groupid] [nvarchar](50) NULL,
[title] [nvarchar](500) NULL,
[description] [nvarchar](max) NULL,
[website] [nvarchar](500) NULL,
[access-code] [nvarchar](250) NULL,
[category] [nvarchar](100) NULL,
[group_code] [nvarchar](50) NULL,
[privacy_level] [nvarchar](50) NULL,
[picture_url] [nvarchar](max) NULL,
[school_id] [nvarchar](50) NULL,
[building_id] [nvarchar](50) NULL,
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
SELECT [groupid],[title],[description],[website],[access-code],[category],[group_code],[privacy_level],[picture_url],[school_id],[building_id],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy]
FROM
	(
	SELECT [groupid],[title],[description],[website],[access-code],[category],[group_code],[privacy_level],[picture_url],[school_id],[building_id],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],@EndDate [RecordEndDate]
	FROM [ods].[Schoology_groups] t
	UNION ALL
	SELECT [groupid],[title],[description],[website],[access-code],[category],[group_code],[privacy_level],[picture_url],[school_id],[building_id],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate]
	FROM [ods].[Snapshot_Schoology_groups]
	) a
WHERE
	@AsOfDate BETWEEN [ETL_UpdatedOn] AND [RecordEndDate]
	AND [ETL_CreatedOn] <= @AsOfDate

RETURN

END
GO
