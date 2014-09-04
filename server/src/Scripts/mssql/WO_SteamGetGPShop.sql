USE [gameid_v1]
GO
/****** Object:  StoredProcedure [dbo].[WO_SteamGetGPShop]    Script Date: 06/28/2011 15:47:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[WO_SteamGetGPShop]
AS
BEGIN
	SET NOCOUNT ON;

	-- this call is always valid
	select 0 as ResultCode
	select * from SteamGPShop where IsEnabled>0 order by GP asc
	
END
