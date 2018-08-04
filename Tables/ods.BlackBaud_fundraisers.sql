CREATE TABLE [ods].[BlackBaud_fundraisers]
(
[constituent_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[FundRaiserCount] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[FundRaiser_constituent_id] [nvarchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[FundRaiser_type] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ETL_CreatedOn] [datetime] NOT NULL CONSTRAINT [DF__BlackBaud__ETL_C__563585EB] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_CreatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__BlackBaud__ETL_C__5729AA24] DEFAULT (suser_sname()),
[ETL_UpdatedOn] [datetime] NOT NULL CONSTRAINT [DF__BlackBaud__ETL_U__581DCE5D] DEFAULT ([etl].[ConvertToLocalTime](CONVERT([datetime2](0),getdate(),(0)))),
[ETL_UpdatedBy] [nvarchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF__BlackBaud__ETL_U__5911F296] DEFAULT (suser_sname())
)
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
----------- CREATE TRIGGER -----------
CREATE TRIGGER [ods].[Snapshot_BlackBaud_fundraisersUpdate] ON [ods].[BlackBaud_fundraisers]
AFTER UPDATE, DELETE

AS
BEGIN

DECLARE @ETL_UpdatedOn DATETIME = (SELECT [etl].[ConvertToLocalTime](CAST(GETDATE() AS DATETIME2(0))))
DECLARE @ETL_UpdatedBy NVARCHAR(400) = (SELECT SYSTEM_USER)

UPDATE t SET
[ETL_UpdatedOn] = @ETL_UpdatedOn
,[ETL_UpdatedBy] = @ETL_UpdatedBy
FROM [ods].[BlackBaud_fundraisers] t
	JOIN inserted i ON  t.[constituent_id] = i.[constituent_id] AND t.[FundRaiser_constituent_id] = i.[FundRaiser_constituent_id]

INSERT INTO [ods].[Snapshot_BlackBaud_fundraisers] ([constituent_id],[FundRaiserCount],[FundRaiser_constituent_id],[FundRaiser_type],[ETL_CreatedOn],[ETL_CreatedBy],[ETL_UpdatedOn],[ETL_UpdatedBy],[RecordEndDate])
SELECT a.*,dateadd(s,-1,@ETL_UpdatedOn)
FROM deleted a

END
GO
ALTER TABLE [ods].[BlackBaud_fundraisers] ADD CONSTRAINT [PK__BlackBau__5ADCE17B1E14F533] PRIMARY KEY CLUSTERED  ([constituent_id], [FundRaiser_constituent_id], [FundRaiser_type])
GO
