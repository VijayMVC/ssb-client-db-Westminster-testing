SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE VIEW [preODS].[BlackBaud_fundraisers]
AS

SELECT DISTINCT
	CONVERT(NVARCHAR(50),[ETL__multi_query_value_for_audit]) constituent_id_K
	--,CONVERT(NVARCHAR(MAX),[SK]) [SK]
	,CONVERT(NVARCHAR(50),[FundRaiserCount]) [FundRaiserCount]
	,CONVERT(NVARCHAR(50),[constituent_id]) [FundRaiser_constituent_id_K]
	,CONVERT(NVARCHAR(100),ISNULL([type],'') )[FundRaiser_type_K]
FROM [src].[BlackBaud_fundraisers] WITH (NOLOCK)
WHERE constituent_id IS NOT NULL

GO
