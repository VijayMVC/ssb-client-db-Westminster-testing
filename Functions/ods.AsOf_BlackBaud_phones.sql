SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

/*
-- Get the status of your table 20 minutes ago...
DECLARE @AsOfDate DATETIME = (SELECT [etl].[ConvertToLocalTime](DATEADD(MINUTE,-20,GETDATE())))
SELECT * FROM [ods].[AsOf_BlackBaud_phones] (@AsOfDate)
*/

CREATE FUNCTION [ods].[AsOf_BlackBaud_phones] (@AsOfDate DATETIME)

RETURNS @Results TABLE
(
[Phoneid] [nvarchar](50) NULL,
[constituent_id] [nvarchar](50) NULL,
[type] [nvarchar](50) NULL,
[number] [nvarchar](50) NULL,
[do_not_call] [nvarchar](10) NULL,
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
SELECT [Phoneid],[constituent_id],[type],[number],[do_not_call],[primary],[inactive],[date_added],[date_modified],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy]
FROM
	(
	SELECT [Phoneid],[constituent_id],[type],[number],[do_not_call],[primary],[inactive],[date_added],[date_modified],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],@EndDate [RecordEndDate]
	FROM [ods].[BlackBaud_phones] t
	UNION ALL
	SELECT [Phoneid],[constituent_id],[type],[number],[do_not_call],[primary],[inactive],[date_added],[date_modified],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate]
	FROM [ods].[Snapshot_BlackBaud_phones]
	) a
WHERE
	@AsOfDate BETWEEN [ETL_UpdatedOn] AND [RecordEndDate]
	AND [ETL_CreatedOn] <= @AsOfDate

RETURN

END
GO
