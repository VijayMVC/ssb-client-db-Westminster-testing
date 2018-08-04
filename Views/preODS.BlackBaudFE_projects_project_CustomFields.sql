SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [preODS].[BlackBaudFE_projects_project_CustomFields]
AS

SELECT DISTINCT
	CONVERT(NVARCHAR(50),[project-id]) [project_id_K]
	,CONVERT(NVARCHAR(50),[custom-fields_custom-field-id]) [custom_fields_custom_field_id_K]
	,CONVERT(NVARCHAR(250),[custom-fields_field-name]) [custom_fields_field_name]
	,CONVERT(NVARCHAR(500),[custom-fields_value]) [custom_fields_value]
	,CONVERT(NVARCHAR(MAX),[custom-fields_comments]) [custom_fields_comments]
	,CONVERT(NVARCHAR(50),[custom-fields_type]) [custom_fields_type]
	,CONVERT(datetime2,[custom-fields_date]) [custom_fields_date]
	--,CONVERT(NVARCHAR(MAX),[contacts_contact-id]) [contacts_contact_id]
	--,CONVERT(NVARCHAR(MAX),[contacts_description]) [contacts_description]
	--,CONVERT(NVARCHAR(MAX),[contacts_country]) [contacts_country]
	--,CONVERT(NVARCHAR(MAX),[contacts_city]) [contacts_city]
	--,CONVERT(NVARCHAR(MAX),[contacts_county]) [contacts_county]
	--,CONVERT(NVARCHAR(MAX),[contacts_state]) [contacts_state]
	--,CONVERT(NVARCHAR(MAX),[contacts_address-line]) [contacts_address_line]
	--,CONVERT(NVARCHAR(MAX),[contacts_postal]) [contacts_postal]
	--,CONVERT(NVARCHAR(MAX),[contacts_title]) [contacts_title]
	--,CONVERT(NVARCHAR(MAX),[contacts_first-name]) [contacts_first_name]
	--,CONVERT(NVARCHAR(MAX),[contacts_middle-name]) [contacts_middle_name]
	--,CONVERT(NVARCHAR(MAX),[contacts_last-name]) [contacts_last_name]
	--,CONVERT(NVARCHAR(MAX),[contacts_suffix]) [contacts_suffix]
	--,CONVERT(NVARCHAR(MAX),[contacts_position]) [contacts_position]
	--,CONVERT(NVARCHAR(MAX),[address-contact-methods_]) [address_contact_methods_]
	--,CONVERT(NVARCHAR(MAX),[address-contact-methods_contact-method-id]) [address_contact_methods_contact_method_id]
	--,CONVERT(NVARCHAR(MAX),[address-contact-methods_contact-type]) [address_contact_methods_contact_type]
	--,CONVERT(NVARCHAR(MAX),[address-contact-methods_contact-info]) [address_contact_methods_contact_info]
FROM [src].[BlackBaudFE_projects_project] WITH (NOLOCK)
where [custom-fields_custom-field-id] IS NOT NULL
GO
