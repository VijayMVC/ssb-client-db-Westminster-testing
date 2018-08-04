SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

/*
-- Get the status of your table 20 minutes ago...
DECLARE @AsOfDate DATETIME = (SELECT [etl].[ConvertToLocalTime](DATEADD(MINUTE,-20,GETDATE())))
SELECT * FROM [ods].[AsOf_BlackBaudFE_vendors] (@AsOfDate)
*/

CREATE FUNCTION [ods].[AsOf_BlackBaudFE_vendors] (@AsOfDate DATETIME)

RETURNS @Results TABLE
(
[vendor_id] [nvarchar](1000) NULL,
[vendor-name] [nvarchar](1000) NULL,
[balance-due] [nvarchar](1000) NULL,
[ui-defined-id] [nvarchar](1000) NULL,
[customer-number] [nvarchar](1000) NULL,
[vendor-status] [nvarchar](1000) NULL,
[issue-1099s] [nvarchar](1000) NULL,
[payment-method] [nvarchar](1000) NULL,
[address-id] [nvarchar](1000) NULL,
[description] [nvarchar](1000) NULL,
[country] [nvarchar](1000) NULL,
[city] [nvarchar](1000) NULL,
[county] [nvarchar](1000) NULL,
[state] [nvarchar](1000) NULL,
[postal] [nvarchar](1000) NULL,
[address-line] [nvarchar](1000) NULL,
[is-primary] [nvarchar](1000) NULL,
[is-invoices] [nvarchar](1000) NULL,
[is-pos] [nvarchar](1000) NULL,
[is-1099] [nvarchar](1000) NULL,
[title] [nvarchar](1000) NULL,
[first-name] [nvarchar](1000) NULL,
[middle-name] [nvarchar](1000) NULL,
[last-name] [nvarchar](1000) NULL,
[suffix] [nvarchar](1000) NULL,
[position] [nvarchar](1000) NULL,
[address-contact-methods] [nvarchar](1000) NULL,
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
SELECT [vendor_id],[vendor-name],[balance-due],[ui-defined-id],[customer-number],[vendor-status],[issue-1099s],[payment-method],[address-id],[description],[country],[city],[county],[state],[postal],[address-line],[is-primary],[is-invoices],[is-pos],[is-1099],[title],[first-name],[middle-name],[last-name],[suffix],[position],[address-contact-methods],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy]
FROM
	(
	SELECT [vendor_id],[vendor-name],[balance-due],[ui-defined-id],[customer-number],[vendor-status],[issue-1099s],[payment-method],[address-id],[description],[country],[city],[county],[state],[postal],[address-line],[is-primary],[is-invoices],[is-pos],[is-1099],[title],[first-name],[middle-name],[last-name],[suffix],[position],[address-contact-methods],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],@EndDate [RecordEndDate]
	FROM [ods].[BlackBaudFE_vendors] t
	UNION ALL
	SELECT [vendor_id],[vendor-name],[balance-due],[ui-defined-id],[customer-number],[vendor-status],[issue-1099s],[payment-method],[address-id],[description],[country],[city],[county],[state],[postal],[address-line],[is-primary],[is-invoices],[is-pos],[is-1099],[title],[first-name],[middle-name],[last-name],[suffix],[position],[address-contact-methods],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate]
	FROM [ods].[Snapshot_BlackBaudFE_vendors]
	) a
WHERE
	@AsOfDate BETWEEN [ETL_UpdatedOn] AND [RecordEndDate]
	AND [ETL_CreatedOn] <= @AsOfDate

RETURN

END
GO
