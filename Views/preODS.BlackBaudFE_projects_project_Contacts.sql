SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [preODS].[BlackBaudFE_projects_project_Contacts]
AS

SELECT DISTINCT
	CONVERT(NVARCHAR(50),[project-id]) [project_id_K]
	,CONVERT(NVARCHAR(50),[contacts_contact-id]) [contacts_contact_id_K]
	,CONVERT(NVARCHAR(500),[contacts_description]) [contacts_description]
	,CONVERT(NVARCHAR(50),[contacts_country]) [contacts_country]
	,CONVERT(NVARCHAR(100),[contacts_city]) [contacts_city]
	,CONVERT(NVARCHAR(100),[contacts_county]) [contacts_county]
	,CONVERT(NVARCHAR(50),[contacts_state]) [contacts_state]
	,CONVERT(NVARCHAR(250),[contacts_address-line]) [contacts_address_line]
	,CONVERT(NVARCHAR(25),[contacts_postal]) [contacts_postal]
	,CONVERT(NVARCHAR(50),[contacts_title]) [contacts_title]
	,CONVERT(NVARCHAR(100),[contacts_first-name]) [contacts_first_name]
	,CONVERT(NVARCHAR(100),[contacts_middle-name]) [contacts_middle_name]
	,CONVERT(NVARCHAR(100),[contacts_last-name]) [contacts_last_name]
	,CONVERT(NVARCHAR(25),[contacts_suffix]) [contacts_suffix]
	,CONVERT(NVARCHAR(100),[contacts_position]) [contacts_position]
	--,CONVERT(NVARCHAR(MAX),[address-contact-methods_]) [address_contact_methods_]
	--,CONVERT(NVARCHAR(MAX),[address-contact-methods_contact-method-id]) [address_contact_methods_contact_method_id]
	--,CONVERT(NVARCHAR(MAX),[address-contact-methods_contact-type]) [address_contact_methods_contact_type]
	--,CONVERT(NVARCHAR(MAX),[address-contact-methods_contact-info]) [address_contact_methods_contact_info]
FROM [src].[BlackBaudFE_projects_project] WITH (NOLOCK)
where [contacts_contact-id] IS NOT NULL
GO
