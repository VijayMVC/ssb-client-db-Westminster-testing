SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

/*
-- Get the status of your table 20 minutes ago...
DECLARE @AsOfDate DATETIME = (SELECT [etl].[ConvertToLocalTime](DATEADD(MINUTE,-20,GETDATE())))
SELECT * FROM [ods].[AsOf_BlackBaud_constituentcodes] (@AsOfDate)
*/

CREATE FUNCTION [ods].[AsOf_BlackBaud_constituentcodes] (@AsOfDate DATETIME)

RETURNS @Results TABLE
(
[constiuent_code_id] [nvarchar](50) NULL,
[constituent_id] [nvarchar](50) NULL,
[description] [nvarchar](250) NULL,
[date_added] [DATETIME2](7) NULL,
[date_modified] [DATETIME2](7) NULL,
[inactive] [NVARCHAR](10) NULL,
[StartDate] [DATE] NULL,
[EndDate] [DATE] NULL,
[ETL_CreatedOn] [DATETIME] NOT NULL,
[ETL_CreatedBy] NVARCHAR(400) NOT NULL,
[ETL_UpdatedOn] [DATETIME] NOT NULL,
[ETL_UpdatedBy] NVARCHAR(400) NOT NULL
)

AS
BEGIN

DECLARE @EndDate DATETIME = (SELECT [etl].[ConvertToLocalTime](CAST(GETDATE() AS DATETIME2(0))))
SET @AsOfDate = (SELECT CAST(@AsOfDate AS DATETIME2(0)))

INSERT INTO @Results
SELECT [constiuent_code_id],[constituent_id],[description],[date_added],[date_modified],[inactive],[StartDate],[EndDate],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy]
FROM
	(
	SELECT [constiuent_code_id],[constituent_id],[description],[date_added],[date_modified],[inactive],[StartDate],[EndDate],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],@EndDate [RecordEndDate]
	FROM [ods].[BlackBaud_constituentcodes] t
	UNION ALL
	SELECT [constiuent_code_id],[constituent_id],[description],[date_added],[date_modified],[inactive],[StartDate],[EndDate],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate]
	FROM [ods].[Snapshot_BlackBaud_constituentcodes]
	) a
WHERE
	@AsOfDate BETWEEN [ETL_UpdatedOn] AND [RecordEndDate]
	AND [ETL_CreatedOn] <= @AsOfDate

RETURN

END
GO
