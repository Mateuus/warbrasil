
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO





CREATE PROCEDURE [dbo].[WO_LoginFN_Exec]
	@in_IP varchar(100),
	@CustomerID int,
	@AccountStatus int
AS
BEGIN
	SET NOCOUNT ON;
	
	--
	-- helper function that perform actual user login
	--

	-- status greater or equal to 200 means that user is banned
	if (@AccountStatus >= 200) begin
		select
			3 as LoginResult,
			@CustomerID as CustomerID,
			@AccountStatus as AccountStatus,
			0 as SessionID
		return
	end
	
	-- TEMP ban by IP one annoying idiot
	if(@in_IP = '24.128.30.151' OR @in_IP='122.61.157.213') begin
		select
			3 as LoginResult,
			@CustomerID as CustomerID,
			200 as AccountStatus,
			0 as SessionID
		return
	end
	
	declare @email varchar(100) = ''
	SELECT @email=email FROM AccountInfo WHERE CustomerID = @CustomerID
	if(@email like '%@klzlk.com') begin
		select
			3 as LoginResult,
			@CustomerID as CustomerID,
			200 as AccountStatus,
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

	-- get dev status - need to avoid region lock
	declare @IsDeveloper int = 0
	select @IsDeveloper=IsDeveloper from LoginID where CustomerID=@CustomerID
	
	-- update other tables
	UPDATE LoginID SET 
		lastlogindate=GETDATE(), 
		lastloginIP=@in_IP
	WHERE CustomerID=@CustomerID
	
	INSERT INTO Logins 
		(CustomerID, LoginTime, IP, LoginSource) 
	VALUES 
		(@CustomerID, GETDATE(), @in_IP, 0)

	--	exec FN_AddItemToUser @CustomerID, 101033, 2000 -- Thanksgiving weekend
	
	-- return session info
	SELECT 
		0 as LoginResult,
		@CustomerID as CustomerID,
		@AccountStatus as AccountStatus,
		@SessionID as SessionID,
		@IsDeveloper as IsDeveloper
END




GO
