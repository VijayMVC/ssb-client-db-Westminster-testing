SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE VIEW [preODS].[BlackBaud_gifts_softcredit]
AS

SELECT DISTINCT
	CONVERT(NVARCHAR(50),[giftid]) [giftid_K]
	,CONVERT(NVARCHAR(50),[soft-credits_id]) [soft-credits_id_K]
	,CONVERT(NVARCHAR(50),[soft-credits_constituent-id]) [soft-credits_constituent-id]
	,CONVERT(NVARCHAR(50),[soft-credits_gift-id]) [soft-credits_gift-id]
	,CONVERT(float,[soft-credits_amount_value]) [soft-credits_amount_value]
	--,CONVERT(NVARCHAR(MAX),[fundraisers_constituent-id]) [fundraisers_constituent-id]
	--,CONVERT(NVARCHAR(MAX),[fundraisers_amount_value]) [fundraisers_amount_value]
FROM [src].[BlackBaud_gifts] WITH (NOLOCK) 
WHERE [soft-credits_id] IS NOT NULL 

GO
