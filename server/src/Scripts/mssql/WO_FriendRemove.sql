USE [gameid_v1]
GO
/****** Object:  StoredProcedure [dbo].[WO_FriendRemove]    Script Date: 09/08/2011 13:49:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[WO_FriendRemove]
	@in_CustomerID int,
	@in_FriendID int
AS
BEGIN
	SET NOCOUNT ON;

	declare @FriendStatus int
	
	-- delete mutual friend map
	delete FriendsMap where CustomerID=@in_CustomerID and FriendID=@in_FriendID 
	delete FriendsMap where CustomerID=@in_FriendID   and FriendID=@in_CustomerID

	select 0 as ResultCode
END
