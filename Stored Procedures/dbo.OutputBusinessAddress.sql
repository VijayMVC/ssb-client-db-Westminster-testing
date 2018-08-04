SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


CREATE PROC [dbo].[OutputBusinessAddress] 
	@IssueID	INT 
	AS
--[dbo].[OutputBusinessAddress]  1

SELECT 'Senior Systems Record - This will be Changed' UpdateHeader, bi.EntityNo, bi.OtherID AS AddressNumber, CONCAT(pa.Address1, pa.Address2, pa.Address3) Address, pa.City, pa.State,pa.Zip ,
'Raisers Edge Source Record - This will be the new address in Senior' SourceHeader, bi.Constituent_ID, bi.SourceOtherID AS Address_ID, a.Formatted_address Address, a.City, a.State,a.Postal_Code
FROM dbo.BizRule_Issues bi
JOIN ods.BlackBaud_addresses a (NOLOCK) ON a.constituent_id = bi.Constituent_ID AND bi.SourceOtherID = a.address_id
JOIN ods.SeniorSystems_persons_address pa (NOLOCK) ON pa.EntityNo = bi.EntityNo AND bi.OtherID = pa.AddressNumber
WHERE bi.IssueID = @IssueID
GO
