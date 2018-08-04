SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [preODS].[Schoology_schools]
AS

SELECT DISTINCT
	CONVERT(NVARCHAR(50),[schoolid]) [schoolid_K]
	,CONVERT(NVARCHAR(250),[title]) [title]
	,CONVERT(NVARCHAR(250),[address1]) [address1]
	,CONVERT(NVARCHAR(250),[address2]) [address2]
	,CONVERT(NVARCHAR(100),[city]) [city]
	,CONVERT(NVARCHAR(50),[state]) [state]
	,CONVERT(NVARCHAR(50),[postal-code]) [postal-code]
	,CONVERT(NVARCHAR(50),[country]) [country]
	,CONVERT(NVARCHAR(250),[website]) [website]
	,CONVERT(NVARCHAR(50),[phone]) [phone]
	,CONVERT(NVARCHAR(50),[fax]) [fax]
	,CONVERT(NVARCHAR(50),[building-code]) [building-code]
	,CONVERT(NVARCHAR(250),[picture-url]) [picture-url]
FROM [src].[Schoology_schools] WITH (NOLOCK)
GO
