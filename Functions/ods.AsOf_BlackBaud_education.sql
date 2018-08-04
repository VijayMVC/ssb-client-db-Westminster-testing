SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

/*
-- Get the status of your table 20 minutes ago...
DECLARE @AsOfDate DATETIME = (SELECT [etl].[ConvertToLocalTime](DATEADD(MINUTE,-20,GETDATE())))
SELECT * FROM [ods].[AsOf_BlackBaud_education] (@AsOfDate)
*/

CREATE FUNCTION [ods].[AsOf_BlackBaud_education] (@AsOfDate DATETIME)

RETURNS @Results TABLE
(
[Edcucationid] [nvarchar](50) NULL,
[constituent_id] [nvarchar](50) NULL,
[school] [nvarchar](250) NULL,
[type] [nvarchar](250) NULL,
[class_of] [nvarchar](50) NULL,
[primary] [nvarchar](10) NULL,
[degree] [nvarchar](100) NULL,
[majors] [nvarchar](max) NULL,
[Date_Entered] [date] NULL,
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
SELECT [Edcucationid],[constituent_id],[school],[type],[class_of],[primary],[degree],[majors],[Date_Entered],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy]
FROM
	(
	SELECT [Edcucationid],[constituent_id],[school],[type],[class_of],[primary],[degree],[majors],[Date_Entered],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],@EndDate [RecordEndDate]
	FROM [ods].[BlackBaud_education] t
	UNION ALL
	SELECT [Edcucationid],[constituent_id],[school],[type],[class_of],[primary],[degree],[majors],[Date_Entered],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate]
	FROM [ods].[Snapshot_BlackBaud_education]
	) a
WHERE
	@AsOfDate BETWEEN [ETL_UpdatedOn] AND [RecordEndDate]
	AND [ETL_CreatedOn] <= @AsOfDate

RETURN

END
GO
