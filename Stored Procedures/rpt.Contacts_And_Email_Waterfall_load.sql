SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE PROC  [rpt].[Contacts_And_Email_Waterfall_load]
AS

IF OBJECT_ID('rpt.Contacts_And_Email_Waterfall', 'U') IS NOT NULL
	DROP TABLE rpt.Contacts_And_Email_Waterfall


IF OBJECT_ID('tempdb..#ssbid') IS NOT NULL
    DROP TABLE #ssbid
SELECT DISTINCT
    ssbid.SourceSystem,
    ss.SourceSystemSortOrder,
    ssbid.SSB_CRMSYSTEM_CONTACT_ID,
    ssbid.DimCustomerId, 
    ROW_NUMBER() OVER (PARTITION BY ssbid.SSB_CRMSYSTEM_CONTACT_ID ORDER BY ISNULL(SourceSystemSortOrder, 10000000)) AS PersonRowNumber,
    CASE WHEN other.SSB_CRMSYSTEM_CONTACT_ID IS NULL THEN ssbid.SSB_CRMSYSTEM_CONTACT_ID ELSE NULL END AS UniqueToSource,
    dc.EmailPrimary
	,CONCAT(dc2.AddressPrimaryStreet,' ', dc2.AddressPrimaryCity, ' ', dc2.AddressPrimaryState, ' ', dc2.AddressPrimaryzip) AddressPrimary
INTO #ssbid
FROM dbo.DimCustomerSSBID ssbid (NOLOCK) 
LEFT OUTER JOIN (
        SELECT DISTINCT SSB_CRMSYSTEM_CONTACT_ID, SourceSystem
        FROM dbo.DimCustomerSSBID (NOLOCK)
        WHERE IsDeleted = 0
    ) other
    ON  ssbid.SSB_CRMSYSTEM_CONTACT_ID = other.SSB_CRMSYSTEM_CONTACT_ID
    AND ssbid.SourceSystem <> other.SourceSystem
LEFT OUTER JOIN dbo.DimCustomer dc (NOLOCK)
    ON  dc.DimCustomerId = ssbid.DimCustomerId
    AND dc.EmailPrimaryIsCleanStatus = 'Valid'
LEFT OUTER JOIN dbo.DimCustomer dc2 (NOLOCK)
    ON  dc2.DimCustomerId = ssbid.DimCustomerId
    AND dc2.AddressPrimaryIsCleanStatus = 'Valid'
INNER JOIN (
        SELECT
            SourceSystem,
            ROW_NUMBER() OVER (ORDER BY ss.SourceSystemPriority DESC) AS SourceSystemSortOrder
        FROM mdm.SourceSystems
        INNER JOIN (
                SELECT DISTINCT
                    SourceSystemID,
                    SourceSystemPriority
                FROM mdm.SourceSystemPriority (NOLOCK)
            ) ss
            ON  ss.SourceSystemID = SourceSystems.SourceSystemID
    ) ss
    ON  ssbid.SourceSystem = ss.SourceSystem
WHERE ssbid.IsDeleted = 0
--    AND dc.IsDeleted = 0

SELECT
    SourceSystem,
    SourceSystemSortOrder,
    COUNT(DISTINCT DimCustomerId) AS TotalRecords,
    COUNT(DISTINCT SSB_CRMSYSTEM_CONTACT_ID) AS SourceUnique,
    COUNT(DISTINCT CASE WHEN PersonRowNumber = 1 THEN SSB_CRMSYSTEM_CONTACT_ID END) AS UniqueToSource,
  --  COUNT(DISTINCT UniqueToSource) AS UniqueToSource,
    COUNT(CASE WHEN EmailPrimary IS NOT NULL THEN EmailPrimary END) AS TotalValidEmails,
    COUNT(DISTINCT CASE WHEN EmailPrimary IS NOT NULL THEN EmailPrimary END) AS SourceUniqueValidEmails,
    COUNT(DISTINCT CASE WHEN EmailPrimary IS NOT NULL AND UniqueToSource IS NOT NULL THEN EmailPrimary END) AS UniqueToSourceValidEmails,
	COUNT(CASE WHEN AddressPrimary IS NOT NULL THEN AddressPrimary END) AS TotalValidAddressPrimary,
    COUNT(DISTINCT CASE WHEN AddressPrimary IS NOT NULL THEN AddressPrimary END) AS SourceUniqueValidAddressPrimary,
    COUNT(DISTINCT CASE WHEN AddressPrimary IS NOT NULL AND UniqueToSource IS NOT NULL THEN AddressPrimary END) AS UniqueToSourceValidAddressPrimary,
    GETDATE() AS ETL_Date
INTO rpt.Contacts_And_Email_Waterfall
FROM #ssbid
GROUP BY
    SourceSystemSortOrder,
    SourceSystem
ORDER BY SourceSystemSortOrder

--CREATE TABLE #SourceRank (
--SourceSystem VARCHAR(50)
--,SortOrder INT
--)

--INSERT INTO #SourceRank

----SELECT dc.Sourcesystem
----	  ,RANK() OVER(ORDER BY ISNULL(ss.SortOrder,99), dc.SourceSystem) SortOrder
----FROM (  SELECT DISTINCT sourcesystem
----		FROM dimcustomerssbid
----		WHERE SourceSystem IS NOT NULL
----	 )dc
----	 LEFT JOIN rpt.SystemSort ss ON ss.SourceSystem = dc.Sourcesystem

--SELECT SourceSystem, 
--ROW_NUMBER() OVER (ORDER BY ss.SourceSystemPriority DESC) AS SortOrder
--FROM mdm.SourceSystems
--JOIN (
--SELECT DISTINCT SourceSystemID, SourceSystemPriority 
--FROM mdm.SourceSystemPriority ) ss ON ss.SourceSystemID = SourceSystems.SourceSystemID


--SELECT z.SourceSystem
--		, SortOrder
--		, COUNT(z.DimCustomerId) TotalRecords
--		, COUNT(DISTINCT z.SSB_CRMSYSTEM_CONTACT_ID) SourceUnique
--		, SUM(CASE WHEN PersonRowNumber = 1 THEN 1 ELSE 0 END)  AS UniqueCount
--		, COUNT(CASE WHEN z.EmailPrimary IS NOT NULL THEN z.EmailPrimary END) AS TotalValidEmails
--		, COUNT(DISTINCT CASE WHEN z.EmailPrimary IS NOT NULL THEN z.EmailPrimary END) AS SourceUniqueValidEmails
--		--, SUM(CASE WHEN z.PersonRowNumber = 1 AND z.EmailPrimary IS NOT NULL THEN 1 ELSE 0 end) AS UniqueValidEmails
--		, GETDATE() AS EtlDate
--		--, COUNT(DISTINCT CASE WHEN MaxSourceRank = 1 THEN z.SSB_CRMSYSTEM_CONTACT_ID ELSE NULL END) AS UniqueToSource
--		, 1 AS IsCurrentDay
--		, GETDATE() AS dimdateid
--		INTO rpt.Contacts_And_Email_Waterfall
--FROM ( SELECT  SortOrder 
--			  ,SourceSystem 
--			  ,SSB_CRMSYSTEM_CONTACT_ID 
--			  ,dimcustomerid
--			  ,EmailPrimary 
--			  ,personrownumber
--			  ,MAX(sourceRank) AS MaxSourceRank
--	   FROM (  SELECT ss.SortOrder 
--					 ,ssbid.SourceSystem 
--					 ,ssbid.SSB_CRMSYSTEM_CONTACT_ID 
--					 ,ssbid.dimcustomerid
--					 , dc.EmailPrimary
--					 ,ROW_NUMBER() OVER (PARTITION BY ssbid.SSB_CRMSYSTEM_CONTACT_ID ORDER BY ISNULL(SortOrder, 10000000)) AS PersonRowNumber
--					 ,DENSE_RANK() OVER (PARTITION BY ssbid.SSB_CRMSYSTEM_CONTACT_ID ORDER BY ss.SortOrder) AS sourceRank		
--			   FROM [dbo].[dimcustomerssbid] ssbid (NOLOCK)
--			    LEFT JOIN dbo.DimCustomer dc (NOLOCK) ON dc.DimCustomerId = ssbid.DimCustomerId AND dc.EmailPrimaryIsCleanStatus = 'Valid' -- New
--				JOIN #SourceRank ss (NOLOCK) ON ssbid.SourceSystem = ss.SourceSystem
--				WHERE dc.IsDeleted = 0
--			)a
--	  GROUP BY SortOrder 
--	  		  ,SourceSystem 
--	  		  ,SSB_CRMSYSTEM_CONTACT_ID 
--	  		  ,dimcustomerid
--			  ,EmailPrimary
--	  		  ,personrownumber
--	 )z
--GROUP BY z.SourceSystem, SortOrder

--IF OBJECT_ID('tempdb..#ssbid') IS NOT NULL
--    DROP TABLE #ssbid
--SELECT DISTINCT
--    ssbid.SourceSystem,
--    ss.SourceSystemSortOrder,
--    ssbid.SSB_CRMSYSTEM_CONTACT_ID, 
--    ssbid.DimCustomerId, 
--    CASE WHEN other.SSB_CRMSYSTEM_CONTACT_ID IS NULL THEN ssbid.SSB_CRMSYSTEM_CONTACT_ID ELSE NULL END AS UniqueToSource,
--    dc.EmailPrimary
--INTO #ssbid
--FROM dbo.DimCustomerSSBID ssbid (NOLOCK) 
--LEFT OUTER JOIN (
--        SELECT DISTINCT SSB_CRMSYSTEM_CONTACT_ID, SourceSystem
--        FROM dbo.DimCustomerSSBID (NOLOCK) 
--        WHERE IsDeleted = 0
--    ) other
--    ON  ssbid.SSB_CRMSYSTEM_CONTACT_ID = other.SSB_CRMSYSTEM_CONTACT_ID
--    AND ssbid.SourceSystem <> other.SourceSystem
--LEFT OUTER JOIN dbo.DimCustomer dc (NOLOCK) 
--    ON  dc.DimCustomerId = ssbid.DimCustomerId 
--    AND dc.EmailPrimaryIsCleanStatus = 'Valid'
--INNER JOIN (
--        SELECT 
--            SourceSystem, 
--            ROW_NUMBER() OVER (ORDER BY ss.SourceSystemPriority DESC) AS SourceSystemSortOrder
--        FROM mdm.SourceSystems
--        INNER JOIN (
--                SELECT DISTINCT 
--                    SourceSystemID, 
--                    SourceSystemPriority 
--                FROM mdm.SourceSystemPriority (NOLOCK)
--            ) ss 
--            ON  ss.SourceSystemID = SourceSystems.SourceSystemID
--    ) ss
--    ON  ssbid.SourceSystem = ss.SourceSystem
--WHERE ssbid.IsDeleted = 0
--    AND dc.IsDeleted = 0

--SELECT
--    SourceSystem,
--    SourceSystemSortOrder,
--    COUNT(DimCustomerId) AS TotalRecords,
--    COUNT(DISTINCT SSB_CRMSYSTEM_CONTACT_ID) AS SourceUnique,
--    COUNT(DISTINCT UniqueToSource) AS UniqueToSource,
--    COUNT(CASE WHEN EmailPrimary IS NOT NULL THEN EmailPrimary END) AS TotalValidEmails,
--    COUNT(DISTINCT CASE WHEN EmailPrimary IS NOT NULL THEN EmailPrimary END) AS SourceUniqueValidEmails,
--    COUNT(DISTINCT CASE WHEN EmailPrimary IS NOT NULL AND UniqueToSource IS NOT NULL THEN EmailPrimary END) AS UniqueToSourceValidEmails,
--    GETDATE() AS ETL_Date
--FROM #ssbid
--GROUP BY
--    SourceSystemSortOrder,
--    SourceSystem
--ORDER BY SourceSystemSortOrder



GO
