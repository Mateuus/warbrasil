use gameid_v1

-- gamertag to unicode
alter table loginid drop constraint DF_LoginID_Gamertag
alter table loginid alter column gamertag nvarchar(32) not null
alter table loginid add constraint DF_LoginID_Gamertag DEFAULT (N'gamertag') FOR gamertag

-- for GNA, so accountname can store bigint
alter table loginid alter column accountname varchar(32) not null

-- column and key for GNA UserId
alter table loginid add GNAUserId bigint not null default (0)
CREATE UNIQUE NONCLUSTERED INDEX IX_LoginID_GNAUserId ON dbo.LoginID
	(GNAUserId) WITH(STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
