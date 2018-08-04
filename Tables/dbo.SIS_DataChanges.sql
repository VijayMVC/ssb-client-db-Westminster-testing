CREATE TABLE [dbo].[SIS_DataChanges]
(
[DataChangeID] [int] NOT NULL IDENTITY(1, 1),
[SSID] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ChangeDate] [date] NOT NULL,
[FieldName] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Current_Value] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Previous_Value] [varchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ChangeType] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ParentSSID] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
