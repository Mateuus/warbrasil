USE [gameid_v1]
GO
/****** Object:  StoredProcedure [dbo].[WO_FriendGetStatus]    Script Date: 09/08/2011 14:23:25 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[WO_FriendGetStatus]
	@in_CustomerID int
AS
BEGIN
	SET NOCOUNT ON;

	-- this call is always success
	select 0 as ResultCode
	
	declare @OnlineTime datetime = DATEADD(minute, -2, GETDATE())

	-- your friends
	select 
		FriendID, 
		-- gamertag
		l.Gamertag,
		-- online status
		(case when exists 
			(select CustomerID from LoginSessions 
				where LoginSessions.CustomerID=f.FriendID
					and TimeUpdated > @OnlineTime)
		then 1
		else 0
		end)
		as 'Online',
		-- game id
		(select GameSessionID from LoginSessions 
				where LoginSessions.CustomerID=f.FriendID)
		as 'GameSessionID'
	from FriendsMap f, LoginID l
	where f.CustomerID=@in_CustomerID and f.FriendStatus=2
		and l.CustomerID=f.FriendID
		
	-- pending add requests
	select 
		f.CustomerID,
		l.Gamertag,
		l.HonorPoints
	from FriendsMap f, LoginID l
	where f.FriendID=@in_CustomerID and FriendStatus=1
		and l.CustomerID=f.CustomerID

END
