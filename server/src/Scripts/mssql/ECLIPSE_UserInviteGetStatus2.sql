USE [gameid_v1]
GO
/****** Object:  StoredProcedure [dbo].[ECLIPSE_UserInviteGetStatus2]    Script Date: 02/01/2012 16:06:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[ECLIPSE_UserInviteGetStatus2] 
	@in_CustomerID int
AS
BEGIN
	SET NOCOUNT ON;

	select Gamertag, 
		email,
		lastgamedate,
		(select top(1) rank from DataRankPoints where LoginID.HonorPoints<DataRankPoints.HonorPoints order by HonorPoints asc) as 'Rank'
	from LoginID 
	join AccountInfo on AccountInfo.CustomerID=LoginID.CustomerID
	where ReferralID=@in_CustomerID
	order by Rank desc

END
