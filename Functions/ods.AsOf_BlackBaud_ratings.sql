SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

/*
-- Get the status of your table 20 minutes ago...
DECLARE @AsOfDate DATETIME = (SELECT [etl].[ConvertToLocalTime](DATEADD(MINUTE,-20,GETDATE())))
SELECT * FROM [ods].[AsOf_BlackBaud_ratings] (@AsOfDate)
*/

CREATE FUNCTION [ods].[AsOf_BlackBaud_ratings] (@AsOfDate DATETIME)

RETURNS @Results TABLE
(
[RatingID] [int] NULL,
[RatingCategory] [nvarchar](500) NULL,
[RatingComment] [nvarchar](max) NULL,
[Constituent_ID] [int] NULL,
[RatingDate] [datetime2](7) NULL,
[Inactive] [nvarchar](10) NULL,
[RatingSource] [nvarchar](500) NULL,
[RatingType] [nvarchar](500) NULL,
[RatingValue] [nvarchar](500) NULL,
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
SELECT [RatingID],[RatingCategory],[RatingComment],[Constituent_ID],[RatingDate],[Inactive],[RatingSource],[RatingType],[RatingValue],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy]
FROM
	(
	SELECT [RatingID],[RatingCategory],[RatingComment],[Constituent_ID],[RatingDate],[Inactive],[RatingSource],[RatingType],[RatingValue],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],@EndDate [RecordEndDate]
	FROM [ods].[BlackBaud_ratings] t
	UNION ALL
	SELECT [RatingID],[RatingCategory],[RatingComment],[Constituent_ID],[RatingDate],[Inactive],[RatingSource],[RatingType],[RatingValue],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate]
	FROM [ods].[Snapshot_BlackBaud_ratings]
	) a
WHERE
	@AsOfDate BETWEEN [ETL_UpdatedOn] AND [RecordEndDate]
	AND [ETL_CreatedOn] <= @AsOfDate

RETURN

END
GO
