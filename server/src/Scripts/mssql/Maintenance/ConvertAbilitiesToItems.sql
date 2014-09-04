	use gameid_v1

	declare @abilities varchar(1024)
	declare @CustomerID int

	DECLARE t_ab_Cursor CURSOR FOR SELECT CustomerID, abilities from ProfileData
	OPEN t_ab_Cursor
	FETCH NEXT FROM t_ab_Cursor into @CustomerID, @abilities
	while @@FETCH_STATUS = 0 
	begin

		declare @i int = 1
		while(@i <= 12) 
		begin
			declare @sv char(1) = SUBSTRING(@abilities, @i, 1)
			if(@sv = '1') begin
				declare @AbItemId int = 301059 + @i
				-- select @CustomerID, @abilities, @AbItemId
				exec FN_AddItemToUser @CustomerID, @AbItemId, 2000
			end

			set @i = @i + 1
		end

		FETCH NEXT FROM t_ab_Cursor into @CustomerID, @abilities
	end
	CLOSE t_ab_Cursor
	DEALLOCATE t_ab_Cursor
