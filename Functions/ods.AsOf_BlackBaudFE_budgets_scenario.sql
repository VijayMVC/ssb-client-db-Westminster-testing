SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

/*
-- Get the status of your table 20 minutes ago...
DECLARE @AsOfDate DATETIME = (SELECT [etl].[ConvertToLocalTime](DATEADD(MINUTE,-20,GETDATE())))
SELECT * FROM [ods].[AsOf_BlackBaudFE_budgets_scenario] (@AsOfDate)
*/

CREATE FUNCTION [ods].[AsOf_BlackBaudFE_budgets_scenario] (@AsOfDate DATETIME)

RETURNS @Results TABLE
(
[Budget_Scenario_ID] [nvarchar](50) NULL,
[fiscal_year] [nvarchar](50) NULL,
[fiscal_period] [nvarchar](10) NULL,
[category] [nvarchar](50) NULL,
[total_amount] [float] NULL,
[period_amount] [float] NULL,
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
SELECT [Budget_Scenario_ID],[fiscal_year],[fiscal_period],[category],[total_amount],[period_amount],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy]
FROM
	(
	SELECT [Budget_Scenario_ID],[fiscal_year],[fiscal_period],[category],[total_amount],[period_amount],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],@EndDate [RecordEndDate]
	FROM [ods].[BlackBaudFE_budgets_scenario] t
	UNION ALL
	SELECT [Budget_Scenario_ID],[fiscal_year],[fiscal_period],[category],[total_amount],[period_amount],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate]
	FROM [ods].[Snapshot_BlackBaudFE_budgets_scenario]
	) a
WHERE
	@AsOfDate BETWEEN [ETL_UpdatedOn] AND [RecordEndDate]
	AND [ETL_CreatedOn] <= @AsOfDate

RETURN

END
GO
