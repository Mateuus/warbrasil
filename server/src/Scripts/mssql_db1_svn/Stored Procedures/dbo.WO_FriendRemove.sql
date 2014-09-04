SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[WO_FriendRemove]
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
GO
