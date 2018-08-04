SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
create view [rpt].[vwGift] AS 
SELECT 
	a.giftid
	,a.date giftdate
	,a.[date-added] GiftAddedDate
	,a.[date-modified] GiftModDate
	,a.type GiftType
	,b.fullname ConstiuentName
	,a.[is-anonymous]
	,a.[gift-status]
	,a.[post-status]
	,a.reference
	,a.amount_value
	,a.[post-date]
	,a.subtype
	,cust.[Company Will Match]
	,cust.[Sp Gft Cde 1]
	,cust.[Sp Gft Fld 1]
	,cust.[TFT Multi Year Pledge]
	,cust.[WF Directed Giving]
	,cust.[WF Multi Year Pledge]
FROM [Westminster].[ods].[BlackBaud_gifts] a
JOIN ods.BlackBaud_constituents b on a.[constituent-id] = b.constituent_id
LEFT JOIN
		(SELECT *
		FROM
		(SELECT Constituent_id, category, valuetext
			FROM [ods].[BlackBaud_gifts_customfields]) AS SourceTable
		PIVOT
		(
		MAX(valuetext)
		FOR category IN ([Company Will Match],[Sp Gft Cde 1],[Sp Gft Fld 1],[TFT Multi Year Pledge],[WF Directed Giving],[WF Multi Year Pledge])
		) AS PivotTable
		) cust
	ON a.[constituent-id] = cust.Constituent_id

GO
