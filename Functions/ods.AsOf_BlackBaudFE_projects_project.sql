SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

/*
-- Get the status of your table 20 minutes ago...
DECLARE @AsOfDate DATETIME = (SELECT [etl].[ConvertToLocalTime](DATEADD(MINUTE,-20,GETDATE())))
SELECT * FROM [ods].[AsOf_BlackBaudFE_projects_project] (@AsOfDate)
*/

CREATE FUNCTION [ods].[AsOf_BlackBaudFE_projects_project] (@AsOfDate DATETIME)

RETURNS @Results TABLE
(
[project_id] [nvarchar](50) NULL,
[description] [nvarchar](500) NULL,
[ui_project_id] [nvarchar](50) NULL,
[start_date] [datetime2](7) NULL,
[end_date] [datetime2](7) NULL,
[location] [nvarchar](100) NULL,
[division] [nvarchar](100) NULL,
[department] [nvarchar](100) NULL,
[type] [nvarchar](50) NULL,
[status] [nvarchar](50) NULL,
[prevent_data_entry] [nvarchar](10) NULL,
[prevent_posting_after] [nvarchar](10) NULL,
[posting_date] [datetime2](7) NULL,
[account_restrictions_allow_or_restrict] [nvarchar](25) NULL,
[account_restrictions_criteria] [nvarchar](25) NULL,
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
SELECT [project_id],[description],[ui_project_id],[start_date],[end_date],[location],[division],[department],[type],[status],[prevent_data_entry],[prevent_posting_after],[posting_date],[account_restrictions_allow_or_restrict],[account_restrictions_criteria],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy]
FROM
	(
	SELECT [project_id],[description],[ui_project_id],[start_date],[end_date],[location],[division],[department],[type],[status],[prevent_data_entry],[prevent_posting_after],[posting_date],[account_restrictions_allow_or_restrict],[account_restrictions_criteria],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],@EndDate [RecordEndDate]
	FROM [ods].[BlackBaudFE_projects_project] t
	UNION ALL
	SELECT [project_id],[description],[ui_project_id],[start_date],[end_date],[location],[division],[department],[type],[status],[prevent_data_entry],[prevent_posting_after],[posting_date],[account_restrictions_allow_or_restrict],[account_restrictions_criteria],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate]
	FROM [ods].[Snapshot_BlackBaudFE_projects_project]
	) a
WHERE
	@AsOfDate BETWEEN [ETL_UpdatedOn] AND [RecordEndDate]
	AND [ETL_CreatedOn] <= @AsOfDate

RETURN

END
GO
