SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

/*
-- Get the status of your table 20 minutes ago...
DECLARE @AsOfDate DATETIME = (SELECT [etl].[ConvertToLocalTime](DATEADD(MINUTE,-20,GETDATE())))
SELECT * FROM [ods].[AsOf_BlackBaud_constituents] (@AsOfDate)
*/

CREATE FUNCTION [ods].[AsOf_BlackBaud_constituents] (@AsOfDate DATETIME)

RETURNS @Results TABLE
(
[constituent_id] [nvarchar](50) NULL,
[type] [nvarchar](50) NULL,
[lookup_id] [nvarchar](50) NULL,
[inactive] [nvarchar](10) NULL,
[fullname] [nvarchar](250) NULL,
[gender] [nvarchar](20) NULL,
[deceased] [nvarchar](10) NULL,
[date_added] [datetime2](7) NULL,
[date_modified] [datetime2](7) NULL,
[gives_anonymously] [nvarchar](10) NULL,
[lastname] [nvarchar](100) NULL,
[firstname] [nvarchar](100) NULL,
[middlename] [nvarchar](50) NULL,
[preferred_name] [nvarchar](50) NULL,
[title] [nvarchar](50) NULL,
[marital_status] [nvarchar](50) NULL,
[age] [nvarchar](50) NULL,
[suffix] [nvarchar](50) NULL,
[address_id] [nvarchar](50) NULL,
[phone_id] [nvarchar](50) NULL,
[email_id] [nvarchar](50) NULL,
[birthdate_year] [nvarchar](10) NULL,
[birthdate_month] [nvarchar](10) NULL,
[birthdate_day] [nvarchar](10) NULL,
[spouse_id] [nvarchar](50) NULL,
[online_presence_id] [nvarchar](50) NULL,
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
SELECT [constituent_id],[type],[lookup_id],[inactive],[fullname],[gender],[deceased],[date_added],[date_modified],[gives_anonymously],[lastname],[firstname],[middlename],[preferred_name],[title],[marital_status],[age],[suffix],[address_id],[phone_id],[email_id],[birthdate_year],[birthdate_month],[birthdate_day],[spouse_id],[online_presence_id],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy]
FROM
	(
	SELECT [constituent_id],[type],[lookup_id],[inactive],[fullname],[gender],[deceased],[date_added],[date_modified],[gives_anonymously],[lastname],[firstname],[middlename],[preferred_name],[title],[marital_status],[age],[suffix],[address_id],[phone_id],[email_id],[birthdate_year],[birthdate_month],[birthdate_day],[spouse_id],[online_presence_id],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],@EndDate [RecordEndDate]
	FROM [ods].[BlackBaud_constituents] t
	UNION ALL
	SELECT [constituent_id],[type],[lookup_id],[inactive],[fullname],[gender],[deceased],[date_added],[date_modified],[gives_anonymously],[lastname],[firstname],[middlename],[preferred_name],[title],[marital_status],[age],[suffix],[address_id],[phone_id],[email_id],[birthdate_year],[birthdate_month],[birthdate_day],[spouse_id],[online_presence_id],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate]
	FROM [ods].[Snapshot_BlackBaud_constituents]
	) a
WHERE
	@AsOfDate BETWEEN [ETL_UpdatedOn] AND [RecordEndDate]
	AND [ETL_CreatedOn] <= @AsOfDate

RETURN

END
GO
