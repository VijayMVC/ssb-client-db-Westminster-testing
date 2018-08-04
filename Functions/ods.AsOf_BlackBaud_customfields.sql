SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

/*
-- Get the status of your table 20 minutes ago...
DECLARE @AsOfDate DATETIME = (SELECT [etl].[ConvertToLocalTime](DATEADD(MINUTE,-20,GETDATE())))
SELECT * FROM [ods].[AsOf_BlackBaud_customfields] (@AsOfDate)
*/

CREATE FUNCTION [ods].[AsOf_BlackBaud_customfields] (@AsOfDate DATETIME)

RETURNS @Results TABLE
(
[CustomField_id] [nvarchar](1000) NULL,
[parent_id] [nvarchar](1000) NULL,
[category] [nvarchar](1000) NULL,
[type] [nvarchar](1000) NULL,
[date] [nvarchar](1000) NULL,
[comment] [nvarchar](1000) NULL,
[customvalue] [nvarchar](1000) NULL,
[date-added] [nvarchar](1000) NULL,
[date-modified] [nvarchar](1000) NULL,
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
SELECT [CustomField_id],[parent_id],[category],[type],[date],[comment],[customvalue],[date-added],[date-modified],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy]
FROM
	(
	SELECT [CustomField_id],[parent_id],[category],[type],[date],[comment],[customvalue],[date-added],[date-modified],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],@EndDate [RecordEndDate]
	FROM [ods].[BlackBaud_customfields] t
	UNION ALL
	SELECT [CustomField_id],[parent_id],[category],[type],[date],[comment],[customvalue],[date-added],[date-modified],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate]
	FROM [ods].[Snapshot_BlackBaud_customfields]
	) a
WHERE
	@AsOfDate BETWEEN [ETL_UpdatedOn] AND [RecordEndDate]
	AND [ETL_CreatedOn] <= @AsOfDate

RETURN

END
GO
