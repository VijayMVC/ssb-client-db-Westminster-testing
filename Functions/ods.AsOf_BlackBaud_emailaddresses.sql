SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

/*
-- Get the status of your table 20 minutes ago...
DECLARE @AsOfDate DATETIME = (SELECT [etl].[ConvertToLocalTime](DATEADD(MINUTE,-20,GETDATE())))
SELECT * FROM [ods].[AsOf_BlackBaud_emailaddresses] (@AsOfDate)
*/

CREATE FUNCTION [ods].[AsOf_BlackBaud_emailaddresses] (@AsOfDate DATETIME)

RETURNS @Results TABLE
(
[Email_id] [nvarchar](50) NULL,
[constituent_id] [nvarchar](50) NULL,
[type] [nvarchar](100) NULL,
[address] [nvarchar](250) NULL,
[do_not_email] [nvarchar](10) NULL,
[primary] [nvarchar](10) NULL,
[inactive] [nvarchar](10) NULL,
[date_added] [datetime2](7) NULL,
[date_modified] [datetime2](7) NULL,
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
SELECT [Email_id],[constituent_id],[type],[address],[do_not_email],[primary],[inactive],[date_added],[date_modified],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy]
FROM
	(
	SELECT [Email_id],[constituent_id],[type],[address],[do_not_email],[primary],[inactive],[date_added],[date_modified],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],@EndDate [RecordEndDate]
	FROM [ods].[BlackBaud_emailaddresses] t
	UNION ALL
	SELECT [Email_id],[constituent_id],[type],[address],[do_not_email],[primary],[inactive],[date_added],[date_modified],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate]
	FROM [ods].[Snapshot_BlackBaud_emailaddresses]
	) a
WHERE
	@AsOfDate BETWEEN [ETL_UpdatedOn] AND [RecordEndDate]
	AND [ETL_CreatedOn] <= @AsOfDate

RETURN

END
GO
