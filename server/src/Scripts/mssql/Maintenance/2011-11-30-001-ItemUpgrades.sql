USE [gameid_v1]
GO

alter table Items_Weapons add IsUpgradeable int not null default (1)
GO

alter table Inventory add UpSlot1 int not null default (0)
alter table Inventory add UpSlot2 int not null default (-1)
alter table Inventory add UpSlot3 int not null default (-1)
alter table Inventory add UpSlot4 int not null default (-1)
alter table Inventory add UpSlot5 int not null default (-1)
GO
