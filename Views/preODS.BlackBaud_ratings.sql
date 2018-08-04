SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [preODS].[BlackBaud_ratings]
AS

SELECT DISTINCT
	 CONVERT(INT,RatingID					  )RatingID_K
	,CONVERT(NVARCHAR(500),RatingCategory			  )RatingCategory
	,CONVERT(NVARCHAR(MAX),RatingComment			  )RatingComment
	,CONVERT(INT,Constituent_ID			  )Constituent_ID
	,CONVERT(datetime2,RatingDate				  )RatingDate
	,CONVERT(NVARCHAR(10),Inactive					  )Inactive
	,CONVERT(NVARCHAR(500),RatingSource				  )RatingSource
	,CONVERT(NVARCHAR(500),RatingType				  )RatingType
	,CONVERT(NVARCHAR(500),RatingValue				  )RatingValue
FROM [src].[BlackBaud_ratings] WITH (NOLOCK)
GO
