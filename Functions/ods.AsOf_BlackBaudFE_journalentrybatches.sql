SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

/*
-- Get the status of your table 20 minutes ago...
DECLARE @AsOfDate DATETIME = (SELECT [etl].[ConvertToLocalTime](DATEADD(MINUTE,-20,GETDATE())))
SELECT * FROM [ods].[AsOf_BlackBaudFE_journalentrybatches] (@AsOfDate)
*/

CREATE FUNCTION [ods].[AsOf_BlackBaudFE_journalentrybatches] (@AsOfDate DATETIME)

RETURNS @Results TABLE
(
[batch_id] [nvarchar](50) NULL,
[ui_batch_id] [nvarchar](50) NULL,
[description] [nvarchar](max) NULL,
[batch-status] [nvarchar](25) NULL,
[create_interfund_sets] [nvarchar](10) NULL,
[create_bank_account_adjustments] [nvarchar](10) NULL,
[date_added] [datetime2](7) NULL,
[added_by] [nvarchar](50) NULL,
[date_modified] [datetime2](7) NULL,
[modified_by] [nvarchar](50) NULL,
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
SELECT [batch_id],[ui_batch_id],[description],[batch-status],[create_interfund_sets],[create_bank_account_adjustments],[date_added],[added_by],[date_modified],[modified_by],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy]
FROM
	(
	SELECT [batch_id],[ui_batch_id],[description],[batch-status],[create_interfund_sets],[create_bank_account_adjustments],[date_added],[added_by],[date_modified],[modified_by],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],@EndDate [RecordEndDate]
	FROM [ods].[BlackBaudFE_journalentrybatches] t
	UNION ALL
	SELECT [batch_id],[ui_batch_id],[description],[batch-status],[create_interfund_sets],[create_bank_account_adjustments],[date_added],[added_by],[date_modified],[modified_by],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate]
	FROM [ods].[Snapshot_BlackBaudFE_journalentrybatches]
	) a
WHERE
	@AsOfDate BETWEEN [ETL_UpdatedOn] AND [RecordEndDate]
	AND [ETL_CreatedOn] <= @AsOfDate

RETURN

END
GO
