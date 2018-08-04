SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

/*
-- Get the status of your table 20 minutes ago...
DECLARE @AsOfDate DATETIME = (SELECT [etl].[ConvertToLocalTime](DATEADD(MINUTE,-20,GETDATE())))
SELECT * FROM [ods].[AsOf_Schoology_schools] (@AsOfDate)
*/

CREATE FUNCTION [ods].[AsOf_Schoology_schools] (@AsOfDate DATETIME)

RETURNS @Results TABLE
(
[schoolid] [nvarchar](50) NULL,
[title] [nvarchar](250) NULL,
[address1] [nvarchar](250) NULL,
[address2] [nvarchar](250) NULL,
[city] [nvarchar](100) NULL,
[state] [nvarchar](50) NULL,
[postal-code] [nvarchar](50) NULL,
[country] [nvarchar](50) NULL,
[website] [nvarchar](250) NULL,
[phone] [nvarchar](50) NULL,
[fax] [nvarchar](50) NULL,
[building-code] [nvarchar](50) NULL,
[picture-url] [nvarchar](250) NULL,
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
SELECT [schoolid],[title],[address1],[address2],[city],[state],[postal-code],[country],[website],[phone],[fax],[building-code],[picture-url],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy]
FROM
	(
	SELECT [schoolid],[title],[address1],[address2],[city],[state],[postal-code],[country],[website],[phone],[fax],[building-code],[picture-url],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],@EndDate [RecordEndDate]
	FROM [ods].[Schoology_schools] t
	UNION ALL
	SELECT [schoolid],[title],[address1],[address2],[city],[state],[postal-code],[country],[website],[phone],[fax],[building-code],[picture-url],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate]
	FROM [ods].[Snapshot_Schoology_schools]
	) a
WHERE
	@AsOfDate BETWEEN [ETL_UpdatedOn] AND [RecordEndDate]
	AND [ETL_CreatedOn] <= @AsOfDate

RETURN

END
GO
