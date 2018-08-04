SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE VIEW [preODS].[BlackBaud_phones]
AS

SELECT DISTINCT
	CONVERT(NVARCHAR(50),[Phoneid]) [Phoneid_K]
	,CONVERT(NVARCHAR(50),[constituent-id]) [constituent_id]
	,CONVERT(NVARCHAR(50),[type]) [type]
	,CONVERT(NVARCHAR(50),[number]) [number]
	,CONVERT(NVARCHAR(10),[do-not-call]) [do_not_call]
	,CONVERT(NVARCHAR(10),[primary]) [primary]
	,CONVERT(NVARCHAR(10),[inactive]) [inactive]
	,CONVERT(DATETIME2,[date-added]) [date_added]
	,CONVERT(DATETIME2,[date-modified]) [date_modified]
FROM [src].[BlackBaud_phones] WITH (NOLOCK)

GO
