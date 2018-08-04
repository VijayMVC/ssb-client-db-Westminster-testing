CREATE TYPE [dbo].[UploadREGoStaging_Type] AS TABLE
(
[SessionId] [uniqueidentifier] NULL,
[DynamicData] [xml] NULL,
[Bio ID] [varchar] (20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_01_Attended] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_01_Ev_Name] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_02_Attended] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_02_Ev_Name] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_03_Attended] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_03_Ev_Name] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_04_Attended] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_04_Ev_Name] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_05_Attended] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_05_Ev_Name] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_06_Attended] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_06_Ev_Name] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_07_Attended] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_07_Ev_Name] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_08_Attended] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_08_Ev_Name] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_09_Attended] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_09_Ev_Name] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_10_Attended] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_10_Ev_Name] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_11_Attended] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_11_Ev_Name] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_12_Attended] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_12_Ev_Name] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_13_Attended] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_13_Ev_Name] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_14_Attended] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_14_Ev_Name] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_15_Attended] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_15_Ev_Name] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_16_Attended] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_16_Ev_Name] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_17_Attended] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_17_Ev_Name] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_18_Attended] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_18_Ev_Name] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_19_Attended] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_19_Ev_Name] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_20_Attended] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_20_Ev_Name] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_21_Attended] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_21_Ev_Name] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_22_Attended] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_22_Ev_Name] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_23_Attended] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_23_Ev_Name] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_24_Attended] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_24_Ev_Name] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_25_Attended] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_25_Ev_Name] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_26_Attended] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_26_Ev_Name] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_27_Attended] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_27_Ev_Name] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_28_Attended] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_28_Ev_Name] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_29_Attended] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_29_Ev_Name] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_30_Attended] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_30_Ev_Name] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_31_Attended] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_31_Ev_Name] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_32_Attended] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_32_Ev_Name] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_33_Attended] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_33_Ev_Name] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_34_Attended] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_34_Ev_Name] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_35_Attended] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_35_Ev_Name] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_36_Attended] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_36_Ev_Name] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_37_Attended] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_37_Ev_Name] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_38_Attended] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_38_Ev_Name] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_39_Attended] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_39_Ev_Name] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_40_Attended] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_40_Ev_Name] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_41_Attended] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_41_Ev_Name] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_42_Attended] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_42_Ev_Name] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_43_Attended] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_43_Ev_Name] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_44_Attended] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_44_Ev_Name] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_45_Attended] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_45_Ev_Name] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_46_Attended] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_46_Ev_Name] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_47_Attended] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_47_Ev_Name] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_48_Attended] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_48_Ev_Name] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_49_Attended] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_49_Ev_Name] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_50_Attended] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_50_Ev_Name] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_51_Attended] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_51_Ev_Name] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_52_Attended] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_52_Ev_Name] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_53_Attended] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_53_Ev_Name] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_54_Attended] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_54_Ev_Name] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_55_Attended] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_55_Ev_Name] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_56_Attended] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_56_Ev_Name] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_57_Attended] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_57_Ev_Name] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_58_Attended] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_58_Ev_Name] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_59_Attended] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_59_Ev_Name] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_60_Attended] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_60_Ev_Name] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_61_Attended] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_61_Ev_Name] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_62_Attended] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_62_Ev_Name] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_63_Attended] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_63_Ev_Name] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_64_Attended] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_64_Ev_Name] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_65_Attended] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_65_Ev_Name] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_66_Attended] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_66_Ev_Name] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_67_Attended] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_67_Ev_Name] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_68_Attended] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_68_Ev_Name] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_69_Attended] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_69_Ev_Name] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_70_Attended] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_70_Ev_Name] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_71_Attended] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_71_Ev_Name] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_72_Attended] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_72_Ev_Name] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_73_Attended] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_73_Ev_Name] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_74_Attended] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_74_Ev_Name] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_75_Attended] [varchar] (5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CnPrt_1_75_Ev_Name] [varchar] (250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
