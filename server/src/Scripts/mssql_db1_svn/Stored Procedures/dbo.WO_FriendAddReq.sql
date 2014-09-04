SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[WO_FriendAddReq]
	@in_CustomerID int,
	@in_FriendGamerTag nvarchar(64)
AS
BEGIN
	SET NOCOUNT ON;

	-- get customerid
	declare @FriendID int
	select @FriendID=CustomerID from LoginID where Gamertag=@in_FriendGamerTag
	if(@@ROWCOUNT = 0) begin
		select 6 as ResultCode, 'no such gamertag' as ResultMsg
		return
	end
	
	-- always success
	select 0 as ResultCode
	
	-- if we already have that friend
	declare @FriendStatus1 int = -1
	declare @FriendStatus2 int = -1
	
	select @FriendStatus1=FriendStatus from FriendsMap 
		where CustomerID=@in_CustomerID and FriendID=@FriendID
	select @FriendStatus2=FriendStatus from FriendsMap 
		where CustomerID=@FriendID and FriendID=@in_CustomerID
	if(@FriendStatus1 = 3 and @FriendStatus2 = 3) begin
		-- 2 way deny - permanent block
		select 4 as FriendStatus
		return
	end

	-- you already have that request
	if(@FriendStatus1 >= 0) begin
		select @FriendStatus1 as FriendStatus
		return
	end
	
	-- insert with status 1 (request sent)
	insert into FriendsMap values
		(@in_CustomerID, @FriendID, 1, GETDATE())
		
	select 0 as FriendStatus
END
GO
