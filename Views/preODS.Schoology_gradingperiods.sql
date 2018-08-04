SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [preODS].[Schoology_gradingperiods]
AS

SELECT DISTINCT
	CONVERT(NVARCHAR(50),[gradingperiod_id]) [gradingperiod_id_K]
	,CONVERT(NVARCHAR(250),[title]) [title]
	,CONVERT(date,[start]) [start]
	,CONVERT(date,[end]) [end]
	,CONVERT(bit,[active]) [active]
	,CONVERT(NVARCHAR(10),[has-children]) [has_children]
	,CONVERT(NVARCHAR(50),[parentid]) [parentid]
FROM [src].[Schoology_gradingperiods] WITH (NOLOCK)
GO
