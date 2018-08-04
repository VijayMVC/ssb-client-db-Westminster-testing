SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

/*
-- Get the status of your table 20 minutes ago...
DECLARE @AsOfDate DATETIME = (SELECT [etl].[ConvertToLocalTime](DATEADD(MINUTE,-20,GETDATE())))
SELECT * FROM [ods].[AsOf_SeniorSystems_studentSectionsByStudentId] (@AsOfDate)
*/

CREATE FUNCTION [ods].[AsOf_SeniorSystems_studentSectionsByStudentId] (@AsOfDate DATETIME)

RETURNS @Results TABLE
(
[StudentID] [nvarchar](50) NULL,
[SectionID] [nvarchar](50) NULL,
[WithdrawMarkingPeriod] [bit] NULL,
[CurrentYear] [int] NULL,
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
SELECT [StudentID],[SectionID],[WithdrawMarkingPeriod],[CurrentYear],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy]
FROM
	(
	SELECT [StudentID],[SectionID],[WithdrawMarkingPeriod],[CurrentYear],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],@EndDate [RecordEndDate]
	FROM [ods].[SeniorSystems_studentSectionsByStudentId] t
	UNION ALL
	SELECT [StudentID],[SectionID],[WithdrawMarkingPeriod],[CurrentYear],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate]
	FROM [ods].[Snapshot_SeniorSystems_studentSectionsByStudentId]
	) a
WHERE
	@AsOfDate BETWEEN [ETL_UpdatedOn] AND [RecordEndDate]
	AND [ETL_CreatedOn] <= @AsOfDate

RETURN

END
GO
