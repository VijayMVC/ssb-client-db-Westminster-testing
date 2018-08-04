SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

/*
-- Get the status of your table 20 minutes ago...
DECLARE @AsOfDate DATETIME = (SELECT [etl].[ConvertToLocalTime](DATEADD(MINUTE,-20,GETDATE())))
SELECT * FROM [ods].[AsOf_BlackBaudFE_accounts_account] (@AsOfDate)
*/

CREATE FUNCTION [ods].[AsOf_BlackBaudFE_accounts_account] (@AsOfDate DATETIME)

RETURNS @Results TABLE
(
[Account_id] [nvarchar](50) NULL,
[account_number] [nvarchar](50) NULL,
[description] [nvarchar](500) NULL,
[prevent_data_entry] [nvarchar](10) NULL,
[prevent_posting_date] [nvarchar](50) NULL,
[class] [nvarchar](100) NULL,
[cashflow] [nvarchar](500) NULL,
[working_capital] [nvarchar](50) NULL,
[default_transaction_codes_name] [nvarchar](250) NULL,
[default_transaction_codes_value] [nvarchar](250) NULL,
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
SELECT [Account_id],[account_number],[description],[prevent_data_entry],[prevent_posting_date],[class],[cashflow],[working_capital],[default_transaction_codes_name],[default_transaction_codes_value],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy]
FROM
	(
	SELECT [Account_id],[account_number],[description],[prevent_data_entry],[prevent_posting_date],[class],[cashflow],[working_capital],[default_transaction_codes_name],[default_transaction_codes_value],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],@EndDate [RecordEndDate]
	FROM [ods].[BlackBaudFE_accounts_account] t
	UNION ALL
	SELECT [Account_id],[account_number],[description],[prevent_data_entry],[prevent_posting_date],[class],[cashflow],[working_capital],[default_transaction_codes_name],[default_transaction_codes_value],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate]
	FROM [ods].[Snapshot_BlackBaudFE_accounts_account]
	) a
WHERE
	@AsOfDate BETWEEN [ETL_UpdatedOn] AND [RecordEndDate]
	AND [ETL_CreatedOn] <= @AsOfDate

RETURN

END
GO
