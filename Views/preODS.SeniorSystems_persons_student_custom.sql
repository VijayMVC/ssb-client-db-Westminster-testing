SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



CREATE VIEW [preODS].[SeniorSystems_persons_student_custom]
AS

SELECT DISTINCT
	CONVERT(NVARCHAR(50),[EntityNo]) [EntityNo_K]
	--,CONVERT(NVARCHAR(MAX),[L3_AllData_AllFamilyIDs_]) [L3_AllData_AllFamilyIDs_]
	--,CONVERT(NVARCHAR(MAX),[L4_AllData_StudentRelationships_FamilyID]) [L4_AllData_StudentRelationships_FamilyID]
	--,CONVERT(NVARCHAR(MAX),[L5_AllData_Addresses_AdditionalContactInfo_Name1EntityNo]) [L5_AllData_Addresses_AdditionalContactInfo_Name1EntityNo]
	--,CONVERT(NVARCHAR(MAX),[Programs_ID]) [Programs_ID]
	,CONVERT(NVARCHAR(10),[StudentAccounts_CustomFields_RG_FieldNumber]) [RG_FieldNumber_K]
	,CONVERT(NVARCHAR(100),[StudentAccounts_CustomFields_RG_Prompt]) [RG_Prompt]
	,CONVERT(NVARCHAR(10),[StudentAccounts_CustomFields_RG_Value]) [RG_Value]
FROM [src].[SeniorSystems_persons] WITH (NOLOCK)
WHERE StudentAccounts_CustomFields_RG_FieldNumber IS NOT NULL

GO
