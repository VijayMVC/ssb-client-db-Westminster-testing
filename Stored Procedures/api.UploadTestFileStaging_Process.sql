SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

/****** Object:  UserDefinedTableType [dbo].[UploadDimCustomerStaging_Type]    Script Date: 3/5/2018 8:34:44 PM ******/
--create TYPE [dbo].[UploadTestFileStaging_Type] AS TABLE(
--	[SessionId] [uniqueidentifier] NULL,
--	[Name] VARCHAR(50),
--	[Email] VARCHAR(50)
--)
--GO
--CREATE TABLE [api].UploadTestFileStaging(
--	[SessionId] [uniqueidentifier] NULL,
--	[RecordCreateDate] [datetime] NULL,
--	[Processed] [bit] NULL,
	--[DynamicData] [xml] NULL,
--	[Name] VARCHAR(50),
--	[Email] VARCHAR(50),
--	IsDeleted bit null
--) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

--GO

--ALTER TABLE [api].UploadTestFileStaging ADD  CONSTRAINT [DF__UploadTestFileStaging__RecordCreateDate]  DEFAULT (getdate()) FOR [RecordCreateDate]
--GO

--ALTER TABLE [api].UploadTestFileStaging ADD  CONSTRAINT [DF__UploadTestFileStaging__Processed]  DEFAULT ((0)) FOR [Processed]
--GO

--ALTER TABLE [api].UploadTestFileStaging ADD  CONSTRAINT [DF__UploadTestFileStaging__IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
--GO

--ALTER TABLE [api].[UploadTestFileStaging]   ADD FiscalPeriod varchar(50)
CREATE PROCEDURE [api].[UploadTestFileStaging_Process]  
    @DataTable dbo.[UploadTestFileStaging_Type] READONLY  
AS  
BEGIN  
  
	DECLARE @finalXml  XML  
  
	BEGIN TRY  

		UPDATE stg
		SET IsDeleted = 1
		FROM api.UploadTestFileStaging stg
		INNER JOIN @DataTable dt
			ON  stg.Email = dt.Email
  
		DECLARE @recordCount INT  
		SELECT @recordCount = COUNT(*)  
			FROM @DataTable  
			  
		INSERT INTO [api].UploadTestFileStaging  
		([SessionId], [Name], [Email], FiscalPeriod)  
		SELECT [SessionId], [Name], [Email], FiscalPeriod
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
