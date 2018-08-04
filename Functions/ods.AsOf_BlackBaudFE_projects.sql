SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

/*
-- Get the status of your table 20 minutes ago...
DECLARE @AsOfDate DATETIME = (SELECT [etl].[ConvertToLocalTime](DATEADD(MINUTE,-20,GETDATE())))
SELECT * FROM [ods].[AsOf_BlackBaudFE_projects] (@AsOfDate)
*/

CREATE FUNCTION [ods].[AsOf_BlackBaudFE_projects] (@AsOfDate DATETIME)

RETURNS @Results TABLE
(
[project_id] [nvarchar](50) NULL,
[description] [nvarchar](max) NULL,
[ui_project_id] [nvarchar](100) NULL,
[start-date] [datetime2](7) NULL,
[end-date] [datetime2](7) NULL,
[location] [nvarchar](100) NULL,
[division] [nvarchar](100) NULL,
[department] [nvarchar](100) NULL,
[status] [nvarchar](25) NULL,
[date-added] [datetime2](7) NULL,
[date-modified] [datetime2](7) NULL,
[added-by] [nvarchar](50) NULL,
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
SELECT [project_id],[description],[ui_project_id],[start-date],[end-date],[location],[division],[department],[status],[date-added],[date-modified],[added-by],[modified-by],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy]
FROM
	(
	SELECT [project_id],[description],[ui_project_id],[start-date],[end-date],[location],[division],[department],[status],[date-added],[date-modified],[added-by],[modified-by],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],@EndDate [RecordEndDate]
	FROM [ods].[BlackBaudFE_projects] t
	UNION ALL
	SELECT [project_id],[description],[ui_project_id],[start-date],[end-date],[location],[division],[department],[status],[date-added],[date-modified],[added-by],[modified-by],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate]
	FROM [ods].[Snapshot_BlackBaudFE_projects]
	) a
WHERE
	@AsOfDate BETWEEN [ETL_UpdatedOn] AND [RecordEndDate]
	AND [ETL_CreatedOn] <= @AsOfDate

RETURN

END
GO
