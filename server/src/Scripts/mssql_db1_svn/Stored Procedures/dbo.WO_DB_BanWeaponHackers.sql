SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[WO_DB_BanWeaponHackers]
AS  
BEGIN  
	SET NOCOUNT ON;  
	declare @hacks TABLE 
	(
		CustomerID int,
		data varchar(512)
	)

	declare @dt1 date = DATEADD(day, -1, GETDATE())

	-- select all hack attempts to table
	insert into @hacks 
		select CustomerID, data from DBG_SrvLogInfo where 
			ReportTime >= @dt1 and IsProcessed=0 and CheatID=3

	-- clear them
	update DBG_SrvLogInfo set IsProcessed=1 where
		ReportTime >= @dt1 and IsProcessed=0 and CheatID=3

	--
	-- main ban loop
	--
	declare @CustomerID int
	declare @HackData varchar(512)
	
	DECLARE t_cursor CURSOR FOR 
		select customerid, data from @hacks 

	OPEN t_cursor
	FETCH NEXT FROM t_cursor into @CustomerID, @HackData
	while @@FETCH_STATUS = 0 
	begin
		declare @admin_note varchar(512)
		declare @AccountStatus int

		select @AccountStatus=AccountStatus from LoginID where CustomerID=@CustomerID
		if(@AccountStatus = 101) 
		begin
			-- start banning
			select @admin_note=admin_note from AccountInfo where CustomerID=@CustomerID
			set @admin_note = 'WH:' + 
				convert(varchar(128), MONTH(GETDATE())) + 
				'/' + 
				convert(varchar(128), DAY(GETDATE())) + 
				':' + @HackData + 
				', ' + @admin_note
				
			-- actual ban
			update AccountInfo set admin_note=@admin_note where CustomerID=@CustomerID
			update LoginID set AccountStatus=200 where CustomerID=@CustomerID

			print @CustomerID
			print @admin_note
		end
		
		FETCH NEXT FROM t_cursor into @CustomerID, @HackData
	end
	close t_cursor
	deallocate t_cursor

END
GO
