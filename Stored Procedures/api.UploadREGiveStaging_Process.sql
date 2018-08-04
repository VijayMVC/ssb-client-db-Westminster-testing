SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE PROCEDURE [api].[UploadREGiveStaging_Process]  
    @DataTable dbo.[UploadREGiveStaging_Type] READONLY  
AS  
BEGIN  
  
	DECLARE @finalXml  XML  
  
	BEGIN TRY  

  
		DECLARE @recordCount INT  
		SELECT @recordCount = COUNT(*)  
			FROM @DataTable  
			  
		INSERT INTO ODS.Blackbaud_REGive
		([SessionId],[Bio_ID],[Current_Year_Cash_Pledge_Bal],[Current_WF_Year],[Prior_WF_Year],[2_Years_Prior_WF],[3_Year_Prior_WF],[4_Years_Prior_WF],[5_Years_Prior_WF],[Prior_Year_Cap_Cash],[2_Years_Prior_Cap_Cash],[3_Years_Prior_Cap_Cash],[4_Years_Prior_Cap_Cash],[5_Years_Prior_Cap_Cash],[6_Years_Prior_Cap_Cash],[Lifetime_Giving],[Capital_Cash_(last_10_years)], Current_Fiscal_Year)  
		SELECT [SessionId],[Bio_ID],[Current_Year_Cash_Pledge_Bal],[Current_WF_Year],[Prior_WF_Year],[2_Years_Prior_WF],[3_Year_Prior_WF],[4_Years_Prior_WF],[5_Years_Prior_WF],[Prior_Year_Cap_Cash],[2_Years_Prior_Cap_Cash],[3_Years_Prior_Cap_Cash],[4_Years_Prior_Cap_Cash],[5_Years_Prior_Cap_Cash],[6_Years_Prior_Cap_Cash],[Lifetime_Giving],[Capital_Cash_(last_10_years)], [Current_Fiscal_Year]
		FROM @DataTable  
		  
		SET @finalXml = '<Root><ResponseInfo><Success>true</Success><RecordsInserted>' + CAST(@recordCount AS NVARCHAR(10)) + '</RecordsInserted></ResponseInfo></Root>'  
  
	END TRY  
  
  
	BEGIN CATCH  
	  
		-- TODO: Better error messaging here  
		SET @finalXml = '<Root><ResponseInfo><Success>false</Success><ErrorMessage>There was an error attempting to upload this data.</ErrorMessage></ResponseInfo></Root>'  
  
	END CATCH  
  
  
	-- Return response  
	SELECT CAST(@finalXml AS XML)  
  
END 
GO
