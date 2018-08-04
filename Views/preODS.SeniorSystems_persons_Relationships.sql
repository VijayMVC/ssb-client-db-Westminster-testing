SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE VIEW [preODS].[SeniorSystems_persons_Relationships]
AS

SELECT DISTINCT
	CONVERT(NVARCHAR(50),[EntityNo]) [EntityNo_K]	
	,CONVERT(NVARCHAR(50),StudentRelationships_StudentId) StudentId
	,CONVERT(NVARCHAR(50),StudentRelationships_StudentEntityNo) StudentEntityNo_K
	,CONVERT(NVARCHAR(50),StudentRelationships_FamilyID) FamilyID
	,CONVERT(NVARCHAR(100),StudentRelationships_Relationship) Relationship
FROM [src].[SeniorSystems_persons] WITH (NOLOCK)
WHERE StudentRelationships_StudentId IS NOT NULL

GO
