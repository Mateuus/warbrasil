USE [gameid_v1]
GO
/****** Object:  StoredProcedure [dbo].[WO_FriendAddAns]    Script Date: 09/08/2011 14:22:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[WO_FriendAddAns]
	@in_CustomerID int,
	@in_FriendID int,
	@in_Allow int
AS
BEGIN
	SET NOCOUNT ON;

	declare @FriendStatus int
	
	-- check if we have that request
	select @FriendStatus=FriendStatus from FriendsMap 
		where CustomerID=@in_FriendID and FriendID=@in_CustomerID 
	if(@@ROWCOUNT = 0) begin
		select 6 as ResultCode
		return
	end
	
	if(@in_Allow = 0) 
	begin
		-- declined
		update FriendsMap set FriendStatus=3
			where CustomerID=@in_FriendID and FriendID=@in_CustomerID
		
		select 0 as ResultCode
		return
	end
	
	-- delete friend pair
	delete FriendsMap where CustomerID=@in_CustomerID and FriendID=@in_FriendID 
	delete FriendsMap where CustomerID=@in_FriendID   and FriendID=@in_CustomerID
	
	-- insert friend pair
	insert into FriendsMap values
		(@in_CustomerID, @in_FriendID,   2, GETDATE())
		
	if(@in_FriendID != @in_CustomerID) begin
		insert into FriendsMap values
			(@in_FriendID,   @in_CustomerID, 2, GETDATE())
	end
	
	select 0 as ResultCode
	return
	
END
