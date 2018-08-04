SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



CREATE VIEW [preODS].[BlackBaud_gifts]
AS

SELECT DISTINCT
	CONVERT(NVARCHAR(50),[giftid]) [giftid_K]
	,CONVERT(DATETIME2,[date]) [date]
	,CONVERT(DATETIME2,[date-added]) [date_added]
	,CONVERT(DATETIME2,[date-modified]) [date_modified]
	,CONVERT(NVARCHAR(100),[type]) [type]
	,CONVERT(NVARCHAR(50),[constituent-id]) [constituent_id]
	,CONVERT(NVARCHAR(10),[is-anonymous]) [is_anonymous]
	,CONVERT(NVARCHAR(50),[post-status]) [post_status]
	,CONVERT(NVARCHAR(50),[gift-status]) [gift_status]
	,CONVERT(NVARCHAR(MAX),[reference]) [reference]
	,CONVERT(DATETIME2,[post-date]) [post_date]
	,CONVERT(NVARCHAR(250),[subtype]) [subtype]
	,CONVERT(FLOAT,[amount_value]) [amount_value]
	--,CONVERT(NVARCHAR(MAX),[gift-splits_fund-id]) [gift-splits_fund-id]
	--,CONVERT(NVARCHAR(MAX),[gift-splits_campaign-id]) [gift-splits_campaign-id]
	--,CONVERT(NVARCHAR(MAX),[gift-splits_appeal-id]) [gift-splits_appeal-id]
	--,CONVERT(NVARCHAR(MAX),[gift-splits_amount_value]) [gift-splits_amount_value]
	--,CONVERT(NVARCHAR(MAX),[soft-credits_constituent-id]) [soft-credits_constituent-id]
	--,CONVERT(NVARCHAR(MAX),[soft-credits_id]) [soft-credits_id]
	--,CONVERT(NVARCHAR(MAX),[soft-credits_gift-id]) [soft-credits_gift-id]
	--,CONVERT(NVARCHAR(MAX),[soft-credits_amount_value]) [soft-credits_amount_value]
	--,CONVERT(NVARCHAR(MAX),[fundraisers_constituent-id]) [fundraisers_constituent-id]
	--,CONVERT(NVARCHAR(MAX),[fundraisers_amount_value]) [fundraisers_amount_value]
FROM [src].[BlackBaud_gifts] WITH (NOLOCK) 
WHERE [amount_value] IS NOT NULL


GO
