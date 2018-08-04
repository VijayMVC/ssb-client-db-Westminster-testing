SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

/*
-- Get the status of your table 20 minutes ago...
DECLARE @AsOfDate DATETIME = (SELECT [etl].[ConvertToLocalTime](DATEADD(MINUTE,-20,GETDATE())))
SELECT * FROM [ods].[AsOf_BlackBaudFE_accounts] (@AsOfDate)
*/

CREATE FUNCTION [ods].[AsOf_BlackBaudFE_accounts] (@AsOfDate DATETIME)

RETURNS @Results TABLE
(
[account_id] [nvarchar](50) NULL,
[account_number] [nvarchar](50) NULL,
[description] [nvarchar](max) NULL,
[date-added] [datetime2](7) NULL,
[added-by] [nvarchar](50) NULL,
[date-modified] [datetime2](7) NULL,
[modified-by] [nvarchar](50) NULL,
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
SELECT [account_id],[account_number],[description],[date-added],[added-by],[date-modified],[modified-by],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy]
FROM
	(
	SELECT [account_id],[account_number],[description],[date-added],[added-by],[date-modified],[modified-by],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],@EndDate [RecordEndDate]
	FROM [ods].[BlackBaudFE_accounts] t
	UNION ALL
	SELECT [account_id],[account_number],[description],[date-added],[added-by],[date-modified],[modified-by],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate]
	FROM [ods].[Snapshot_BlackBaudFE_accounts]
	) a
WHERE
	@AsOfDate BETWEEN [ETL_UpdatedOn] AND [RecordEndDate]
	AND [ETL_CreatedOn] <= @AsOfDate

RETURN

END
GO
