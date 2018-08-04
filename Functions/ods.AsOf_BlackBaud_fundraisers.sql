SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

/*
-- Get the status of your table 20 minutes ago...
DECLARE @AsOfDate DATETIME = (SELECT [etl].[ConvertToLocalTime](DATEADD(MINUTE,-20,GETDATE())))
SELECT * FROM [ods].[AsOf_BlackBaud_fundraisers] (@AsOfDate)
*/

CREATE FUNCTION [ods].[AsOf_BlackBaud_fundraisers] (@AsOfDate DATETIME)

RETURNS @Results TABLE
(
[constituent_id] [nvarchar](50) NULL,
[FundRaiserCount] [nvarchar](50) NULL,
[FundRaiser_constituent_id] [nvarchar](50) NULL,
[FundRaiser_type] [nvarchar](100) NULL,
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
SELECT [constituent_id],[FundRaiserCount],[FundRaiser_constituent_id],[FundRaiser_type],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy]
FROM
	(
	SELECT [constituent_id],[FundRaiserCount],[FundRaiser_constituent_id],[FundRaiser_type],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],@EndDate [RecordEndDate]
	FROM [ods].[BlackBaud_fundraisers] t
	UNION ALL
	SELECT [constituent_id],[FundRaiserCount],[FundRaiser_constituent_id],[FundRaiser_type],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate]
	FROM [ods].[Snapshot_BlackBaud_fundraisers]
	) a
WHERE
	@AsOfDate BETWEEN [ETL_UpdatedOn] AND [RecordEndDate]
	AND [ETL_CreatedOn] <= @AsOfDate

RETURN

END
GO
