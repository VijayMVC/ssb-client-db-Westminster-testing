SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO



CREATE PROCEDURE [etl].[LogEventRecord] 
(
	@BatchId NVARCHAR(50) = NULL,
	@Client NVARCHAR(255) = NULL, 
	@EventLevel NVARCHAR(255) = 'Info', 	
	@EventSource NVARCHAR(255) = NULL, 
	@EventCategory NVARCHAR(255) = NULL,
	@LogEvent NVARCHAR(255), 
	@LogMessage NVARCHAR(2000) = NULL,
	@ExecutionId UNIQUEIDENTIFIER = NULL
)
AS

BEGIN

SET NOCOUNT ON;

SET @BatchId = ISNULL(@BatchId, CONVERT(NVARCHAR(50), NEWID()))

BEGIN TRY

	INSERT INTO etl.EventLog (BatchId, Client, EventLevel, EventSource, EventCategory, LogEvent, LogMessage, EventDate, ExecutionId, UserName, SourceSystem)
	VALUES (@BatchId, DB_NAME(), @EventLevel, @EventSource, @EventCategory, @LogEvent, @LogMessage, GETDATE(), ISNULL(@ExecutionId, NEWID()), SUSER_NAME(), HOST_NAME())

END TRY
BEGIN CATCH

END CATCH

END





GO
