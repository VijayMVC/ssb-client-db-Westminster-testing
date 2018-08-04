SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

/*
-- Get the status of your table 20 minutes ago...
DECLARE @AsOfDate DATETIME = (SELECT [etl].[ConvertToLocalTime](DATEADD(MINUTE,-20,GETDATE())))
SELECT * FROM [ods].[AsOf_Schoology_grading_scales] (@AsOfDate)
*/

CREATE FUNCTION [ods].[AsOf_Schoology_grading_scales] (@AsOfDate DATETIME)

RETURNS @Results TABLE
(
[Section_ID] [nvarchar](50) NULL,
[gradingscale_id] [nvarchar](50) NULL,
[title] [nvarchar](100) NULL,
[type] [nvarchar](50) NULL,
[auto_averaging] [bit] NULL,
[hide_numeric] [bit] NULL,
[Grandingscale_level] [nvarchar](50) NULL,
[grade] [nvarchar](50) NULL,
[cutoff] [float] NULL,
[average] [float] NULL,
[description] [nvarchar](500) NULL,
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
SELECT [Section_ID],[gradingscale_id],[title],[type],[auto_averaging],[hide_numeric],[Grandingscale_level],[grade],[cutoff],[average],[description],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy]
FROM
	(
	SELECT [Section_ID],[gradingscale_id],[title],[type],[auto_averaging],[hide_numeric],[Grandingscale_level],[grade],[cutoff],[average],[description],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],@EndDate [RecordEndDate]
	FROM [ods].[Schoology_grading_scales] t
	UNION ALL
	SELECT [Section_ID],[gradingscale_id],[title],[type],[auto_averaging],[hide_numeric],[Grandingscale_level],[grade],[cutoff],[average],[description],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate]
	FROM [ods].[Snapshot_Schoology_grading_scales]
	) a
WHERE
	@AsOfDate BETWEEN [ETL_UpdatedOn] AND [RecordEndDate]
	AND [ETL_CreatedOn] <= @AsOfDate

RETURN

END
GO
