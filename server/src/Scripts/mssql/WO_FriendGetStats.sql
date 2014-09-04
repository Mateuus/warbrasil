USE [gameid_v1]
GO
/****** Object:  StoredProcedure [dbo].[WO_FriendGetStats]    Script Date: 09/08/2011 11:36:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[WO_FriendGetStats]
	@in_CustomerID int,
	@in_FriendID int
AS
BEGIN
	SET NOCOUNT ON;

	-- this call is always success
	select 0 as ResultCode
	
	if(@in_FriendID > 0) 
	begin
		-- specific friend statistics
		select FriendID, l.HonorPoints, s.*
			from FriendsMap f
			join Stats s on FriendID=s.CustomerID
			join LoginID l on FriendID=l.CustomerID
			where f.CustomerID=@in_CustomerID and FriendStatus=2
				and f.FriendID=@in_FriendID
	end
	else
	begin
		-- all your friend statistics
		select FriendID, l.HonorPoints, s.*
			from FriendsMap f
			join Stats s on FriendID=s.CustomerID
			join LoginID l on FriendID=l.CustomerID
			where f.CustomerID=@in_CustomerID and FriendStatus=2
	end
		
END
