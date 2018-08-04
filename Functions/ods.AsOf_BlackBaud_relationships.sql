SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

/*
-- Get the status of your table 20 minutes ago...
DECLARE @AsOfDate DATETIME = (SELECT [etl].[ConvertToLocalTime](DATEADD(MINUTE,-20,GETDATE())))
SELECT * FROM [ods].[AsOf_BlackBaud_relationships] (@AsOfDate)
*/

CREATE FUNCTION [ods].[AsOf_BlackBaud_relationships] (@AsOfDate DATETIME)

RETURNS @Results TABLE
(
[Relationship_id] [nvarchar](50) NULL,
[Relationship_count] [int] NULL,
[constituent_id] [nvarchar](50) NULL,
[relation_id] [nvarchar](50) NULL,
[name] [nvarchar](500) NULL,
[type] [nvarchar](100) NULL,
[reciprocal_type] [nvarchar](100) NULL,
[is_spouse] [nvarchar](10) NULL,
[is_organization_contact] [nvarchar](10) NULL,
[is_primary_business] [nvarchar](10) NULL,
[position] [nvarchar](250) NULL,
[comment] [nvarchar](max) NULL,
[organization_contact_type] [nvarchar](50) NULL,
[Start_Date] [date] NULL,
[End_Date] [date] NULL,
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
SELECT [Relationship_id],[Relationship_count],[constituent_id],[relation_id],[name],[type],[reciprocal_type],[is_spouse],[is_organization_contact],[is_primary_business],[position],[comment],[organization_contact_type],[Start_Date],[End_Date],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy]
FROM
	(
	SELECT [Relationship_id],[Relationship_count],[constituent_id],[relation_id],[name],[type],[reciprocal_type],[is_spouse],[is_organization_contact],[is_primary_business],[position],[comment],[organization_contact_type],[Start_Date],[End_Date],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],@EndDate [RecordEndDate]
	FROM [ods].[BlackBaud_relationships] t
	UNION ALL
	SELECT [Relationship_id],[Relationship_count],[constituent_id],[relation_id],[name],[type],[reciprocal_type],[is_spouse],[is_organization_contact],[is_primary_business],[position],[comment],[organization_contact_type],[Start_Date],[End_Date],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate]
	FROM [ods].[Snapshot_BlackBaud_relationships]
	) a
WHERE
	@AsOfDate BETWEEN [ETL_UpdatedOn] AND [RecordEndDate]
	AND [ETL_CreatedOn] <= @AsOfDate

RETURN

END
GO
