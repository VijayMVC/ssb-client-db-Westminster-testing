SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




CREATE PROC [dbo].[Queue_RE_Phone]
	@IssueID	INT 
AS
-- [Queue_RE_Phone] 11664

DECLARE @phone		 VARCHAR(1000)
DECLARE @type						 VARCHAR(50)
DECLARE @constituentID				VARCHAR(10)

SELECT
	@phone = ISNULL(sis.Current_Value, dc.PhonePrimary)
	,@type = 'Home'
	,@constituentID = con.constituent_id
FROM dbo.BizRule_Issues i
LEFT JOIN (SELECT *,ROW_NUMBER() OVER(PARTITION BY SSID, FieldName ORDER BY ChangeDate DESC) RN
			FROM dbo.SIS_DataChanges) sis 
	ON sis.SSID = i.ssid
	AND sis.FieldName LIKE '%phone%'
	AND sis.rn = 1	
JOIN dbo.DimCustomer dc ON i.EntityNo =dc.SSID AND dc.SourceSystem = 'SeniorSystems'
JOIN dbo.dimcustomerssbid ssb ON dc.DimCustomerId = ssb.DimCustomerId
JOIN dbo.dimcustomerssbid ssb2 ON ssb.SSB_CRMSYSTEM_CONTACT_ID = ssb2.SSB_CRMSYSTEM_CONTACT_ID AND ssb2.SourceSystem = 'RaisersEdge'
LEFT JOIN ods.BlackBaud_constituents con ON ssb2.SSID = con.constituent_id 
WHERE i.IssueID = @IssueID


SELECT  'RaisersEdge' APIName, 'Constituent' APIEntity, 'Phones' EndpointName,''--' @SourceID 
				,( SELECT 
						@constituentID [constituent_id]
						,@type [type]
						, @phone [number]
						,'true' [primary]
				FOR JSON PATH, WITHOUT_ARRAY_WRAPPER) json_payload
	,'post' httpAction 
	,'Add new primary Phone' Description
	,@IssueID


GO
