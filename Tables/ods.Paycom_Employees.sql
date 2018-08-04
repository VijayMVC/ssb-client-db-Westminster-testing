CREATE TABLE [ods].[Paycom_Employees]
(
[Employee_Code] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Employee_Name] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Firstname] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Lastname] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Middle_Name] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Nickname] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Department] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Department_Desc] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Division_Code] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Division_Desc] [nvarchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Labor_Allocation_Details] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Employee_Status] [nvarchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Position] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DOL_Status] [nvarchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ACA_Status] [nvarchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Gender] [nvarchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Street] [nvarchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[City] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[State] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Zipcode] [nvarchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Primary_Phone] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Primary_Phone_Type] [nvarchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Secondary_Phone] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Secondary_Phone_Type] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Exempt_Status] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Perc_Labor_Distribution_*] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Work_Email] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Personal_Email] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Age] [int] NULL,
[Annual_Salary] [float] NULL,
[Scheduled_Pay_Period_Hours] [float] NULL,
[Labor_Allocation_Profile] [nvarchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Document_Group] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Employee_Added] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Hire_Date] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Last_Pay_Change] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Leave_End] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Leave_Start] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Part-Time_to_Full-Time_Date] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Previous_Termination_Date] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Rehire_Date] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RetireeTermDate] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SeniorityDate] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Termination_Date] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EEO1_Ethnicity] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CampusLocation] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ContractHold] [nvarchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Division] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DivisionHead] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DivisionHeadTitle] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EEName] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FTE] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[HourlyRate] [float] NULL,
[HighestDegree] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IndexJobDefinition] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Major1] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PositionStatus] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[StipendRoless] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TotalComp] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[textCampusLocation] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[textInsSupportStaff] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[textJobDefinition] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IsDeleted] [bit] NULL,
[ETL_CreatedOn] [datetime] NOT NULL CONSTRAINT [DF__Paycom_Em__ETL_C__4ADC9C34] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__Paycom_Em__ETL_C__4BD0C06D] DEFAULT (suser_sname()),
[ETL_UpdatedOn] [datetime] NOT NULL CONSTRAINT [DF__Paycom_Em__ETL_U__4CC4E4A6] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__Paycom_Em__ETL_U__4DB908DF] DEFAULT (suser_sname())
)
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

----------- CREATE TRIGGER -----------
CREATE TRIGGER [ods].[Snapshot_Paycom_EmployeesUpdate] ON [ods].[Paycom_Employees]
AFTER UPDATE, DELETE

AS
BEGIN

DECLARE @ETL_UpdatedOn DATETIME = (SELECT [etl].[ConvertToLocalTime](CAST(GETDATE() AS DATETIME2(0))))
DECLARE @ETL_UpdatedBy NVARCHAR(400) = (SELECT SYSTEM_USER)

UPDATE t SET
[ETL_UpdatedOn] = @ETL_UpdatedOn
,[ETL_UpdatedBy] = @ETL_UpdatedBy
FROM [ods].[Paycom_Employees] t
	JOIN inserted i ON  t.[Employee_Code] = i.[Employee_Code]

INSERT INTO [ods].[Snapshot_Paycom_Employees] ([Employee_Code],[Employee_Name],[Firstname],[Lastname],[Middle_Name],[Nickname],[Department],[Department_Desc],[Division_Code],[Division_Desc],[Labor_Allocation_Details],[Employee_Status],[Position],[DOL_Status],[ACA_Status],[Gender],[Street],[City],[State],[Zipcode],[Primary_Phone],[Primary_Phone_Type],[Secondary_Phone],[Secondary_Phone_Type],[Exempt_Status],[Perc_Labor_Distribution_*],[Work_Email],[Personal_Email],[Age],[Annual_Salary],[Scheduled_Pay_Period_Hours],[Labor_Allocation_Profile],[Document_Group],[Employee_Added],[Hire_Date],[Last_Pay_Change],[Leave_End],[Leave_Start],[Part-Time_to_Full-Time_Date],[Previous_Termination_Date],[Rehire_Date],[RetireeTermDate],[SeniorityDate],[Termination_Date],[EEO1_Ethnicity],[CampusLocation],[ContractHold],[Division],[DivisionHead],[DivisionHeadTitle],[EEName],[FTE],[HourlyRate],[HighestDegree],[IndexJobDefinition],[Major1],[PositionStatus],[StipendRoless],[TotalComp],[textCampusLocation],[textInsSupportStaff],[textJobDefinition],[IsDeleted],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate])
SELECT a.*,dateadd(s,-1,@ETL_UpdatedOn)
FROM deleted a

END
GO
ALTER TABLE [ods].[Paycom_Employees] ADD CONSTRAINT [PK__Paycom_E__654579FCD172DCA7] PRIMARY KEY CLUSTERED  ([Employee_Code])
GO
