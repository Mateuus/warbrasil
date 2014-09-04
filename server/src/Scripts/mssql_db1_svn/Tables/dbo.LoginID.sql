CREATE TABLE [dbo].[LoginID]
(
[CustomerID] [int] NOT NULL IDENTITY(1288037000, 1),
[AccountName] [varchar] (32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Password] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[AccountStatus] [int] NOT NULL CONSTRAINT [DF__LoginID__Account__02084FDA] DEFAULT ((100)),
[GamePoints] [int] NOT NULL CONSTRAINT [DF__LoginID__GamePoi__02FC7413] DEFAULT ((0)),
[HonorPoints] [int] NOT NULL CONSTRAINT [DF_LoginID_HonorPoints] DEFAULT ((0)),
[SkillPoints] [int] NOT NULL CONSTRAINT [DF_LoginID_SkillPoints] DEFAULT ((0)),
[Gamertag] [nvarchar] (32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_LoginID_Gamertag] DEFAULT (N'gamertag'),
[dateregistered] [datetime] NOT NULL CONSTRAINT [DF_LoginID_dateregistered] DEFAULT ('1/1/1973 12:00'),
[lastlogindate] [datetime] NOT NULL CONSTRAINT [DF_LoginID_lastlogindate] DEFAULT ('1/1/1973 12:00'),
[lastloginIP] [varchar] (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_LoginID_lastloginIP] DEFAULT ('0.0.0.0'),
[lastgamedate] [datetime] NOT NULL CONSTRAINT [DF_LoginID_lastgamedate] DEFAULT ('1/1/1973 12:00'),
[ReferralID] [int] NOT NULL CONSTRAINT [DF_LoginID_ReferralID] DEFAULT ((23742)),
[lastjoineddate] [datetime] NOT NULL CONSTRAINT [DF_LoginID_lastjoineddate] DEFAULT (((1970)-(1))-(1)),
[MD5Password] [varchar] (32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_LoginID_MD5Password] DEFAULT (''),
[ClanID] [int] NOT NULL CONSTRAINT [DF__LoginID__ClanID__7AA72534] DEFAULT ((0)),
[GameDollars] [int] NOT NULL CONSTRAINT [DF_LoginID_GameDollars] DEFAULT ((0)),
[Faction1Score] [int] NOT NULL CONSTRAINT [DF__LoginID__Faction__5634BA94] DEFAULT ((0)),
[Faction2Score] [int] NOT NULL CONSTRAINT [DF__LoginID__Faction__5728DECD] DEFAULT ((0)),
[Faction3Score] [int] NOT NULL CONSTRAINT [DF__LoginID__Faction__581D0306] DEFAULT ((0)),
[Faction4Score] [int] NOT NULL CONSTRAINT [DF__LoginID__Faction__5911273F] DEFAULT ((0)),
[Faction5Score] [int] NOT NULL CONSTRAINT [DF__LoginID__Faction__5A054B78] DEFAULT ((0)),
[ClanRank] [int] NOT NULL CONSTRAINT [DF__LoginID__ClanRan__67E9567B] DEFAULT ((99)),
[lastRetBonusDate] [datetime] NULL,
[IsFPSEnabled] [int] NOT NULL CONSTRAINT [DF__LoginID__IsFPSEn__16A44564] DEFAULT ((0)),
[reg_sid] [varchar] (128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ClanContributedXP] [int] NOT NULL CONSTRAINT [DF__LoginID__ClanCon__741A2336] DEFAULT ((0)),
[ClanContributedGP] [int] NOT NULL CONSTRAINT [DF__LoginID__ClanCon__750E476F] DEFAULT ((0)),
[IsDeveloper] [int] NOT NULL CONSTRAINT [DF__LoginID__IsDevel__08211BE3] DEFAULT ((0))
) ON [PRIMARY]
GO
GRANT SELECT ON  [dbo].[LoginID] TO [support1]
GRANT INSERT ON  [dbo].[LoginID] TO [support1]
GRANT DELETE ON  [dbo].[LoginID] TO [support1]
GRANT UPDATE ON  [dbo].[LoginID] TO [support1]
GO

ALTER TABLE [dbo].[LoginID] ADD 
CONSTRAINT [PK_LoginID_CustomerID] PRIMARY KEY CLUSTERED  ([CustomerID]) ON [PRIMARY]
CREATE NONCLUSTERED INDEX [IX_LoginID_AccountName] ON [dbo].[LoginID] ([AccountName]) ON [PRIMARY]

GO

CREATE NONCLUSTERED INDEX [IX_LoginID_ClanID] ON [dbo].[LoginID] ([ClanID]) ON [PRIMARY]
GO
