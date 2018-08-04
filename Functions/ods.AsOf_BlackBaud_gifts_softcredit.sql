SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

/*
-- Get the status of your table 20 minutes ago...
DECLARE @AsOfDate DATETIME = (SELECT [etl].[ConvertToLocalTime](DATEADD(MINUTE,-20,GETDATE())))
SELECT * FROM [ods].[AsOf_BlackBaud_gifts_softcredit] (@AsOfDate)
*/

CREATE FUNCTION [ods].[AsOf_BlackBaud_gifts_softcredit] (@AsOfDate DATETIME)

RETURNS @Results TABLE
(
[giftid] [nvarchar](50) NULL,
[soft-credits_id] [nvarchar](50) NULL,
[soft-credits_constituent-id] [nvarchar](50) NULL,
[soft-credits_gift-id] [nvarchar](50) NULL,
[soft-credits_amount_value] [float] NULL,
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
SELECT [giftid],[soft-credits_id],[soft-credits_constituent-id],[soft-credits_gift-id],[soft-credits_amount_value],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy]
FROM
	(
	SELECT [giftid],[soft-credits_id],[soft-credits_constituent-id],[soft-credits_gift-id],[soft-credits_amount_value],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],@EndDate [RecordEndDate]
	FROM [ods].[BlackBaud_gifts_softcredit] t
	UNION ALL
	SELECT [giftid],[soft-credits_id],[soft-credits_constituent-id],[soft-credits_gift-id],[soft-credits_amount_value],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate]
	FROM [ods].[Snapshot_BlackBaud_gifts_softcredit]
	) a
WHERE
	@AsOfDate BETWEEN [ETL_UpdatedOn] AND [RecordEndDate]
	AND [ETL_CreatedOn] <= @AsOfDate

RETURN

END
GO
