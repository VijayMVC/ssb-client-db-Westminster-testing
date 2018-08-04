SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

/*
-- Get the status of your table 20 minutes ago...
DECLARE @AsOfDate DATETIME = (SELECT [etl].[ConvertToLocalTime](DATEADD(MINUTE,-20,GETDATE())))
SELECT * FROM [ods].[AsOf_BlackBaudFE_projects_project_Contacts_ContactMethods] (@AsOfDate)
*/

CREATE FUNCTION [ods].[AsOf_BlackBaudFE_projects_project_Contacts_ContactMethods] (@AsOfDate DATETIME)

RETURNS @Results TABLE
(
[project_id] [nvarchar](50) NULL,
[contacts_contact_id] [nvarchar](50) NULL,
[address_contact_methods_contact_method_id] [nvarchar](50) NULL,
[address_contact_methods_contact_type] [nvarchar](50) NULL,
[address_contact_methods_contact_info] [nvarchar](500) NULL,
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
SELECT [project_id],[contacts_contact_id],[address_contact_methods_contact_method_id],[address_contact_methods_contact_type],[address_contact_methods_contact_info],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy]
FROM
	(
	SELECT [project_id],[contacts_contact_id],[address_contact_methods_contact_method_id],[address_contact_methods_contact_type],[address_contact_methods_contact_info],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],@EndDate [RecordEndDate]
	FROM [ods].[BlackBaudFE_projects_project_Contacts_ContactMethods] t
	UNION ALL
	SELECT [project_id],[contacts_contact_id],[address_contact_methods_contact_method_id],[address_contact_methods_contact_type],[address_contact_methods_contact_info],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate]
	FROM [ods].[Snapshot_BlackBaudFE_projects_project_Contacts_ContactMethods]
	) a
WHERE
	@AsOfDate BETWEEN [ETL_UpdatedOn] AND [RecordEndDate]
	AND [ETL_CreatedOn] <= @AsOfDate

RETURN

END
GO
