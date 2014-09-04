
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE PROCEDURE [dbo].[WO_FriendGetStatus]
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
		as 'GameSessionID',
		c.*
	from FriendsMap f, LoginID l
	left join ClanData c on c.ClanID=l.ClanID
	where f.CustomerID=@in_CustomerID and f.FriendStatus=2
		and l.CustomerID=f.FriendID
		
	-- pending add requests
	select 
		f.CustomerID,
		l.Gamertag,
		l.HonorPoints,
		c.*
	from FriendsMap f, LoginID l
	left join ClanData c on c.ClanID=l.ClanID
	where f.FriendID=@in_CustomerID and FriendStatus=1
		and l.CustomerID=f.CustomerID

END

GO
