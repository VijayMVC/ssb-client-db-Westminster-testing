SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE VIEW [preODS].[BlackBaud_gifts_fundraiser]
AS

SELECT DISTINCT
	CONVERT(NVARCHAR(50),[giftid]) [giftid_K]
	,CONVERT(NVARCHAR(50),[fundraisers_constituent-id]) [fundraisers_constituent-id_K]
	,CONVERT(float,[fundraisers_amount_value]) [fundraisers_amount_value]
FROM [src].[BlackBaud_gifts] WITH (NOLOCK) 
WHERE [fundraisers_constituent-id] IS NOT NULL 

GO
