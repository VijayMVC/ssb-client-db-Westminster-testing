SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [preODS].[BlackBaud_gifts_customfields]
AS

SELECT DISTINCT
	CONVERT(NVARCHAR(50),[GiftCustom_id]) [GiftCustom_id_K]
	,CONVERT(int,[GIftCustomFieldCount]) [GIftCustomFieldCount]	
	,CONVERT(NVARCHAR(50),[Constituent_id]) [Constituent_id]
	,CONVERT(NVARCHAR(100),[category]) [category]
	,CONVERT(NVARCHAR(100),[type]) [type]
	,CONVERT(NVARCHAR(MAX),[valuetext]) [valuetext]
	,CONVERT(datetime2,[date]) [date]
	,CONVERT(NVARCHAR(MAX),[comment]) [comment]
FROM [src].[BlackBaud_gifts_customfields] WITH (NOLOCK)
where GiftCustom_id is not null
GO
