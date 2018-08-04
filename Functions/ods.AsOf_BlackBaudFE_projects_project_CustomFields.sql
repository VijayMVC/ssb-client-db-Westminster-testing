SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

/*
-- Get the status of your table 20 minutes ago...
DECLARE @AsOfDate DATETIME = (SELECT [etl].[ConvertToLocalTime](DATEADD(MINUTE,-20,GETDATE())))
SELECT * FROM [ods].[AsOf_BlackBaudFE_projects_project_CustomFields] (@AsOfDate)
*/

CREATE FUNCTION [ods].[AsOf_BlackBaudFE_projects_project_CustomFields] (@AsOfDate DATETIME)

RETURNS @Results TABLE
(
[project_id] [nvarchar](50) NULL,
[custom_fields_custom_field_id] [nvarchar](50) NULL,
[custom_fields_field_name] [nvarchar](250) NULL,
[custom_fields_value] [nvarchar](500) NULL,
[custom_fields_comments] [nvarchar](max) NULL,
[custom_fields_type] [nvarchar](50) NULL,
[custom_fields_date] [datetime2](7) NULL,
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
SELECT [project_id],[custom_fields_custom_field_id],[custom_fields_field_name],[custom_fields_value],[custom_fields_comments],[custom_fields_type],[custom_fields_date],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy]
FROM
	(
	SELECT [project_id],[custom_fields_custom_field_id],[custom_fields_field_name],[custom_fields_value],[custom_fields_comments],[custom_fields_type],[custom_fields_date],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],@EndDate [RecordEndDate]
	FROM [ods].[BlackBaudFE_projects_project_CustomFields] t
	UNION ALL
	SELECT [project_id],[custom_fields_custom_field_id],[custom_fields_field_name],[custom_fields_value],[custom_fields_comments],[custom_fields_type],[custom_fields_date],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate]
	FROM [ods].[Snapshot_BlackBaudFE_projects_project_CustomFields]
	) a
WHERE
	@AsOfDate BETWEEN [ETL_UpdatedOn] AND [RecordEndDate]
	AND [ETL_CreatedOn] <= @AsOfDate

RETURN

END
GO
