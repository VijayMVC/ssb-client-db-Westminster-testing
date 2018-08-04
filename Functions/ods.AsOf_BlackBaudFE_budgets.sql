SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

/*
-- Get the status of your table 20 minutes ago...
DECLARE @AsOfDate DATETIME = (SELECT [etl].[ConvertToLocalTime](DATEADD(MINUTE,-20,GETDATE())))
SELECT * FROM [ods].[AsOf_BlackBaudFE_budgets] (@AsOfDate)
*/

CREATE FUNCTION [ods].[AsOf_BlackBaudFE_budgets] (@AsOfDate DATETIME)

RETURNS @Results TABLE
(
[budget_scenario_id] [nvarchar](50) NULL,
[description] [nvarchar](max) NULL,
[start-fiscal-year] [nvarchar](10) NULL,
[end-fiscal-year] [nvarchar](10) NULL,
[start-date] [datetime2](7) NULL,
[end-date] [datetime2](7) NULL,
[status] [nvarchar](25) NULL,
[budget-type] [nvarchar](50) NULL,
[locked] [nvarchar](10) NULL,
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
SELECT [budget_scenario_id],[description],[start-fiscal-year],[end-fiscal-year],[start-date],[end-date],[status],[budget-type],[locked],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy]
FROM
	(
	SELECT [budget_scenario_id],[description],[start-fiscal-year],[end-fiscal-year],[start-date],[end-date],[status],[budget-type],[locked],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],@EndDate [RecordEndDate]
	FROM [ods].[BlackBaudFE_budgets] t
	UNION ALL
	SELECT [budget_scenario_id],[description],[start-fiscal-year],[end-fiscal-year],[start-date],[end-date],[status],[budget-type],[locked],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate]
	FROM [ods].[Snapshot_BlackBaudFE_budgets]
	) a
WHERE
	@AsOfDate BETWEEN [ETL_UpdatedOn] AND [RecordEndDate]
	AND [ETL_CreatedOn] <= @AsOfDate

RETURN

END
GO
