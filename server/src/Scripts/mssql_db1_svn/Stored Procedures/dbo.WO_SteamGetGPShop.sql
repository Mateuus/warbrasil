SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[WO_SteamGetGPShop]
AS
BEGIN
	SET NOCOUNT ON;

	-- this call is always valid
	select 0 as ResultCode
	select * from SteamGPShop where IsEnabled>0 order by GP asc
	
END
GO
