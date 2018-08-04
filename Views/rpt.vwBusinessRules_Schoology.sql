SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW 
[rpt].[vwBusinessRules_Schoology]

AS
 SELECT 
       UID
        , CASE [role-id] WHEN 262825 THEN 'Admin' WHEN 262827 THEN 'Faculty' WHEN 262829 THEN 'Student' END Role
   
        , Gender                  
        , [Name-Display]	AS [Name Display]
        , [Name-Title]		   [Name Title]
        , [Name-First]		   [Name First]
		, [name-first-preferred]	[Name First Preferred]
        , [Name-Middle]		   [Name Middle]
        , [Name-Last]		   [Name Last]
        , [Primary-Email] 	   [Primary Email]
        , [Grad-Year] 		   [Grad Year] 
        , [School-UID]		   [School UID]
		, ssb.SSB_CRMSYSTEM_CONTACT_ID
FROM [ods].[Schoology_users] c
JOIN dbo.dimcustomerssbid ssb ON c.UID = ssb.SSID AND ssb.SourceSystem = 'Schoology'

GO
