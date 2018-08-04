SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROC [etl].[Reload_API_IDs_Queue]
AS

DECLARE @runtime DATETIME = GETDATE()
DECLARE @lastload DATETIME = (SELECT MAX(Queue_CreatedOn) FROM [etl].[API_IDs_Queue]) 


IF ISNULL(ABS(DATEDIFF(DAY,@runtime, @lastload)),99) > 10
	BEGIN
	TRUNCATE TABLE [etl].[API_IDs_Queue];

	INSERT INTO [etl].API_IDs_Queue
	(
	    APIName,
	    APIEntity,
	    EndpointName,
	    SourceID
	)
	SELECT 
	'RaisersEdge'
	,'Constituent'
	,'Ratings'
	,constituent_id
	FROM ods.BlackBaud_constituents (NOLOCK)
	WHERE inactive = 'false' AND deceased ='false'

	END


GO
