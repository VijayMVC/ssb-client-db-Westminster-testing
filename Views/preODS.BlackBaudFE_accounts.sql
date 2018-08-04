SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [preODS].[BlackBaudFE_accounts]
AS

SELECT DISTINCT
	CONVERT(NVARCHAR(50),[account_id]) [account_id_k]
	,CONVERT(NVARCHAR(50),[account-number]) [account_number]
	,CONVERT(NVARCHAR(MAX),[description]) [description]
	,CONVERT(DATETIME2,[date-added]) [date-added]
	,CONVERT(NVARCHAR(50),[added-by]) [added-by]
	,CONVERT(DATETIME2,[date-modified]) [date-modified]
	,CONVERT(NVARCHAR(50),[modified-by]) [modified-by]
FROM [src].[BlackBaudFE_accounts] WITH (NOLOCK)
GO
