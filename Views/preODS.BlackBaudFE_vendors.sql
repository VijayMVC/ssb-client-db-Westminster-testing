SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [preODS].[BlackBaudFE_vendors]
AS

SELECT
	[vendor_id] vendor_id_K
	,[vendor-name]
	,[balance-due]
	,[ui-defined-id]
	,[customer-number]
	,[vendor-status]
	,[issue-1099s]
	,[payment-method]
	,[address-id]
	,[description]
	,[country]
	,[city]
	,[county]
	,[state]
	,[postal]
	,[address-line]
	,[is-primary]
	,[is-invoices]
	,[is-pos]
	,[is-1099]
	,[title]
	,[first-name]
	,[middle-name]
	,[last-name]
	,[suffix]
	,[position]
	,[address-contact-methods]
FROM [src].[BlackBaudFE_vendors]
GO
