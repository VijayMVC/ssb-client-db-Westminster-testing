SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE VIEW [preODS].[BlackBaud_education]
AS

SELECT 
	CONVERT(NVARCHAR(50),a.[Edcucationid]) [Edcucationid_K]
	,CONVERT(NVARCHAR(50),[constituent_id]) [constituent_id]
	,CONVERT(NVARCHAR(250),[school]) [school]
	,CONVERT(NVARCHAR(250),[type]) [type]
	,CONVERT(NVARCHAR(50),[class-of]) [class_of]
	,CONVERT(NVARCHAR(10),[primary]) [primary]
	,CONVERT(NVARCHAR(100),[degree]) [degree]
	,CONVERT(NVARCHAR(MAX),[majors_]) [majors]
	,CONVERT(Datetime2,DateAdded) DateAdded
	,CONVERT(Datetime2,DateModified) DateModified
	,CONVERT(NVARCHAR(500),campus) campus
	,CONVERT(NVARCHAR(100),gpa) gpa
	,CONVERT(NVARCHAR(500),status) status
	,CONVERT(NVARCHAR(500),[social-organization]) SocialOrganization
	,CONVERT(NVARCHAR(500),[known-name]) KnownName
	,MAX(TRY_CAST(CONCAT([date-graduated_y],'-',[date-graduated_m],'-',[date-graduated_d]) AS DATE)) Date_Graduated
	,MAX(TRY_CAST(CONCAT([date-entered_y],'-',[date-entered_m],'-',[date-entered_d]) AS DATE)) Date_Entered
	,MAX(TRY_CAST(CONCAT([date-left_y],'-',[date-left_m],'-',[date-left_d]) AS DATE)) Date_Left
FROM [src].[BlackBaud_educations] a WITH (NOLOCK) 
GROUP BY 
	CONVERT(NVARCHAR(50),[Edcucationid]) 
	,CONVERT(NVARCHAR(50),[constituent_id]) 
	,CONVERT(NVARCHAR(250),[school]) 
	,CONVERT(NVARCHAR(250),[type]) 
	,CONVERT(NVARCHAR(50),[class-of]) 
	,CONVERT(NVARCHAR(10),[primary]) 
	,CONVERT(NVARCHAR(100),[degree]) 
	,CONVERT(NVARCHAR(MAX),[majors_])	
	,CONVERT(Datetime2,DateAdded) 
	,CONVERT(Datetime2,DateModified) 
	,CONVERT(NVARCHAR(500),campus) 
	,CONVERT(NVARCHAR(100),gpa) 
	,CONVERT(NVARCHAR(500),status) 
	,CONVERT(NVARCHAR(500),[social-organization]) 
	,CONVERT(NVARCHAR(500),[known-name]) 

GO
