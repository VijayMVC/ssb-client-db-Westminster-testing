SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE proc [etl].[MergeToOds]
@TargetTable NVARCHAR(500)
AS 

--etl.MergeToOds '[ods].[Paycom_Employees]'

BEGIN

	DECLARE @sql NVARCHAR(MAX)
	,@TaskName NVARCHAR(MAX)

	SELECT
		@SQL = [RunSQL]
		,@TaskName = [TaskName]
	FROM [etl].[Task]
	WHERE [Target] = @TargetTable


	DECLARE @BatchID INT
	INSERT INTO [audit].[TaskBatchLog] ([ParentID],[Step],[RunSQL],[ExecuteStart])
	VALUES (NULL,'Merge to ODS',@SQL,(SELECT [etl].[ConvertToLocalTime](GetDate())))
	SET @BatchID = SCOPE_IDENTITY()

	EXEC [etl].[RunSQL]
		@BatchID = @BatchID
		,@TaskName = @TaskName
		,@Target = @TargetTable
		,@SQL = @SQL

END

--[audit].[TaskBatchLog]  ORDER BY 1 DESC
--[audit].[TaskLog]  ORDER BY 1 desc
GO
