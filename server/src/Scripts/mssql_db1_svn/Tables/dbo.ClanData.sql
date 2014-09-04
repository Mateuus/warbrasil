CREATE TABLE [dbo].[ClanData]
(
[ClanID] [int] NOT NULL IDENTITY(1472, 1),
[ClanName] [nvarchar] (64) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ClanNameColor] [int] NOT NULL,
[ClanTag] [nvarchar] (4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[ClanTagColor] [int] NOT NULL,
[ClanEmblemID] [int] NOT NULL,
[ClanEmblemColor] [int] NOT NULL,
[ClanXP] [int] NOT NULL,
[ClanLevel] [int] NOT NULL,
[ClanGP] [int] NOT NULL,
[OwnerID] [int] NOT NULL,
[MaxClanMembers] [int] NOT NULL,
[NumClanMembers] [int] NOT NULL,
[ClanLore] [nvarchar] (512) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Announcement] [nvarchar] (512) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ClanCreateDate] [datetime] NULL
) ON [PRIMARY]
GO
GRANT SELECT ON  [dbo].[ClanData] TO [support1]
GRANT INSERT ON  [dbo].[ClanData] TO [support1]
GRANT DELETE ON  [dbo].[ClanData] TO [support1]
GRANT UPDATE ON  [dbo].[ClanData] TO [support1]
GO


ALTER TABLE [dbo].[ClanData] ADD CONSTRAINT [PK_ClanData] PRIMARY KEY CLUSTERED  ([ClanID]) ON [PRIMARY]
GO
