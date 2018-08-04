SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



CREATE VIEW [preODS].[BlackBaud_constituents_phone]
AS

SELECT DISTINCT
	CONVERT(NVARCHAR(50),[phone_id]) [phone_id_K]
	,CONVERT(NVARCHAR(50),[constituent_id]) [constituent_id]
	,CONVERT(NVARCHAR(50),[phone_type]) [phone_type]
	,CONVERT(NVARCHAR(50),[phone_number]) [phone_number]
	,CONVERT(NVARCHAR(10),[phone_do-not-call]) [phone_do_not_call]
	,CONVERT(NVARCHAR(10),[phone_primary]) [phone_primary]
FROM [src].[BlackBaud_constituents_phone] WITH (NOLOCK)
WHERE [phone_id] IS NOT NULL

GO
