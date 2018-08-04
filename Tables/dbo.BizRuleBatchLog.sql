CREATE TABLE [dbo].[BizRuleBatchLog]
(
[ID] [int] NOT NULL IDENTITY(1, 1),
[ExecuteStart] [datetime] NULL,
[ExecuteEnd] [datetime] NULL,
[ExecutionRuntimeSeconds] AS (CONVERT([float],datediff(second,[ExecuteStart],[ExecuteEnd]),(0))),
[CreatedOn] [datetime] NULL CONSTRAINT [DF__BizRuleBa__Creat__53AD7D10] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[CreatedBy] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL CONSTRAINT [DF__BizRuleBa__Creat__54A1A149] DEFAULT (suser_sname())
)
GO
ALTER TABLE [dbo].[BizRuleBatchLog] ADD CONSTRAINT [PK__BizRuleB__3214EC2778D65BBD] PRIMARY KEY CLUSTERED  ([ID])
GO
