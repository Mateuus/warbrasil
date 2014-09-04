USE [gameid_v1]
GO
/****** Object:  StoredProcedure [dbo].[WO_SteamLogin]    Script Date: 06/28/2011 22:19:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[WO_SteamLinkAccount]
	@in_CustomerID int,
	@in_SteamID bigint
AS
BEGIN
	SET NOCOUNT ON;
	
	select 0 as ResultCode
	insert into SteamUserIDMap (CustomerID, SteamID) values (@in_CustomerID, @in_SteamID)
END
