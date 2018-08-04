SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

/*
-- Get the status of your table 20 minutes ago...
DECLARE @AsOfDate DATETIME = (SELECT [etl].[ConvertToLocalTime](DATEADD(MINUTE,-20,GETDATE())))
SELECT * FROM [ods].[AsOf_BlackBaudFE_projects_project_Contacts] (@AsOfDate)
*/

CREATE FUNCTION [ods].[AsOf_BlackBaudFE_projects_project_Contacts] (@AsOfDate DATETIME)

RETURNS @Results TABLE
(
[project_id] [nvarchar](50) NULL,
[contacts_contact_id] [nvarchar](50) NULL,
[contacts_description] [nvarchar](500) NULL,
[contacts_country] [nvarchar](50) NULL,
[contacts_city] [nvarchar](100) NULL,
[contacts_county] [nvarchar](100) NULL,
[contacts_state] [nvarchar](50) NULL,
[contacts_address_line] [nvarchar](250) NULL,
[contacts_postal] [nvarchar](25) NULL,
[contacts_title] [nvarchar](50) NULL,
[contacts_first_name] [nvarchar](100) NULL,
[contacts_middle_name] [nvarchar](100) NULL,
[contacts_last_name] [nvarchar](100) NULL,
[contacts_suffix] [nvarchar](25) NULL,
[contacts_position] [nvarchar](100) NULL,
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
SELECT [project_id],[contacts_contact_id],[contacts_description],[contacts_country],[contacts_city],[contacts_county],[contacts_state],[contacts_address_line],[contacts_postal],[contacts_title],[contacts_first_name],[contacts_middle_name],[contacts_last_name],[contacts_suffix],[contacts_position],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy]
FROM
	(
	SELECT [project_id],[contacts_contact_id],[contacts_description],[contacts_country],[contacts_city],[contacts_county],[contacts_state],[contacts_address_line],[contacts_postal],[contacts_title],[contacts_first_name],[contacts_middle_name],[contacts_last_name],[contacts_suffix],[contacts_position],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],@EndDate [RecordEndDate]
	FROM [ods].[BlackBaudFE_projects_project_Contacts] t
	UNION ALL
	SELECT [project_id],[contacts_contact_id],[contacts_description],[contacts_country],[contacts_city],[contacts_county],[contacts_state],[contacts_address_line],[contacts_postal],[contacts_title],[contacts_first_name],[contacts_middle_name],[contacts_last_name],[contacts_suffix],[contacts_position],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate]
	FROM [ods].[Snapshot_BlackBaudFE_projects_project_Contacts]
	) a
WHERE
	@AsOfDate BETWEEN [ETL_UpdatedOn] AND [RecordEndDate]
	AND [ETL_CreatedOn] <= @AsOfDate

RETURN

END
GO
