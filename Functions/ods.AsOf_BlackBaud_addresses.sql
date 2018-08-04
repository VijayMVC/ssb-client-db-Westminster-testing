SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

/*
-- Get the status of your table 20 minutes ago...
DECLARE @AsOfDate DATETIME = (SELECT [etl].[ConvertToLocalTime](DATEADD(MINUTE,-20,GETDATE())))
SELECT * FROM [ods].[AsOf_BlackBaud_addresses] (@AsOfDate)
*/

CREATE FUNCTION [ods].[AsOf_BlackBaud_addresses] (@AsOfDate DATETIME)

RETURNS @Results TABLE
(
[address_id] [nvarchar](50) NULL,
[constituent_id] [nvarchar](50) NULL,
[type] [nvarchar](50) NULL,
[formatted_address] [nvarchar](max) NULL,
[preferred] [nvarchar](10) NULL,
[inactive] [nvarchar](10) NULL,
[do_not_mail] [nvarchar](10) NULL,
[address_lines] [nvarchar](2000) NULL,
[city] [nvarchar](250) NULL,
[date_added] [datetime2](7) NULL,
[date_modified] [datetime2](7) NULL,
[state] [nvarchar](50) NULL,
[postal_code] [nvarchar](50) NULL,
[county] [nvarchar](100) NULL,
[country] [nvarchar](100) NULL,
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
SELECT [address_id],[constituent_id],[type],[formatted_address],[preferred],[inactive],[do_not_mail],[address_lines],[city],[date_added],[date_modified],[state],[postal_code],[county],[country],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy]
FROM
	(
	SELECT [address_id],[constituent_id],[type],[formatted_address],[preferred],[inactive],[do_not_mail],[address_lines],[city],[date_added],[date_modified],[state],[postal_code],[county],[country],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],@EndDate [RecordEndDate]
	FROM [ods].[BlackBaud_addresses] t
	UNION ALL
	SELECT [address_id],[constituent_id],[type],[formatted_address],[preferred],[inactive],[do_not_mail],[address_lines],[city],[date_added],[date_modified],[state],[postal_code],[county],[country],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate]
	FROM [ods].[Snapshot_BlackBaud_addresses]
	) a
WHERE
	@AsOfDate BETWEEN [ETL_UpdatedOn] AND [RecordEndDate]
	AND [ETL_CreatedOn] <= @AsOfDate

RETURN

END
GO
