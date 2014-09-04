USE [gameid_v1]
GO

alter table accountinfo alter column NumReferrals int not null
alter table accountinfo add constraint DF_AccountInfo_NumReferrals DEFAULT 0 FOR NumReferrals
GO



