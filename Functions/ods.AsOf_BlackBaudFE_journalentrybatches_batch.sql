SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

/*
-- Get the status of your table 20 minutes ago...
DECLARE @AsOfDate DATETIME = (SELECT [etl].[ConvertToLocalTime](DATEADD(MINUTE,-20,GETDATE())))
SELECT * FROM [ods].[AsOf_BlackBaudFE_journalentrybatches_batch] (@AsOfDate)
*/

CREATE FUNCTION [ods].[AsOf_BlackBaudFE_journalentrybatches_batch] (@AsOfDate DATETIME)

RETURNS @Results TABLE
(
[journal_entry_id] [nvarchar](50) NULL,
[batch_id] [nvarchar](50) NULL,
[ui_batch_id] [nvarchar](50) NULL,
[type_code] [nvarchar](50) NULL,
[line_number] [int] NULL,
[account_number] [nvarchar](50) NULL,
[post_date] [datetime2](7) NULL,
[encumbrance] [nvarchar](50) NULL,
[journal] [nvarchar](50) NULL,
[reference] [nvarchar](max) NULL,
[amount] [float] NULL,
[notes] [nvarchar](max) NULL,
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
SELECT [journal_entry_id],[batch_id],[ui_batch_id],[type_code],[line_number],[account_number],[post_date],[encumbrance],[journal],[reference],[amount],[notes],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy]
FROM
	(
	SELECT [journal_entry_id],[batch_id],[ui_batch_id],[type_code],[line_number],[account_number],[post_date],[encumbrance],[journal],[reference],[amount],[notes],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],@EndDate [RecordEndDate]
	FROM [ods].[BlackBaudFE_journalentrybatches_batch] t
	UNION ALL
	SELECT [journal_entry_id],[batch_id],[ui_batch_id],[type_code],[line_number],[account_number],[post_date],[encumbrance],[journal],[reference],[amount],[notes],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate]
	FROM [ods].[Snapshot_BlackBaudFE_journalentrybatches_batch]
	) a
WHERE
	@AsOfDate BETWEEN [ETL_UpdatedOn] AND [RecordEndDate]
	AND [ETL_CreatedOn] <= @AsOfDate

RETURN

END
GO
