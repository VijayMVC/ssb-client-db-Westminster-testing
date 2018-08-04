SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

/*
-- Get the status of your table 20 minutes ago...
DECLARE @AsOfDate DATETIME = (SELECT [etl].[ConvertToLocalTime](DATEADD(MINUTE,-20,GETDATE())))
SELECT * FROM [ods].[AsOf_BlackBaud_gifts] (@AsOfDate)
*/

CREATE FUNCTION [ods].[AsOf_BlackBaud_gifts] (@AsOfDate DATETIME)

RETURNS @Results TABLE
(
[giftid] [nvarchar](50) NULL,
[date] [datetime2](7) NULL,
[date_added] [datetime2](7) NULL,
[date_modified] [datetime2](7) NULL,
[type] [nvarchar](100) NULL,
[constituent_id] [nvarchar](50) NULL,
[is_anonymous] [nvarchar](10) NULL,
[post_status] [nvarchar](50) NULL,
[gift_status] [nvarchar](50) NULL,
[reference] [nvarchar](max) NULL,
[post_date] [datetime2](7) NULL,
[subtype] [nvarchar](250) NULL,
[amount_value] [float] NULL,
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
SELECT [giftid],[date],[date_added],[date_modified],[type],[constituent_id],[is_anonymous],[post_status],[gift_status],[reference],[post_date],[subtype],[amount_value],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy]
FROM
	(
	SELECT [giftid],[date],[date_added],[date_modified],[type],[constituent_id],[is_anonymous],[post_status],[gift_status],[reference],[post_date],[subtype],[amount_value],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],@EndDate [RecordEndDate]
	FROM [ods].[BlackBaud_gifts] t
	UNION ALL
	SELECT [giftid],[date],[date_added],[date_modified],[type],[constituent_id],[is_anonymous],[post_status],[gift_status],[reference],[post_date],[subtype],[amount_value],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate]
	FROM [ods].[Snapshot_BlackBaud_gifts]
	) a
WHERE
	@AsOfDate BETWEEN [ETL_UpdatedOn] AND [RecordEndDate]
	AND [ETL_CreatedOn] <= @AsOfDate

RETURN

END
GO
