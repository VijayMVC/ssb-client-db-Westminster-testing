SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

/*
-- Get the status of your table 20 minutes ago...
DECLARE @AsOfDate DATETIME = (SELECT [etl].[ConvertToLocalTime](DATEADD(MINUTE,-20,GETDATE())))
SELECT * FROM [ods].[AsOf_BlackBaud_constituents_onlinepresence] (@AsOfDate)
*/

CREATE FUNCTION [ods].[AsOf_BlackBaud_constituents_onlinepresence] (@AsOfDate DATETIME)

RETURNS @Results TABLE
(
[online-presence_id] [nvarchar](50) NULL,
[constituent_id] [nvarchar](50) NULL,
[online-presence_type] [nvarchar](50) NULL,
[online-presence_address] [nvarchar](500) NULL,
[online-presence_primary] [nvarchar](10) NULL,
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
SELECT [online-presence_id],[constituent_id],[online-presence_type],[online-presence_address],[online-presence_primary],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy]
FROM
	(
	SELECT [online-presence_id],[constituent_id],[online-presence_type],[online-presence_address],[online-presence_primary],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],@EndDate [RecordEndDate]
	FROM [ods].[BlackBaud_constituents_onlinepresence] t
	UNION ALL
	SELECT [online-presence_id],[constituent_id],[online-presence_type],[online-presence_address],[online-presence_primary],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate]
	FROM [ods].[Snapshot_BlackBaud_constituents_onlinepresence]
	) a
WHERE
	@AsOfDate BETWEEN [ETL_UpdatedOn] AND [RecordEndDate]
	AND [ETL_CreatedOn] <= @AsOfDate

RETURN

END
GO
