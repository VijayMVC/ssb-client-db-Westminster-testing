SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [preODS].[BlackBaud_customfields]
AS

SELECT
	CustomField_id CustomField_id_k
	,parent_id
	,category
	,type
	,date
	,comment
	,customvalue
	,[date-added]
	,[date-modified]
FROM [src].[BlackBaud_customfields]
--WHERE [uid] IS NOT NULL
--where  constituent_id = '16271'

GO
