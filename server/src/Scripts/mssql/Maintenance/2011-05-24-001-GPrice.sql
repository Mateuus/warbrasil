use gameid_v1

alter table items_gear add GPrice1 int not null default (0)
alter table items_gear add GPrice7 int not null default (0)
alter table items_gear add GPrice30 int not null default (0)
alter table items_gear add GPriceP int not null default (0)

alter table items_generic add GPrice1 int not null default (0)
alter table items_generic add GPrice7 int not null default (0)
alter table items_generic add GPrice30 int not null default (0)
alter table items_generic add GPriceP int not null default (0)

alter table items_weapons add GPrice1 int not null default (0)
alter table items_weapons add GPrice7 int not null default (0)
alter table items_weapons add GPrice30 int not null default (0)
alter table items_weapons add GPriceP int not null default (0)
