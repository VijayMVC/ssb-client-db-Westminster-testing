SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

/*
-- Get the status of your table 20 minutes ago...
DECLARE @AsOfDate DATETIME = (SELECT [etl].[ConvertToLocalTime](DATEADD(MINUTE,-20,GETDATE())))
SELECT * FROM [ods].[AsOf_BlackBaud_gifts_splits] (@AsOfDate)
*/

CREATE FUNCTION [ods].[AsOf_BlackBaud_gifts_splits] (@AsOfDate DATETIME)

RETURNS @Results TABLE
(
[giftid] [nvarchar](50) NULL,
[gift-splits_fund-id] [nvarchar](50) NULL,
[gift-splits_campaign-id] [nvarchar](50) NULL,
[gift-splits_appeal-id] [nvarchar](50) NULL,
[gift-splits_amount_value] [float] NULL,
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
SELECT [giftid],[gift-splits_fund-id],[gift-splits_campaign-id],[gift-splits_appeal-id],[gift-splits_amount_value],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy]
FROM
	(
	SELECT [giftid],[gift-splits_fund-id],[gift-splits_campaign-id],[gift-splits_appeal-id],[gift-splits_amount_value],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],@EndDate [RecordEndDate]
	FROM [ods].[BlackBaud_gifts_splits] t
	UNION ALL
	SELECT [giftid],[gift-splits_fund-id],[gift-splits_campaign-id],[gift-splits_appeal-id],[gift-splits_amount_value],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate]
	FROM [ods].[Snapshot_BlackBaud_gifts_splits]
	) a
WHERE
	@AsOfDate BETWEEN [ETL_UpdatedOn] AND [RecordEndDate]
	AND [ETL_CreatedOn] <= @AsOfDate

RETURN

END
GO
