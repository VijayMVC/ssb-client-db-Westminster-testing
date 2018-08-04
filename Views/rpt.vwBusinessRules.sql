SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [rpt].[vwBusinessRules]
AS 
SELECT a.BusinessRule, a.Weight, COUNT(DISTINCT SSB_CRMSYSTEM_CONTACT_ID) TotaPeopleWithIssue FROM [rpt].[BusinessRuleWeights] a 
JOIN [rpt].[BusinessRulesBucketsOutput] b
	ON a.businessrule = b.businessrule
GROUP BY a.BusinessRule, a.Weight
GO
