SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



CREATE PROC [dbo].[Queue_RE_Title] 
	@IssueID	INT 
AS

--[dbo].[Queue_RE_Title]  61142

WITH XX AS (
		SELECT DISTINCT Prefix
		,CASE WHEN Prefix IN('1st. Lt.', '2nd Lt.', 'Adm.', 'Admiral', 'Ambassador', 'Bishop', 'Brig. Gen.', 'Brother', 'Cadet', 'Capt.', 'Captain', 'Cmdr.', 'Col.', 'Colonel',
		    'Commander', 'Commissioner', 'Corporal', 'Count', 'Countess', 'Cpl.', 'Dr', 'Dr.', 'Ens.', 'Ensign', 'Father', 'Gen.', 'General', 'Governor', 'Hon.', 
			'Judge', 'Lieutenant', 'Lt.', 'Lt. (jg)', 'Lt. Cmdr.', 'Lt. Col.', 'Lt. Col. (Ret.)', 'Madam', 'Maj.', 'Maj. Gen.', 'Major', 'Master', 'Mayor', 'Miss', 
			'Mr', 'Mr.', 'Mr. and Mrs.', 'Mrs', 'Mrs.', 'Ms', 'Ms.', 'Pfc.', 'Private', 'Prof.', 'Rabbi', 'Rear Adm.', 'Rev.', 'Rev. Dr.', 'Reverend', 'Senator', 'Sergeant', 'Sgt.', 
			'Sir', 'Sir/Madam', 'Sister', 'Spc.', 'Specialist', 'SSgt.', 'Tech. Sgt.', 'The Honorable', 'The Reverend', 'The Very Reverend', 'Vice Adm.') THEN Prefix
		 END TitleClean
		 FROM dbo.DimCustomer WHERE SourceSystem = 'seniorsystems')


SELECT  'RaisersEdge' APIName, 'Constituent' APIEntity, 'Constituents' EndpointName, i.Constituent_ID SourceID 
				,(SELECT xx.TitleClean AS [title]  FROM dbo.BizRule_Issues a
				JOIN dbo.DimCustomer b ON b.SSID = a.SSID AND b.SourceSystem = a.SourceSystem
				JOIN xx ON b.Prefix = xx.Prefix AND XX.TitleClean IS NOT NULL
				WHERE IssueID = @IssueID
				FOR JSON PATH, WITHOUT_ARRAY_WRAPPER) json_payload
	,'patch' htmlAction 
	,'Title' Description
	,i.IssueID
FROM dbo.BizRule_Issues i
WHERE i.IssueID = @IssueID





GO
