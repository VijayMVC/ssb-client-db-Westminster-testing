SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [preODS].[BlackBaud_constituents_onlinepresence]
AS

SELECT DISTINCT
	CONVERT(NVARCHAR(50),[online-presence_id]) [online-presence_id_K]
	,CONVERT(NVARCHAR(50),[constituent_id]) [constituent_id]
	,CONVERT(NVARCHAR(50),[online-presence_type]) [online-presence_type]
	,CONVERT(NVARCHAR(500),[online-presence_address]) [online-presence_address]
	,CONVERT(NVARCHAR(10),[online-presence_primary]) [online-presence_primary]
FROM [src].[BlackBaud_constituents_onlinepresence] WITH (NOLOCK)
WHERE [online-presence_id] is not null
GO
