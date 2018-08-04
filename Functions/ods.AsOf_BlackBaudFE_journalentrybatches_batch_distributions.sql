SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

/*
-- Get the status of your table 20 minutes ago...
DECLARE @AsOfDate DATETIME = (SELECT [etl].[ConvertToLocalTime](DATEADD(MINUTE,-20,GETDATE())))
SELECT * FROM [ods].[AsOf_BlackBaudFE_journalentrybatches_batch_distributions] (@AsOfDate)
*/

CREATE FUNCTION [ods].[AsOf_BlackBaudFE_journalentrybatches_batch_distributions] (@AsOfDate DATETIME)

RETURNS @Results TABLE
(
[journal_entry_id] [nvarchar](50) NULL,
[distribution_id] [nvarchar](50) NULL,
[distributions_ui_project_id] [nvarchar](50) NULL,
[distributions_account_class] [nvarchar](250) NULL,
[distributions_amount] [float] NULL,
[distributions_percent] [float] NULL,
[distributions_transaction_code_values_name] [nvarchar](100) NULL,
[distributions_transaction_code_values_value] [nvarchar](250) NULL,
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
SELECT [journal_entry_id],[distribution_id],[distributions_ui_project_id],[distributions_account_class],[distributions_amount],[distributions_percent],[distributions_transaction_code_values_name],[distributions_transaction_code_values_value],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy]
FROM
	(
	SELECT [journal_entry_id],[distribution_id],[distributions_ui_project_id],[distributions_account_class],[distributions_amount],[distributions_percent],[distributions_transaction_code_values_name],[distributions_transaction_code_values_value],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],@EndDate [RecordEndDate]
	FROM [ods].[BlackBaudFE_journalentrybatches_batch_distributions] t
	UNION ALL
	SELECT [journal_entry_id],[distribution_id],[distributions_ui_project_id],[distributions_account_class],[distributions_amount],[distributions_percent],[distributions_transaction_code_values_name],[distributions_transaction_code_values_value],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate]
	FROM [ods].[Snapshot_BlackBaudFE_journalentrybatches_batch_distributions]
	) a
WHERE
	@AsOfDate BETWEEN [ETL_UpdatedOn] AND [RecordEndDate]
	AND [ETL_CreatedOn] <= @AsOfDate

RETURN

END
GO
