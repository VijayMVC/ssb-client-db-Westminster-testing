SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [rpt].[vwSeniorGPA] AS 

WITH gpa AS (


   SELECT  [SCHOOL_ID]
      ,[SCHOOL_ID_SORT]
      ,[ACADEMIC_YR]
      ,[STUDENT_ID]
	  , unpvt.GPA,
        unpvt.GPAno
FROM 
   (SELECT SCHOOL_ID,
           SCHOOL_ID_SORT,
           ACADEMIC_YR,
           STUDENT_ID,
           cast(GPA_01 as float) GPA_01,
           cast(GPA_02 as float) GPA_02,
           cast(GPA_03 as float) GPA_03,
           cast(GPA_04 as float) GPA_04,
           cast(GPA_05 as float) GPA_05,
           cast(GPA_06 as float) GPA_06,
           cast(GPA_07 as float) GPA_07,
           cast(GPA_08 as float) GPA_08,
           cast(GPA_09 as float) GPA_09,
           cast(GPA_10 as float) GPA_10,
           cast(GPA_11 as float) GPA_11,
           cast(GPA_12 as float) GPA_12,
           cast(GPA_13 as float) GPA_13,
           cast(GPA_14 as float) GPA_14,
           cast(GPA_15 as float) GPA_15,
           cast(GPA_16 as float) GPA_16,
           cast(GPA_17 as float) GPA_17,
           cast(GPA_18 as float) GPA_18,
           cast(GPA_19 as float) GPA_19,
           cast(GPA_20 as float) GPA_20,
           cast(GPA_21 as float) GPA_21,
           cast(GPA_22 as float) GPA_22,
           cast(GPA_23 as float) GPA_23,
           cast(GPA_24 as float) GPA_24,
           cast(GPA_25 as float) GPA_25,
           cast(GPA_26 as float) GPA_26,
           cast(GPA_27 as float) GPA_27,
           cast(GPA_28 as float) GPA_28,
           cast(GPA_29 as float) GPA_29,
           cast(GPA_30 as float) GPA_30,
           cast(GPA_31 as float) GPA_31,
           cast(GPA_32 as float) GPA_32,
           cast(GPA_33 as float) GPA_33,
           cast(GPA_34 as float) GPA_34,
           cast(GPA_35 as float) GPA_35,
           cast(GPA_36 as float) GPA_36,
           cast(GPA_37 as float) GPA_37,
           cast(GPA_38 as float) GPA_38,
           cast(GPA_39 as float) GPA_39,
           cast(GPA_40 as float) GPA_40,
           cast(GPA_41 as float) GPA_41,
           cast(GPA_42 as float) GPA_42,
           cast(GPA_43 as float) GPA_43,
           cast(GPA_44 as float) GPA_44,
           cast(GPA_45 as float) GPA_45,
           cast(GPA_46 as float) GPA_46,
           cast(GPA_47 as float) GPA_47,
           cast(GPA_48 as float) GPA_48,
           cast(GPA_49 as float) GPA_49,
           cast(GPA_50 as float) GPA_50
   FROM [import].[Senior_GPA_History]) p
UNPIVOT
   (GPA FOR GPAno IN 
      ([GPA_01]
      ,[GPA_02]
      ,[GPA_03]
      ,[GPA_04]
      ,[GPA_05]
      ,[GPA_06]
      ,[GPA_07]
      ,[GPA_08]
      ,[GPA_09]
      ,[GPA_10]
      ,[GPA_11]
      ,[GPA_12]
      ,[GPA_13]
      ,[GPA_14]
      ,[GPA_15]
      ,[GPA_16]
      ,[GPA_17]
      ,[GPA_18]
      ,[GPA_19]
      ,[GPA_20]
      ,[GPA_21]
      ,[GPA_22]
      ,[GPA_23]
      ,[GPA_24]
      ,[GPA_25]
      ,[GPA_26]
      ,[GPA_27]
      ,[GPA_28]
      ,[GPA_29]
      ,[GPA_30]
      ,[GPA_31]
      ,[GPA_32]
      ,[GPA_33]
      ,[GPA_34]
      ,[GPA_35]
      ,[GPA_36]
      ,[GPA_37]
      ,[GPA_38]
      ,[GPA_39]
      ,[GPA_40]
      ,[GPA_41]
      ,[GPA_42]
      ,[GPA_43]
      ,[GPA_44]
      ,[GPA_45]
      ,[GPA_46]
      ,[GPA_47]
      ,[GPA_48]
      ,[GPA_49]
      ,[GPA_50])
)AS unpvt)   

--SELECT DISTINCT gpa_name FROM import.Senior_GPA_Definition

SELECT a.SCHOOL_ID,a.ACADEMIC_YR,a.STUDENT_ID,b.GPA_NAME, gpa 
, CAST(a.ACADEMIC_YR AS VARCHAR) + '_' + CASE WHEN b.GPA_NAME LIKE 'hs%' THEN '1' ELSE RIGHT(b.GPA_NAME,1) END sortOrder
FROM gpa a 
JOIN  [import].[Senior_GPA_Definition] b ON b.ACADEMIC_YR = a.ACADEMIC_YR 
AND b.SCHOOL_ID = a.SCHOOL_ID
AND CAST(REPLACE(a.gpano,'gpa_','') AS INT) = b.GPA_NO
WHERE b.GPA_NAME  IN ('HS Average','Semester 1','Semester 2')
--ORDER BY a.STUDENT_ID, a.ACADEMIC_YR, 
GO
