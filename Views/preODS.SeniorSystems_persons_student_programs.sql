SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [preODS].[SeniorSystems_persons_student_programs]
AS

SELECT DISTINCT
	CONVERT(NVARCHAR(50),[EntityNo]) [EntityNo_K]
	--,CONVERT(NVARCHAR(MAX),[L3_AllData_AllFamilyIDs_]) [L3_AllData_AllFamilyIDs_]
	--,CONVERT(NVARCHAR(MAX),[L4_AllData_StudentRelationships_FamilyID]) [L4_AllData_StudentRelationships_FamilyID]
	--,CONVERT(NVARCHAR(MAX),[L5_AllData_Addresses_AdditionalContactInfo_Name1EntityNo]) [L5_AllData_Addresses_AdditionalContactInfo_Name1EntityNo]
	,CONVERT(NVARCHAR(10),[StudentAccounts_Programs_ID]) [Programs_ID_K]
	,CONVERT(NVARCHAR(250),[StudentAccounts_Programs_Name]) [Programs_Name]
	,CONVERT(NVARCHAR(100),[StudentAccounts_Programs_Group]) [Programs_Group]
FROM [src].[SeniorSystems_persons] WITH (NOLOCK)
WHERE StudentAccounts_Programs_ID IS NOT NULL

GO
