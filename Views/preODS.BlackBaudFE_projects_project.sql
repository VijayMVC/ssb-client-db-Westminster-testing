SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [preODS].[BlackBaudFE_projects_project]
AS

SELECT 
	CONVERT(NVARCHAR(50),[project-id]) [project_id_K]
	,CONVERT(NVARCHAR(500),[description]) [description]
	,CONVERT(NVARCHAR(50),[ui-project-id]) [ui_project_id]
	,CONVERT(datetime2,[start-date]) [start_date]
	,CONVERT(datetime2,[end-date]) [end_date]
	,CONVERT(NVARCHAR(100),[location]) [location]
	,CONVERT(NVARCHAR(100),[division]) [division]
	,CONVERT(NVARCHAR(100),[department]) [department]
	,CONVERT(NVARCHAR(50),[type]) [type]
	,CONVERT(NVARCHAR(50),[status]) [status]
	,CONVERT(NVARCHAR(10),[prevent-data-entry]) [prevent_data_entry]
	,CONVERT(NVARCHAR(10),[prevent-posting-after]) [prevent_posting_after]
	,CONVERT(datetime2,[posting-date]) [posting_date]
	,MAX(CONVERT(NVARCHAR(25),[account-restrictions_allow-or-restrict])) [account_restrictions_allow_or_restrict]
	,MAX(CONVERT(NVARCHAR(25),[account-restrictions_criteria])) [account_restrictions_criteria]
	--,CONVERT(NVARCHAR(MAX),[custom-fields_custom-field-id]) [custom_fields_custom_field_id]
	--,CONVERT(NVARCHAR(MAX),[custom-fields_field-name]) [custom_fields_field_name]
	--,CONVERT(NVARCHAR(MAX),[custom-fields_value]) [custom_fields_value]
	--,CONVERT(NVARCHAR(MAX),[custom-fields_comments]) [custom_fields_comments]
	--,CONVERT(NVARCHAR(MAX),[custom-fields_type]) [custom_fields_type]
	--,CONVERT(NVARCHAR(MAX),[custom-fields_date]) [custom_fields_date]
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
--where [project-id] = 76
GROUP BY
	CONVERT(NVARCHAR(50),[project-id])
	,CONVERT(NVARCHAR(500),[description])
	,CONVERT(NVARCHAR(50),[ui-project-id]) 
	,CONVERT(datetime2,[start-date]) 
	,CONVERT(datetime2,[end-date])
	,CONVERT(NVARCHAR(100),[location]) 
	,CONVERT(NVARCHAR(100),[division]) 
	,CONVERT(NVARCHAR(100),[department]) 
	,CONVERT(NVARCHAR(50),[type]) 
	,CONVERT(NVARCHAR(50),[status]) 
	,CONVERT(NVARCHAR(10),[prevent-data-entry]) 
	,CONVERT(NVARCHAR(10),[prevent-posting-after]) 
	,CONVERT(datetime2,[posting-date])
GO
