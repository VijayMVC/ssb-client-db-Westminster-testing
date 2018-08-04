SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

/*
-- Get the status of your table 20 minutes ago...
DECLARE @AsOfDate DATETIME = (SELECT [etl].[ConvertToLocalTime](DATEADD(MINUTE,-20,GETDATE())))
SELECT * FROM [ods].[AsOf_Paycom_Employees] (@AsOfDate)
*/

CREATE FUNCTION [ods].[AsOf_Paycom_Employees] (@AsOfDate DATETIME)

RETURNS @Results TABLE
(
[Employee_Code] [nvarchar](50) NULL,
[Employee_Name] [nvarchar](250) NULL,
[Firstname] [nvarchar](50) NULL,
[Lastname] [nvarchar](50) NULL,
[Middle_Name] [nvarchar](50) NULL,
[Nickname] [nvarchar](50) NULL,
[Department] [nvarchar](50) NULL,
[Department_Desc] [nvarchar](250) NULL,
[Division_Code] [nvarchar](50) NULL,
[Division_Desc] [nvarchar](250) NULL,
[Labor_Allocation_Details] [nvarchar](max) NULL,
[Employee_Status] [nvarchar](25) NULL,
[Position] [nvarchar](100) NULL,
[DOL_Status] [nvarchar](25) NULL,
[ACA_Status] [nvarchar](25) NULL,
[Gender] [nvarchar](25) NULL,
[Street] [nvarchar](150) NULL,
[City] [nvarchar](100) NULL,
[State] [nvarchar](10) NULL,
[Zipcode] [nvarchar](20) NULL,
[Primary_Phone] [nvarchar](50) NULL,
[Primary_Phone_Type] [nvarchar](25) NULL,
[Secondary_Phone] [nvarchar](50) NULL,
[Secondary_Phone_Type] [nvarchar](50) NULL,
[Exempt_Status] [nvarchar](50) NULL,
[Perc_Labor_Distribution_*] [nvarchar](max) NULL,
[Work_Email] [nvarchar](50) NULL,
[Personal_Email] [nvarchar](100) NULL,
[Age] [int] NULL,
[Annual_Salary] [float] NULL,
[Scheduled_Pay_Period_Hours] [float] NULL,
[Labor_Allocation_Profile] [nvarchar](25) NULL,
[Document_Group] [nvarchar](100) NULL,
[Employee_Added] [nvarchar](50) NULL,
[Hire_Date] [nvarchar](50) NULL,
[Last_Pay_Change] [nvarchar](50) NULL,
[Leave_End] [nvarchar](50) NULL,
[Leave_Start] [nvarchar](50) NULL,
[Part-Time_to_Full-Time_Date] [nvarchar](50) NULL,
[Previous_Termination_Date] [nvarchar](50) NULL,
[Rehire_Date] [nvarchar](50) NULL,
[RetireeTermDate] [nvarchar](50) NULL,
[SeniorityDate] [nvarchar](50) NULL,
[Termination_Date] [nvarchar](50) NULL,
[EEO1_Ethnicity] [nvarchar](100) NULL,
[CampusLocation] [nvarchar](50) NULL,
[ContractHold] [nvarchar](10) NULL,
[Division] [nvarchar](100) NULL,
[DivisionHead] [nvarchar](100) NULL,
[DivisionHeadTitle] [nvarchar](100) NULL,
[EEName] [nvarchar](50) NULL,
[FTE] [nvarchar](50) NULL,
[HourlyRate] [float] NULL,
[HighestDegree] [nvarchar](100) NULL,
[IndexJobDefinition] [nvarchar](100) NULL,
[Major1] [nvarchar](100) NULL,
[PositionStatus] [nvarchar](100) NULL,
[StipendRoless] [nvarchar](100) NULL,
[TotalComp] [nvarchar](50) NULL,
[textCampusLocation] [nvarchar](50) NULL,
[textInsSupportStaff] [nvarchar](100) NULL,
[textJobDefinition] [nvarchar](100) NULL,
[IsDeleted] [bit] NULL,
[ETL_CreatedOn] [datetime] NOT NULL,
[ETL_CreatedBy] NVARCHAR(400) NOT NULL,
[ETL_UpdatedOn] [datetime] NOT NULL,
[ETL_UpdatedBy] NVARCHAR(400) NOT NULL
)

AS
BEGIN

DECLARE @EndDate DATETIME = (SELECT [etl].[ConvertToLocalTime](CAST(GETDATE() AS datetime2(0))))
SET @AsOfDate = (SELECT CAST(@AsOfDate AS datetime2(0)))

INSERT INTO @Results
SELECT [Employee_Code],[Employee_Name],[Firstname],[Lastname],[Middle_Name],[Nickname],[Department],[Department_Desc],[Division_Code],[Division_Desc],[Labor_Allocation_Details],[Employee_Status],[Position],[DOL_Status],[ACA_Status],[Gender],[Street],[City],[State],[Zipcode],[Primary_Phone],[Primary_Phone_Type],[Secondary_Phone],[Secondary_Phone_Type],[Exempt_Status],[Perc_Labor_Distribution_*],[Work_Email],[Personal_Email],[Age],[Annual_Salary],[Scheduled_Pay_Period_Hours],[Labor_Allocation_Profile],[Document_Group],[Employee_Added],[Hire_Date],[Last_Pay_Change],[Leave_End],[Leave_Start],[Part-Time_to_Full-Time_Date],[Previous_Termination_Date],[Rehire_Date],[RetireeTermDate],[SeniorityDate],[Termination_Date],[EEO1_Ethnicity],[CampusLocation],[ContractHold],[Division],[DivisionHead],[DivisionHeadTitle],[EEName],[FTE],[HourlyRate],[HighestDegree],[IndexJobDefinition],[Major1],[PositionStatus],[StipendRoless],[TotalComp],[textCampusLocation],[textInsSupportStaff],[textJobDefinition],[IsDeleted],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy]
FROM
	(
	SELECT [Employee_Code],[Employee_Name],[Firstname],[Lastname],[Middle_Name],[Nickname],[Department],[Department_Desc],[Division_Code],[Division_Desc],[Labor_Allocation_Details],[Employee_Status],[Position],[DOL_Status],[ACA_Status],[Gender],[Street],[City],[State],[Zipcode],[Primary_Phone],[Primary_Phone_Type],[Secondary_Phone],[Secondary_Phone_Type],[Exempt_Status],[Perc_Labor_Distribution_*],[Work_Email],[Personal_Email],[Age],[Annual_Salary],[Scheduled_Pay_Period_Hours],[Labor_Allocation_Profile],[Document_Group],[Employee_Added],[Hire_Date],[Last_Pay_Change],[Leave_End],[Leave_Start],[Part-Time_to_Full-Time_Date],[Previous_Termination_Date],[Rehire_Date],[RetireeTermDate],[SeniorityDate],[Termination_Date],[EEO1_Ethnicity],[CampusLocation],[ContractHold],[Division],[DivisionHead],[DivisionHeadTitle],[EEName],[FTE],[HourlyRate],[HighestDegree],[IndexJobDefinition],[Major1],[PositionStatus],[StipendRoless],[TotalComp],[textCampusLocation],[textInsSupportStaff],[textJobDefinition],[IsDeleted],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],@EndDate [RecordEndDate]
	FROM [ods].[Paycom_Employees] t
	UNION ALL
	SELECT [Employee_Code],[Employee_Name],[Firstname],[Lastname],[Middle_Name],[Nickname],[Department],[Department_Desc],[Division_Code],[Division_Desc],[Labor_Allocation_Details],[Employee_Status],[Position],[DOL_Status],[ACA_Status],[Gender],[Street],[City],[State],[Zipcode],[Primary_Phone],[Primary_Phone_Type],[Secondary_Phone],[Secondary_Phone_Type],[Exempt_Status],[Perc_Labor_Distribution_*],[Work_Email],[Personal_Email],[Age],[Annual_Salary],[Scheduled_Pay_Period_Hours],[Labor_Allocation_Profile],[Document_Group],[Employee_Added],[Hire_Date],[Last_Pay_Change],[Leave_End],[Leave_Start],[Part-Time_to_Full-Time_Date],[Previous_Termination_Date],[Rehire_Date],[RetireeTermDate],[SeniorityDate],[Termination_Date],[EEO1_Ethnicity],[CampusLocation],[ContractHold],[Division],[DivisionHead],[DivisionHeadTitle],[EEName],[FTE],[HourlyRate],[HighestDegree],[IndexJobDefinition],[Major1],[PositionStatus],[StipendRoless],[TotalComp],[textCampusLocation],[textInsSupportStaff],[textJobDefinition],[IsDeleted],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate]
	FROM [ods].[Snapshot_Paycom_Employees]
	) a
WHERE
	@AsOfDate BETWEEN [ETL_UpdatedOn] AND [RecordEndDate]
	AND [ETL_CreatedOn] <= @AsOfDate

RETURN

END
GO
