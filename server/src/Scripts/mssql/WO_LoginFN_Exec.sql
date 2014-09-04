USE [gameid_v1]
GO
/****** Object:  StoredProcedure [dbo].[WO_LoginFN_Exec]    Script Date: 07/24/2011 09:46:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[WO_LoginFN_Exec]
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
			@AccountStatus as AccountStatus
		return
	end
	
	-- ban by IP one annoying idiot
	if(@in_IP = '76.102.5.49' OR @in_IP='67.180.72.74' OR @in_IP='76.188.209.197' OR @in_IP='24.59.16.107' OR @in_IP='98.206.222.214' OR @in_IP='98.206.222.214' OR @in_IP='50.4.0.95') begin
		select
			3 as LoginResult,
			@CustomerID as CustomerID,
			200 as AccountStatus
		return
	end
	
	declare @email varchar(100) = ''
	SELECT @email=email FROM AccountInfo WHERE CustomerID = @CustomerID
	if(@email like '%@klzlk.com') begin
		select
			3 as LoginResult,
			@CustomerID as CustomerID,
			200 as AccountStatus
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
	
	-- return session info
	SELECT 
		0 as LoginResult,
		@CustomerID as CustomerID,
		@AccountStatus as AccountStatus,
		@SessionID as SessionID
END