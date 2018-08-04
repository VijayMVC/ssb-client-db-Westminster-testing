CREATE TABLE [rpt].[BusinessRuleWeights]
(
[ID] [int] NOT NULL IDENTITY(1, 1),
[BusinessRule] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Weight] [float] NULL,
[IsDeleted] [bit] NULL CONSTRAINT [DF__BusinessR__IsDel__0CAC982A] DEFAULT ((0)),
[ETL_CreatedOn] [datetime] NOT NULL CONSTRAINT [DF__BusinessR__ETL_C__0DA0BC63] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__BusinessR__ETL_C__0E94E09C] DEFAULT (suser_sname()),
[ETL_UpdatedOn] [datetime] NOT NULL CONSTRAINT [DF__BusinessR__ETL_U__0F8904D5] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__BusinessR__ETL_U__107D290E] DEFAULT (suser_sname())
)
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE TRIGGER [rpt].[BusinessRuleWeightsUpdate] ON [rpt].[BusinessRuleWeights]
AFTER UPDATE

AS
BEGIN

DECLARE @ETL_UpdatedOn DATETIME = (SELECT [etl].[ConvertToLocalTime](CAST(GETDATE() AS DATETIME2(0))))
DECLARE @ETL_UpdatedBy NVARCHAR(400) = (SELECT SYSTEM_USER)

UPDATE t SET
[ETL_UpdatedOn] = @ETL_UpdatedOn
,[ETL_UpdatedBy] = @ETL_UpdatedBy
FROM rpt.BusinessRuleWeights t
	JOIN inserted i ON  t.ID = i.ID

END



GO
