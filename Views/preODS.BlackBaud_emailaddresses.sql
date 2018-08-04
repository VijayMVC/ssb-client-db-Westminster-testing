SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [preODS].[BlackBaud_emailaddresses]
AS

SELECT DISTINCT
	CONVERT(NVARCHAR(50),[Email_id]) [Email_id_K]
	,CONVERT(NVARCHAR(50),[constituent_id]) [constituent_id]
	,CONVERT(NVARCHAR(100),[type]) [type]
	,CONVERT(NVARCHAR(250),[address]) [address]
	,CONVERT(NVARCHAR(10),[do-not-email]) [do_not_email]
	,CONVERT(NVARCHAR(10),[primary]) [primary]
	,CONVERT(NVARCHAR(10),[inactive]) [inactive]
	,CONVERT(datetime2,[date-added]) [date_added]
	,CONVERT(datetime2,[date-modified]) [date_modified]
FROM [src].[BlackBaud_emailaddresses] WITH (NOLOCK)
GO
