SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [preODS].[BlackBaudFE_projects_project_Contacts_ContactMethods]
AS

SELECT DISTINCT
	CONVERT(NVARCHAR(50),[project-id]) [project_id_K]
	,CONVERT(NVARCHAR(50),[contacts_contact-id]) [contacts_contact_id_K]
	,CONVERT(NVARCHAR(50),[address-contact-methods_contact-method-id]) [address_contact_methods_contact_method_id_K]
	,CONVERT(NVARCHAR(50),[address-contact-methods_contact-type]) [address_contact_methods_contact_type]
	,CONVERT(NVARCHAR(500),[address-contact-methods_contact-info]) [address_contact_methods_contact_info]
FROM [src].[BlackBaudFE_projects_project] WITH (NOLOCK)
where [address-contact-methods_contact-method-id] IS NOT NULL
GO
