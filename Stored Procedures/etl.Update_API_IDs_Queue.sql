SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

create PROC [etl].[Update_API_IDs_Queue]
AS


WITH xx AS (
				SELECT TOP 10000 SourceID FROM etl.API_IDs_Queue 
				WHERE  APIName = 'RaisersEdge'
					AND APIEntity = 'Constituent'
					AND EndpointName = 'Ratings'
					AND IsCompleted = 0 
				ORDER BY QueueID

			)

	UPDATE a SET a.IsCompleted = 1
	from etl.API_IDs_Queue a
	WHERE a.SourceID IN (SELECT * FROM xx)
GO
