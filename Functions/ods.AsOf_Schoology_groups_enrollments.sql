SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

/*
-- Get the status of your table 20 minutes ago...
DECLARE @AsOfDate DATETIME = (SELECT [etl].[ConvertToLocalTime](DATEADD(MINUTE,-20,GETDATE())))
SELECT * FROM [ods].[AsOf_Schoology_groups_enrollments] (@AsOfDate)
*/

CREATE FUNCTION [ods].[AsOf_Schoology_groups_enrollments] (@AsOfDate DATETIME)

RETURNS @Results TABLE
(
[Group_ID] [nvarchar](50) NULL,
[enrollment_id] [nvarchar](50) NULL,
[uid] [nvarchar](50) NULL,
[school_uid] [nvarchar](50) NULL,
[name_title] [nvarchar](50) NULL,
[name_title_show] [bit] NULL,
[name_first] [nvarchar](100) NULL,
[name_first_preferred] [nvarchar](100) NULL,
[use_preferred_first_name] [bit] NULL,
[name_middle] [nvarchar](100) NULL,
[name_middle_show] [bit] NULL,
[name_last] [nvarchar](100) NULL,
[name_display] [nvarchar](250) NULL,
[admin] [bit] NULL,
[status] [bit] NULL,
[picture_url] [nvarchar](500) NULL,
[links_self] [nvarchar](500) NULL,
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
SELECT [Group_ID],[enrollment_id],[uid],[school_uid],[name_title],[name_title_show],[name_first],[name_first_preferred],[use_preferred_first_name],[name_middle],[name_middle_show],[name_last],[name_display],[admin],[status],[picture_url],[links_self],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy]
FROM
	(
	SELECT [Group_ID],[enrollment_id],[uid],[school_uid],[name_title],[name_title_show],[name_first],[name_first_preferred],[use_preferred_first_name],[name_middle],[name_middle_show],[name_last],[name_display],[admin],[status],[picture_url],[links_self],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],@EndDate [RecordEndDate]
	FROM [ods].[Schoology_groups_enrollments] t
	UNION ALL
	SELECT [Group_ID],[enrollment_id],[uid],[school_uid],[name_title],[name_title_show],[name_first],[name_first_preferred],[use_preferred_first_name],[name_middle],[name_middle_show],[name_last],[name_display],[admin],[status],[picture_url],[links_self],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate]
	FROM [ods].[Snapshot_Schoology_groups_enrollments]
	) a
WHERE
	@AsOfDate BETWEEN [ETL_UpdatedOn] AND [RecordEndDate]
	AND [ETL_CreatedOn] <= @AsOfDate

RETURN

END
GO
