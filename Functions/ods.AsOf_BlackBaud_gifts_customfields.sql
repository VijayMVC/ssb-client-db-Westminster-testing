SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

/*
-- Get the status of your table 20 minutes ago...
DECLARE @AsOfDate DATETIME = (SELECT [etl].[ConvertToLocalTime](DATEADD(MINUTE,-20,GETDATE())))
SELECT * FROM [ods].[AsOf_BlackBaud_gifts_customfields] (@AsOfDate)
*/

CREATE FUNCTION [ods].[AsOf_BlackBaud_gifts_customfields] (@AsOfDate DATETIME)

RETURNS @Results TABLE
(
[GiftCustom_id] [nvarchar](50) NULL,
[GIftCustomFieldCount] [int] NULL,
[Constituent_id] [nvarchar](50) NULL,
[category] [nvarchar](100) NULL,
[type] [nvarchar](100) NULL,
[valuetext] [nvarchar](max) NULL,
[date] [datetime2](7) NULL,
[comment] [nvarchar](max) NULL,
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
SELECT [GiftCustom_id],[GIftCustomFieldCount],[Constituent_id],[category],[type],[valuetext],[date],[comment],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy]
FROM
	(
	SELECT [GiftCustom_id],[GIftCustomFieldCount],[Constituent_id],[category],[type],[valuetext],[date],[comment],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],@EndDate [RecordEndDate]
	FROM [ods].[BlackBaud_gifts_customfields] t
	UNION ALL
	SELECT [GiftCustom_id],[GIftCustomFieldCount],[Constituent_id],[category],[type],[valuetext],[date],[comment],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate]
	FROM [ods].[Snapshot_BlackBaud_gifts_customfields]
	) a
WHERE
	@AsOfDate BETWEEN [ETL_UpdatedOn] AND [RecordEndDate]
	AND [ETL_CreatedOn] <= @AsOfDate

RETURN

END
GO
