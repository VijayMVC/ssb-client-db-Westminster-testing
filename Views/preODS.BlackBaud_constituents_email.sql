SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



CREATE VIEW [preODS].[BlackBaud_constituents_email]
AS

SELECT DISTINCT
	CONVERT(NVARCHAR(50),[email_id]) [email_id_k]
	,CONVERT(NVARCHAR(50),[constituent_id]) [constituent_id]
	,CONVERT(NVARCHAR(50),[email_type]) [email_type]
	,CONVERT(NVARCHAR(255),[email_address]) [email_address]
	,CONVERT(NVARCHAR(10),[email_do-not-email]) [email_do_not_email]
	,CONVERT(NVARCHAR(10),[email_primary]) [email_primary]
FROM [src].[BlackBaud_constituents_email] WITH (NOLOCK)
WHERE [email_id] IS NOT NULL

GO
