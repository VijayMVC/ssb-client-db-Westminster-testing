SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE PROC [dbo].[Queue_RE_Suffix] 
	@IssueID	INT 
AS

--[dbo].[Queue_RE_Suffix]  5818
WITH XX AS (
		SELECT DISTINCT Suffix
		,CASE WHEN Suffix IN('Jr','Jr.','junior') THEN ', Jr.'
		WHEN Suffix IN ('CPA','D.D.S.','DMD','Esq.','JD','M.D.','Ph.D.','Sr.') THEN ', ' + Suffix
		WHEN Suffix = 'D. Min'THEN ', DMin'
		WHEN Suffix = 'Esq'THEN ', Esq.'
		WHEN Suffix = 'J.D.'THEN ', JD'
		WHEN Suffix IN('MD','M.D','M.D., F.A.C.S.') THEN ', M.D.'
		WHEN Suffix IN('PhD','Ph.D') THEN ', Ph.D.'
		WHEN Suffix = 'Sr'THEN ', Sr.'
		WHEN Suffix IN('II','III','IV','V') THEN Suffix
			END SuffixClean
		 FROM ods.SeniorSystems_persons)

SELECT  'RaisersEdge' APIName, 'Constituent' APIEntity, 'Constituents' EndpointName, i.OtherID SourceID 
				,(SELECT xx.SuffixClean AS [suffix]  FROM dbo.BizRule_Issues a
				JOIN dbo.DimCustomer b ON a.OtherID = b.DimCustomerId-- AND a.SourceSystem = b.SourceSystem
				JOIN xx ON b.Suffix = xx.Suffix AND XX.SuffixClean IS NOT NULL
				WHERE IssueID = @IssueID
				FOR JSON PATH, WITHOUT_ARRAY_WRAPPER) json_payload
	,'patch' htmlAction 
	,'Suffix' Description
	,i.IssueID
FROM dbo.BizRule_Issues i
WHERE i.IssueID = @IssueID

GO
