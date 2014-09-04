USE [gameid_v1]
GO
/****** Object:  StoredProcedure [dbo].[WO_GNALogin]    Script Date: 06/21/2011 14:38:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[WO_GNALogin]
	@in_IP varchar(64),
	@in_GNAUserId bigint,
	@in_GNANick nvarchar(32)
AS
BEGIN
	SET NOCOUNT ON;

	declare @CustomerID int
	declare @AccountStatus int
	
	-- this call is always valid
	select 0 as ResultCode

	-- check if we already have that user
	if (not exists (select CustomerID from LoginID where GNAUserID=@in_GNAUserId)) 
	begin
		-- user not exists, create NEW with temporary accountname
		declare @tempAccountName varchar(32) = convert(varchar(32), @in_GNAUserId)
		INSERT INTO LoginID 
			(AccountName, GNAUserId, Gamertag, dateregistered, ReferralID, Password) 
			VALUES 
			(@tempAccountName, @in_GNAUserId, @in_GNANick, GETDATE(), 0, '')

		-- get new CustomerID
		select @CustomerID=CustomerID from LoginID where GNAUserID=@in_GNAUserId

		-- create user
		INSERT INTO AccountInfo (CustomerID) VALUES (@CustomerID)
		INSERT INTO Stats (CustomerID) VALUES (@CustomerID)
		INSERT INTO ProfileData (CustomerID) VALUES (@CustomerID)
		INSERT INTO Profile_Loadouts (CustomerID, LoadoutSlots) VALUES (@CustomerID, 2)
	
		-- NOTE: no default items is added, because they will be added in WelcomePackage
	end
	
	-- select actual user info. Note that this call CAN NOT fail, as we always have user on GNA user Id
	select @CustomerID=CustomerID, @AccountStatus=AccountStatus from LoginID where GNAUserId=@in_GNAUserId
	
	-- status greater or equal to 200 means that user is banned
	if (@AccountStatus >= 200) begin
		select
			0 as LoginResult,
			@CustomerID as CustomerID,
			@AccountStatus as AccountStatus,
			0 as SessionID
		return
	end
	
	-- update session key/id
	declare @SessionKey varchar(50) = NEWID()
	declare @SessionID int = checksum(@SessionKey)
	if exists (SELECT CustomerID FROM LoginSessions WHERE CustomerID = @CustomerID)
	begin
		UPDATE LoginSessions SET 
			SessionKey=@SessionKey, 
			SessionID=@SessionID,
			LoginIP=@in_IP, 
			TimeLogged=GETDATE(), 
			TimeUpdated=GETDATE()
		WHERE CustomerID=@CustomerID
	end
	else
	begin
		INSERT INTO LoginSessions
			(CustomerID, SessionKey, SessionID, LoginIP, TimeLogged, TimeUpdated)
		VALUES 
			(@CustomerID, @SessionKey, @SessionID, @in_IP, GETDATE(), GETDATE())
	end
	
	-- update other tables
	UPDATE LoginID SET 
		lastlogindate=GETDATE(), 
		lastloginIP=@in_IP
	WHERE CustomerID=@CustomerID
	
	INSERT INTO Logins 
		(CustomerID, LoginTime, IP, LoginSource) 
	VALUES 
		(@CustomerID, GETDATE(), @in_IP, 0)
	
	-- return user data
	SELECT 
		0 as LoginResult,
		@CustomerID as CustomerID,
		@AccountStatus as AccountStatus,
		@SessionID as SessionID;
END
