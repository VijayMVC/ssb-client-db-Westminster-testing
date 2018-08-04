SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



CREATE PROCEDURE [etl].[DimCustomer_MasterLoad]

AS
BEGIN
--	Clean Up
EXEC [dbo].[PreMDM_cleanup]

--	Raisers Edge
EXEC mdm.etl.LoadDimCustomer @ClientDB = 'Westminster', @LoadView = '[etl].[vw_Load_DimCustomer_RaisersEdge]', @LogLevel = '0', @DropTemp = '1', @IsDataUploaderSource = '0'

------ Financail Edge
--EXEC mdm.etl.LoadDimCustomer @ClientDB = 'Westminster', @LoadView = '[etl].[vw_FinancialEdge_Load_DimCustomer]', @LogLevel = '0', @DropTemp = '1', @IsDataUploaderSource = '0'​

---- Schoology
--EXEC mdm.etl.LoadDimCustomer @ClientDB = 'Westminster', @LoadView = '[etl].[vw_Load_DimCustomer_Schoolology]', @LogLevel = '0', @DropTemp = '1', @IsDataUploaderSource = '0'​

--Senior Systems
EXEC mdm.etl.LoadDimCustomer @ClientDB = 'Westminster', @LoadView = '[etl].[vw_Load_DimCustomer_SeniorSystems]', @LogLevel = '0', @DropTemp = '1', @IsDataUploaderSource = '0'​

--Paycom
EXEC mdm.etl.LoadDimCustomer @ClientDB = 'Westminster', @LoadView = '[etl].[vw_Load_DimCustomer_Paycom]', @LogLevel = '0', @DropTemp = '1', @IsDataUploaderSource = '0'​

END



GO
