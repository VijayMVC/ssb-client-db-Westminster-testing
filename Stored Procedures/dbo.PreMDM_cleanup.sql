SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [dbo].[PreMDM_cleanup]
AS


DECLARE @ID int
SET @ID = (SELECT MIN(ID) FROM stg.SeniorSystems_persons WHERE CAST(ETL__insert_datetime AS DATE) = CAST(GETDATE()-1 AS DATE))
--select top 50 * from stg.SeniorSystems_person order by ETL__insert_datetimedes
UPDATE stg.SeniorSystems_persons SET IsLoaded = 0 WHERE ID > = @ID

EXEC [etl].[JSONTranslator] 
@Step = 'Run ETL',
@StageSchema = 'stg',
@TableName = 'SeniorSystems_persons',
@RunFullSession = 1
,@SuppressPrint = 1

IF( SELECT COUNT(DISTINCT EntityNo) FROM [src].SeniorSystems_persons) > 14800
	BEGIN
		UPDATE a SET a.IsDeleted = 1, a.ETL_UpdatedOn =GETDATE() FROM  ods.SeniorSystems_persons a LEFT OUTER JOIN  (SELECT distinct EntityNo FROM [src].SeniorSystems_persons) b ON b.EntityNo = a.EntityNo
		WHERE b.EntityNo IS NULL
		AND a.IsDeleted = 0 
	END

GO
