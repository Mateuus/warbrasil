use gameid_v1

alter table LoginID add Faction1Score int not null default 0
alter table LoginID add Faction2Score int not null default 0
alter table LoginID add Faction3Score int not null default 0
alter table LoginID add Faction4Score int not null default 0
alter table LoginID add Faction5Score int not null default 0

alter table DBG_UserRoundResults add TeamID int not null default 2
alter table DBG_UserRoundResults add MapID int not null default 255
