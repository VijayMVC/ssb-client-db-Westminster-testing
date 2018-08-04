SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

/*
-- Get the status of your table 20 minutes ago...
DECLARE @AsOfDate DATETIME = (SELECT [etl].[ConvertToLocalTime](DATEADD(MINUTE,-20,GETDATE())))
SELECT * FROM [ods].[AsOf_BlackBaud_actions] (@AsOfDate)
*/

CREATE FUNCTION [ods].[AsOf_BlackBaud_actions] (@AsOfDate DATETIME)

RETURNS @Results TABLE
(
[action_id] [nvarchar](50) NULL,
[constituent_id] [nvarchar](50) NULL,
[category] [nvarchar](max) NULL,
[date] [datetime2](7) NULL,
[summary] [nvarchar](500) NULL,
[type] [nvarchar](100) NULL,
[description] [nvarchar](max) NULL,
[completed] [nvarchar](10) NULL,
[status] [nvarchar](50) NULL,
[date_added] [datetime2](7) NULL,
[date_modified] [datetime2](7) NULL,
[completed_date] [datetime2](7) NULL,
[opportunity_id] [nvarchar](50) NULL,
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
SELECT [action_id],[constituent_id],[category],[date],[summary],[type],[description],[completed],[status],[date_added],[date_modified],[completed_date],[opportunity_id],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy]
FROM
	(
	SELECT [action_id],[constituent_id],[category],[date],[summary],[type],[description],[completed],[status],[date_added],[date_modified],[completed_date],[opportunity_id],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],@EndDate [RecordEndDate]
	FROM [ods].[BlackBaud_actions] t
	UNION ALL
	SELECT [action_id],[constituent_id],[category],[date],[summary],[type],[description],[completed],[status],[date_added],[date_modified],[completed_date],[opportunity_id],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate]
	FROM [ods].[Snapshot_BlackBaud_actions]
	) a
WHERE
	@AsOfDate BETWEEN [ETL_UpdatedOn] AND [RecordEndDate]
	AND [ETL_CreatedOn] <= @AsOfDate

RETURN

END
GO
