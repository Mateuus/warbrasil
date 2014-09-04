USE [gameid_v1]
GO

alter table Items_Weapons add ShotsFired bigint not null default (0)
alter table Items_Weapons add ShotsHits bigint not null default (0)
alter table Items_Weapons add KillsCQ int not null default (0)
alter table Items_Weapons add KillsDM int not null default (0)
alter table Items_Weapons add KillsSB int not null default (0)
GO
