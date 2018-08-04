SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [preODS].[BlackBaudFE_journalentrybatches]
AS

SELECT DISTINCT
	CONVERT(NVARCHAR(50),[batch-id]) [batch_id_K]
	,CONVERT(NVARCHAR(50),[ui-batch-id]) [ui_batch_id]
	,CONVERT(NVARCHAR(MAX),[description]) [description]
	,CONVERT(NVARCHAR(25),[batch-status]) [batch-status]
	,CONVERT(NVARCHAR(10),[create-interfund-sets]) [create_interfund_sets]
	,CONVERT(NVARCHAR(10),[create-bank-account-adjustments]) [create_bank_account_adjustments]
	,CONVERT(datetime2,[date-added]) [date_added]
	,CONVERT(NVARCHAR(50),[added-by]) [added_by]
	,CONVERT(datetime2,[date-modified]) [date_modified]
	,CONVERT(NVARCHAR(50),[modified-by]) [modified_by]
FROM [src].[BlackBaudFE_journalentrybatches] WITH (NOLOCK)
GO
