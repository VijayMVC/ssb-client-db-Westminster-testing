CREATE TABLE [import].[Senior_Attendance_Current]
(
[STUDENT_ID] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ATTEND_DATE] [datetime] NULL,
[ATTEND_TERM] [float] NULL,
[ATTEND_PERIOD] [float] NULL,
[SECTION_ID] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[BLOCK_NO] [float] NULL,
[BLOCK_NAME] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[MEETING_RECORD_NO] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[LETTER_DATE] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ABSENCE_TYPE] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ABSENCE_POINTS] [float] NULL,
[ABSENCE_DESC] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ABSENCE_SORT] [float] NULL,
[ABSENCE_COUNT] [float] NULL,
[SCHOOL_ID] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[SCHOOL_ID_SORT] [float] NULL,
[FAC_ENTER_REVIEW] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[DN_ENTER_REVIEW] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UPDATE_USER_NAME] [nvarchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[UPDATE_DATE_TIME] [datetime] NULL
)
GO
