SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [preODS].[BlackBaud_relationships]
AS

SELECT 
	CONVERT(NVARCHAR(50),[Relationship_id]) [Relationship_id_K]
	,0 [Relationship_count]	
	,CONVERT(NVARCHAR(50),[constituent_id]) [constituent_id]
	,CONVERT(NVARCHAR(50),[relation_id]) [relation_id]
	,CONVERT(NVARCHAR(500),[name]) [name]
	,CONVERT(NVARCHAR(100),[type]) [type]
	,CONVERT(NVARCHAR(100),[reciprocal-type]) [reciprocal_type]
	,CONVERT(NVARCHAR(10),[is-spouse]) [is_spouse]
	,CONVERT(NVARCHAR(10),[is-organization-contact]) [is_organization_contact]
	,CONVERT(NVARCHAR(10),[is-primary-business]) [is_primary_business]
	,CONVERT(NVARCHAR(250),[position]) [position]
	,CONVERT(NVARCHAR(MAX),[comment]) [comment]
	,CONVERT(NVARCHAR(50),[organization-contact-type]) [organization_contact_type]
	,MAX(TRY_CAST(CONCAT([start_y],'-',start_m,'-',start_d) AS DATE)) AS Start_Date
	,MAX(TRY_CAST(CONCAT([end_y],'-',end_m,'-',end_d) AS DATE)) AS End_Date
FROM [src].[BlackBaud_relationships] WITH (NOLOCK)
WHERE constituent_id IS NOT NULL
GROUP BY CONVERT(NVARCHAR(50),[Relationship_id]) 
	,CONVERT(NVARCHAR(50),[constituent_id]) 
	,CONVERT(NVARCHAR(50),[relation_id]) 
	,CONVERT(NVARCHAR(500),[name]) 
	,CONVERT(NVARCHAR(100),[type]) 
	,CONVERT(NVARCHAR(100),[reciprocal-type]) 
	,CONVERT(NVARCHAR(10),[is-spouse]) 
	,CONVERT(NVARCHAR(10),[is-organization-contact]) 
	,CONVERT(NVARCHAR(10),[is-primary-business]) 
	,CONVERT(NVARCHAR(250),[position]) 
	,CONVERT(NVARCHAR(MAX),[comment]) 
	,CONVERT(NVARCHAR(50),[organization-contact-type]) 
GO
