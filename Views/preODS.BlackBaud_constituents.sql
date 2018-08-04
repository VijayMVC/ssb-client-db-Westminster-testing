SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [preODS].[BlackBaud_constituents]
AS

SELECT DISTINCT
	CONVERT(NVARCHAR(50),[constituent_id]) [constituent_id_K]
	,CONVERT(NVARCHAR(50),[type]) [type]
	,CONVERT(NVARCHAR(50),[lookup-id]) [lookup_id]
	,CONVERT(NVARCHAR(10),[inactive]) [inactive]
	,CONVERT(NVARCHAR(250),[fullname]) [fullname]
	,CONVERT(NVARCHAR(20),[gender]) [gender]
	,CONVERT(NVARCHAR(10),[deceased]) [deceased]
	,CONVERT(datetime2,[date-added]) [date_added]
	,CONVERT(datetime2,[date-modified]) [date_modified]
	,CONVERT(NVARCHAR(10),[gives-anonymously]) [gives_anonymously]
	,CONVERT(NVARCHAR(100),[lastname]) [lastname]
	,CONVERT(NVARCHAR(100),[firstname]) [firstname]
	,CONVERT(NVARCHAR(50),[middlename]) [middlename]
	,CONVERT(NVARCHAR(50),[preferred-name]) [preferred_name]
	,CONVERT(NVARCHAR(50),[title]) [title]
	,CONVERT(NVARCHAR(50),[marital-status]) [marital_status]
	,CONVERT(NVARCHAR(50),[age]) [age]
	,CONVERT(NVARCHAR(50),[suffix]) [suffix]
	,MAX(CONVERT(NVARCHAR(50),[address_id]) )OVER (Partition by [constituent_id]) [address_id]
	,MAX(CONVERT(NVARCHAR(50),[phone_id])	)OVER (Partition by [constituent_id]) [phone_id]
	,MAX(CONVERT(NVARCHAR(50),[email_id])	)OVER (Partition by [constituent_id]) [email_id]
	,MAX(CONVERT(NVARCHAR(10),[birthdate_year])		)OVER (Partition by [constituent_id])	[birthdate_year]
	,MAX(CONVERT(NVARCHAR(10),[birthdate_month])	)OVER (Partition by [constituent_id])	[birthdate_month]
	,MAX(CONVERT(NVARCHAR(10),[birthdate_day])		)OVER (Partition by [constituent_id])	[birthdate_day]
	,MAX(CONVERT(NVARCHAR(50),[spouse_id])			)OVER (Partition by [constituent_id])	[spouse_id]
	,MAX(CONVERT(NVARCHAR(50),[online-presence_id])	)OVER (Partition by [constituent_id])	[online_presence_id]
FROM [src].[BlackBaud_constituents] WITH (NOLOCK)	

GO
