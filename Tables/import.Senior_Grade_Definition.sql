CREATE TABLE [import].[Senior_Grade_Definition]
(
[SCHOOL_ID] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ACADEMIC_YR] [float] NULL,
[GRADE_NO] [float] NULL,
[NAME] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ABBREV] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[GRADE_ENTRY_TYPE] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[PERIOD_SORT_NO] [float] NULL,
[PERIOD_NAME] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[COPY_TO_FINAL] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CALCULATE_GPA] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CALCULATION_TYPE] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CALC_GRADE_NO1] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CALC_GRADE_NO2] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CALC_GRADE_NO3] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CALC_GRADE_NO4] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CALC_GRADE_NO5] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CALC_GRADE_NO6] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CALC_GRADE_NO7] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CALC_GRADE_NO8] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CALC_GRADE_NO9] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CALC_GRADE_NO10] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ON_TRANSCRIPT] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[EARNS_CREDIT] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SCAN_GRADE_NO] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[IN_CUMULATIVE_GPA] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[GR_BOOK_NAME] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[GR_BOOK_ABBREV] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[GR_BOOK_DUE_DATE] [datetime] NULL,
[GR_DISPLAY] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UPDATE_USER_NAME] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UPDATE_DATE_TIME] [datetime] NULL,
[RECORD_NUMBER] [float] NULL
)
GO
