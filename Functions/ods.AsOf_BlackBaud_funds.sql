SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

/*
-- Get the status of your table 20 minutes ago...
DECLARE @AsOfDate DATETIME = (SELECT [etl].[ConvertToLocalTime](DATEADD(MINUTE,-20,GETDATE())))
SELECT * FROM [ods].[AsOf_BlackBaud_funds] (@AsOfDate)
*/

CREATE FUNCTION [ods].[AsOf_BlackBaud_funds] (@AsOfDate DATETIME)

RETURNS @Results TABLE
(
[FundID] [int] NULL,
[DateAdded] [datetime2](7) NULL,
[DateModified] [datetime2](7) NULL,
[Description] [nvarchar](max) NULL,
[Inactive] [bit] NULL,
[LookupID] [nvarchar](250) NULL,
[StartDate] [datetime2](7) NULL,
[Category] [nvarchar](250) NULL,
[EndDate] [datetime2](7) NULL,
[GoalValue] [float] NULL,
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
SELECT [FundID],[DateAdded],[DateModified],[Description],[Inactive],[LookupID],[StartDate],[Category],[EndDate],[GoalValue],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy]
FROM
	(
	SELECT [FundID],[DateAdded],[DateModified],[Description],[Inactive],[LookupID],[StartDate],[Category],[EndDate],[GoalValue],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],@EndDate [RecordEndDate]
	FROM [ods].[BlackBaud_funds] t
	UNION ALL
	SELECT [FundID],[DateAdded],[DateModified],[Description],[Inactive],[LookupID],[StartDate],[Category],[EndDate],[GoalValue],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate]
	FROM [ods].[Snapshot_BlackBaud_funds]
	) a
WHERE
	@AsOfDate BETWEEN [ETL_UpdatedOn] AND [RecordEndDate]
	AND [ETL_CreatedOn] <= @AsOfDate

RETURN

END
GO
