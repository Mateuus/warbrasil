USE [gameid_v1]
GO

/****** Object:  StoredProcedure [dbo].[ECLIPSE_CREATEACCOUNT]    Script Date: 03/26/2012 12:10:43 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



ALTER PROCEDURE [dbo].[ECLIPSE_CREATEACCOUNT]
	@in_IP varchar(64),
	@in_Username varchar(16),
	@in_Password varchar(16), 
	@in_Email varchar(100),
	@in_InviteCode varchar(100),
	@in_ReferralID int
AS
BEGIN
	SET NOCOUNT ON;

	-- validate that username & email is unique
	if exists (SELECT CustomerID FROM LoginID WHERE AccountName=@in_Username) begin
		select 1 as ResultCode, 'Username already in use' as ResultMsg;
		return;
	end
	if exists (SELECT CustomerID FROM LoginID WHERE Gamertag=@in_Username) begin
		select 1 as ResultCode, 'Gamertag already in use' as ResultMsg;
		return;
	end
	if exists (SELECT CustomerID from AccountInfo WHERE email=@in_Email) begin
		select 2 as ResultCode, 'Email already in use' as ResultMsg;
		return;
	end
	-- do not allow to use 10minute emails
	if (CHARINDEX('@nepwk.com', @in_Email) > 0) OR 
	   (CHARINDEX('@TempEMail.net', @in_Email) > 0) OR 
	   (CHARINDEX('@sharklasers.com', @in_Email) > 0) OR 
	   (CHARINDEX('@mailinator.com', @in_Email) > 0) OR 
	   (CHARINDEX('@yopmail.com', @in_Email) > 0) OR 
	   (CHARINDEX('@tempinbox.com', @in_Email) > 0) begin
		select 2 as ResultCode, 'Email already in use' as ResultMsg;
		return;
	end

	-- create user
	declare @MD5FromPwd varchar(100)
	exec FN_CreateMD5Password @in_Password, @MD5FromPwd OUTPUT
	INSERT INTO LoginID 
		(AccountName, Password, Gamertag, dateregistered, ReferralID, MD5Password) 
		VALUES 
		(@in_Username, '', @in_Username, GETDATE(), @in_ReferralID, @MD5FromPwd)

	declare @CustomerID int
	SELECT @CustomerID=CustomerID from LoginID where AccountName=@in_Username

	-- create user
	INSERT INTO AccountInfo (CustomerID, email) VALUES (@CustomerID, @in_Email)
	INSERT INTO Stats (CustomerID) VALUES (@CustomerID)
	INSERT INTO ProfileData (CustomerID) VALUES (@CustomerID)
	
	-- NOTE: no default items is added, because they will be added in WelcomePackage
	-- but you can add new items based on @RefferalID
	
	/*
	-- IGN CODE
	if(@in_ReferralID = 23793) begin
		exec FN_AddItemToUser @CustomerID, 101209, 2000
		exec FN_AddItemToUser @CustomerID, 20029, 2000
		exec FN_AddItemToUser @CustomerID, 20031, 2000
		exec FN_AddItemToUser @CustomerID, 301000, 7
	end
	*/
	
	-- REFERAL ID PROMO
	-- functactix.com 
	--if(@in_ReferralID = 1288885485) begin
		-- no rewards. rev share link
	--end
	-- radio KOMP, WEND, KDGE, KYKY, sportbyline, AFN
	if(@in_ReferralID=1288943664 OR @in_ReferralID=1288943665 OR @in_ReferralID=1288943666 OR @in_ReferralID=1288943667 or @in_ReferralID=1288948397 or @in_ReferralID=1288948399) begin
		exec FN_AddItemToUser @CustomerID, 101077, 7
		exec FN_AddItemToUser @CustomerID, 101064, 7
		exec FN_AddItemToUser @CustomerID, 101084, 7
		
		exec FN_AddItemToUser @CustomerID, 20092, 2000
		-- branded MTV armor
		if(@in_ReferralID=1288943664) begin -- KOMP
			exec FN_AddItemToUser @CustomerID, 20108, 2000
		end
		else if(@in_ReferralID=1288943665) begin -- WEND
			exec FN_AddItemToUser @CustomerID, 20110, 2000
		end
		else if(@in_ReferralID=1288943666) begin -- KDGE
			exec FN_AddItemToUser @CustomerID, 20109, 2000
		end
		else begin -- others regular MTV
			exec FN_AddItemToUser @CustomerID, 20056, 2000
		end
		
		exec FN_AddItemToUser @CustomerID, 101196, 2000
		
		exec FN_AddItemToUser @CustomerID, 301004, 7
	end
	
	
	-- done
	select 0 as ResultCode, @CustomerID as CustomerID
	select @CustomerID as CustomerID
END



GO


