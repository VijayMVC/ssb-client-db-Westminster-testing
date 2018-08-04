SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

/*
-- Get the status of your table 20 minutes ago...
DECLARE @AsOfDate DATETIME = (SELECT [etl].[ConvertToLocalTime](DATEADD(MINUTE,-20,GETDATE())))
SELECT * FROM [ods].[AsOf_BlackBaudFE_budgets_accounts] (@AsOfDate)
*/

CREATE FUNCTION [ods].[AsOf_BlackBaudFE_budgets_accounts] (@AsOfDate DATETIME)

RETURNS @Results TABLE
(
[Budget_scenario_ID] [nvarchar](50) NULL,
[budget_category] [nvarchar](50) NULL,
[account_number] [nvarchar](50) NULL,
[fiscal_year] [nvarchar](25) NULL,
[total_amount] [float] NULL,
[fiscal_period] [nvarchar](10) NULL,
[period_amount] [float] NULL,
[period_percent] [float] NULL,
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
SELECT [Budget_scenario_ID],[budget_category],[account_number],[fiscal_year],[total_amount],[fiscal_period],[period_amount],[period_percent],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy]
FROM
	(
	SELECT [Budget_scenario_ID],[budget_category],[account_number],[fiscal_year],[total_amount],[fiscal_period],[period_amount],[period_percent],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],@EndDate [RecordEndDate]
	FROM [ods].[BlackBaudFE_budgets_accounts] t
	UNION ALL
	SELECT [Budget_scenario_ID],[budget_category],[account_number],[fiscal_year],[total_amount],[fiscal_period],[period_amount],[period_percent],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate]
	FROM [ods].[Snapshot_BlackBaudFE_budgets_accounts]
	) a
WHERE
	@AsOfDate BETWEEN [ETL_UpdatedOn] AND [RecordEndDate]
	AND [ETL_CreatedOn] <= @AsOfDate

RETURN

END
GO
