SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE PROCEDURE [dbo].[RPT_PayingPerCountry]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	declare @StartTime datetime = '4-1-2012'
	declare @EndTime   datetime = '5-12-4000'

	select
		ai.GeoCode,
		COUNT(l.CustomerID) as 'Registered',
		COUNT(distinct(f.CustomerID)) as 'Paying', 
		SUM(f.amount) as 'Profit',
		SUM(f.amount) / COUNT(l.CustomerID) as 'ProfitPerUser',
		COUNT(distinct(f.CustomerID)) * 100.0 / COUNT(l.CustomerID) as 'Registered/Paying %',
		(select CountryName from DataCountryCodes where CountryCode=ai.GeoCode)
	from LoginID l
		join AccountInfo ai on ai.CustomerID=l.CustomerID
		left join FinancialTransactions f on (f.CustomerID=l.CustomerID and TransactionType=1000)
	where dateregistered>=@StartTime and dateregistered<=@EndTime
	group by ai.GeoCode
	order by SUM(f.amount) desc
	
END
GO
