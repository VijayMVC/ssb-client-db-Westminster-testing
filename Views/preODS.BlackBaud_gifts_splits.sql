SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE VIEW [preODS].[BlackBaud_gifts_splits]
AS

SELECT 
	CONVERT(NVARCHAR(50),[giftid]) [giftid_K]
	,CONVERT(NVARCHAR(50),[gift-splits_fund-id]) [FundID_K]
	,CONVERT(NVARCHAR(50),ISNULL([gift-splits_campaign-id],'')) [CampaignID_K]
	,CONVERT(NVARCHAR(50),ISNULL([gift-splits_appeal-id],'')) [AppealID_K]
	,CONVERT(FLOAT,[gift-splits_amount_value]) [amount_value]
FROM [src].[BlackBaud_gifts] WITH (NOLOCK) 
WHERE [gift-splits_fund-id] IS NOT NULL 


GO
