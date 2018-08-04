CREATE ROLE [SSB_Developers]
AUTHORIZATION [dbo]
GO
EXEC sp_addrolemember N'SSB_Developers', N'SSBCLOUD\BI Developers'
GO
EXEC sp_addrolemember N'SSB_Developers', N'svcssbrp'
GO
