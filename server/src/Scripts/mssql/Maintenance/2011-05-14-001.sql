use gameid_v1

alter table items_gear drop constraint DF__Items_Gear__Name__07220AB2
alter table items_gear drop constraint DF__Items_Gea__Descr__08162EEB
alter table items_gear alter column name nvarchar(32) not null
alter table items_gear alter column description nvarchar(256) not null
alter table items_gear add constraint DF_Items_Gear_Name  DEFAULT (N'Name') FOR Name
alter table items_gear add constraint DF_Items_Gear_Description  DEFAULT (N'Description') FOR Description

alter table items_weapons drop constraint [DF__Items_Weap__Name__3118447E]
alter table items_weapons drop constraint [DF__Items_Wea__Descr__320C68B7]
alter table items_weapons alter column name nvarchar(32) not null
alter table items_weapons alter column description nvarchar(256) not null
alter table items_weapons add constraint DF_Items_Weapons_Name  DEFAULT (N'Name') FOR Name
alter table items_weapons add constraint DF_Items_Weapons_Description  DEFAULT (N'Description') FOR Description

alter table items_generic drop constraint [DF_Items_Generic_Name]
alter table items_generic drop constraint [DF_Items_Generic_Description]
alter table items_generic alter column name nvarchar(32) not null
alter table items_generic alter column description nvarchar(256) not null
alter table items_generic add constraint [DF_Items_Generic_Name]  DEFAULT (N'Name') FOR Name
alter table items_generic add constraint [DF_Items_Generic_Description]  DEFAULT (N'Description') FOR Description
