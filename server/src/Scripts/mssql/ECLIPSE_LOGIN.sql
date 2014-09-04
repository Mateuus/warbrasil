USE [gameid_v1]
GO
/****** Object:  StoredProcedure [dbo].[ECLIPSE_LOGIN]    Script Date: 03/21/2012 10:31:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[ECLIPSE_LOGIN]
	@in_Username varchar(100), 
	@in_Password varchar(100),
	@in_IP varchar(100)
AS
BEGIN
	SET NOCOUNT ON;

	declare @CustomerID int
	declare @AccountStatus int
	declare @MD5Password varchar(100)
	declare @AccountName varchar(100)

	-- search for record with username
	SELECT 
		@CustomerID=CustomerID,
		@MD5Password=MD5Password,
		@AccountStatus=AccountStatus,
		@AccountName=AccountName
	FROM LoginID 
	WHERE AccountName=@in_Username
	if (@@RowCount = 0) begin
		--EXEC FN_ADD_SECURITY_LOG 100, @in_IP, 0, @in_Username
		select
			0 as CustomerID,
			0 as AccountStatus
		return
	end
	
	-- check MD5 password
	declare @MD5FromPwd varchar(100)
	exec FN_CreateMD5Password @in_Password, @MD5FromPwd OUTPUT
	if(@MD5Password <> @MD5FromPwd) begin
		--EXEC FN_ADD_SECURITY_LOG 101, @in_IP, @CustomerID, ''
		select
			0 as CustomerID,
			0 as AccountStatus
		return
	end

	-- store login attempt - NOT USED now, for retention bonuses faster check
	--INSERT INTO Logins 
	--	(CustomerID, LoginTime, IP, LoginSource) 
	--VALUES 
	--	(@CustomerID, GETDATE(), @in_IP, 1)

	-- status greater or equal to 200 means that user is banned
	if (@AccountStatus >= 200) begin
		select
			0 as CustomerID,
			@AccountStatus as AccountStatus
		return
	end

	select
		@CustomerID as CustomerID,
		@AccountStatus as AccountStatus,
		@AccountName as AccountName
	    
END
