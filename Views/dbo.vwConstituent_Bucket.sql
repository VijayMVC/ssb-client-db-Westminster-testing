SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [dbo].[vwConstituent_Bucket] 
AS 


SELECT 
CASE WHEN b.SS_Current_Student = 1 OR b.RE_Current_Student = 1 THEN 'Curent Student'
	 WHEN b.SS_Current_Parent = 1 OR b.RE_Current_Parent = 1 THEN 'Curent Parent'
	 WHEN b.SS_Current_FactStaff = 1 OR b.RE_Current_FactStaff = 1 THEN 'Curent Faculty/Staff'
	 ELSE 'Other'
END GroupName
,COUNT(1)									AS TotalCount
,SUM(RaisersEdgeCount100				  ) AS RE_Count
,SUM(RaisersEdgeDupeCount1				  ) AS RE_DupeCount__BR1
,SUM(RaisersEdgeCount100) - SUM(RaisersEdgeDupeCount1) AS RE_CleanCount
,SUM(SeniorSystemsCount110				  ) AS SS_Count
,SUM(SeniorSystemsDupeCount11			  ) AS SS_DupeCount_BR2
,SUM(SeniorSystemsCount110) - SUM(SeniorSystemsDupeCount11) AS SS_CleanCount
,SUM(SchoologyCount120					  ) AS Sch_Count
,SUM(SchoologyDupeCount21				  ) AS Sch_DupeCount_BR3
,SUM(SchoologyCount120) - SUM(SchoologyDupeCount21) AS Sch_CleanCount
,SUM(InREAndSSAndSchOnlyCount48			  ) AS AllTHREE
,SUM(InREOnlyCount41					  ) AS RE_ONLY
,SUM(InSSOnlyCount42					  ) AS SS_ONLY
,SUM(InSchOnlyCount43					  ) AS Sch_ONLY
,SUM(InREAndSSOnlyCount45				  ) AS RE_SS
,SUM(InREAndSchOnlyCount46				  ) AS RE_Sch
,SUM(InSSAndSchOnlyCount142				  ) AS SS_SCH
FROM rpt.DimCustomerBucketing_v0 a
INNER JOIN dbo.vwConstituent_Tagging b ON a.SSID = b.SSID  AND a.SourceSystem = b.SourceSystem
GROUP BY CASE WHEN b.SS_Current_Student = 1 OR b.RE_Current_Student = 1 THEN 'Curent Student'
	 WHEN b.SS_Current_Parent = 1 OR b.RE_Current_Parent = 1 THEN 'Curent Parent'
	 WHEN b.SS_Current_FactStaff = 1 OR b.RE_Current_FactStaff = 1 THEN 'Curent Faculty/Staff'
	ELSE 'Other'
	END
	--ORDER BY 1
GO
