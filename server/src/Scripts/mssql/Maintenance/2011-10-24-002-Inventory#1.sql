USE [gameid_v1]
GO

alter table items_generic add IsStackable int not null default (0)
alter table inventory add Quantity int not null default (1)
GO
