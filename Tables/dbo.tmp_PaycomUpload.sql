CREATE TABLE [dbo].[tmp_PaycomUpload]
(
[Employee_Code] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Employee_Name] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Firstname] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Lastname] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Middle_Name] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Nickname] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Department] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Department_Desc] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Division_Code] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Division_Desc] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Labor_Allocation_Details] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Employee_Status] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Position] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DOL_Status] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ACA_Status] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Gender] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Street] [varchar] (150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[City] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[State] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Zipcode] [bigint] NULL,
[Primary_Phone] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Primary_Phone_Type] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Secondary_Phone] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Secondary_Phone_Type] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Exempt_Status] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Perc_Labor_Distribution_*] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Work_Email] [varchar] (46) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Personal_Email] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Age] [bigint] NULL,
[Annual_Salary] [float] NULL,
[Scheduled_Pay_Period_Hours] [float] NULL,
[Labor_Allocation_Profile] [varchar] (25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Document_Group] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Employee_Added] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Hire_Date] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Last_Pay_Change] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Leave_End] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Leave_Start] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Part-Time_to_Full-Time_Date] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Previous_Termination_Date] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Rehire_Date] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[RetireeTermDate] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SeniorityDate] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Termination_Date] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EEO1_Ethnicity] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CampusLocation] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ContractHold] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Division] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DivisionHead] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DivisionHeadTitle] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EEName] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FTE] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[HourlyRate] [float] NULL,
[HighestDegree] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IndexJobDefinition] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Major1] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PositionStatus] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[StipendRoless] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[TotalComp] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[textCampusLocation] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[textInsSupportStaff] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[textJobDefinition] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO