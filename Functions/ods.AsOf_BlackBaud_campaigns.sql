SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

/*
-- Get the status of your table 20 minutes ago...
DECLARE @AsOfDate DATETIME = (SELECT [etl].[ConvertToLocalTime](DATEADD(MINUTE,-20,GETDATE())))
SELECT * FROM [ods].[AsOf_BlackBaud_campaigns] (@AsOfDate)
*/

CREATE FUNCTION [ods].[AsOf_BlackBaud_campaigns] (@AsOfDate DATETIME)

RETURNS @Results TABLE
(
[CampaingID] [int] NULL,
[DateAdded] [datetime2](7) NULL,
[DateModified] [datetime2](7) NULL,
[Description] [nvarchar](max) NULL,
[Inactive] [bit] NULL,
[lookupID] [nvarchar](50) NULL,
[StartDate] [datetime2](7) NULL,
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
SELECT [CampaingID],[DateAdded],[DateModified],[Description],[Inactive],[lookupID],[StartDate],[GoalValue],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy]
FROM
	(
	SELECT [CampaingID],[DateAdded],[DateModified],[Description],[Inactive],[lookupID],[StartDate],[GoalValue],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],@EndDate [RecordEndDate]
	FROM [ods].[BlackBaud_campaigns] t
	UNION ALL
	SELECT [CampaingID],[DateAdded],[DateModified],[Description],[Inactive],[lookupID],[StartDate],[GoalValue],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate]
	FROM [ods].[Snapshot_BlackBaud_campaigns]
	) a
WHERE
	@AsOfDate BETWEEN [ETL_UpdatedOn] AND [RecordEndDate]
	AND [ETL_CreatedOn] <= @AsOfDate

RETURN

END
GO
