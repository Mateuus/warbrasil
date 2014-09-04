use gameid_v1

alter table Items_Weapons add IsFPS int not null default (0)

alter table Items_Weapons add FPSSpec0 int not null default (0)
alter table Items_Weapons add FPSSpec1 int not null default (0)
alter table Items_Weapons add FPSSpec2 int not null default (0)
alter table Items_Weapons add FPSSpec3 int not null default (0)
alter table Items_Weapons add FPSSpec4 int not null default (0)
alter table Items_Weapons add FPSSpec5 int not null default (0)
alter table Items_Weapons add FPSSpec6 int not null default (0)
alter table Items_Weapons add FPSSpec7 int not null default (0)
alter table Items_Weapons add FPSSpec8 int not null default (0)

alter table Items_Weapons add FPSAttach0 int not null default (0)
alter table Items_Weapons add FPSAttach1 int not null default (0)
alter table Items_Weapons add FPSAttach2 int not null default (0)
alter table Items_Weapons add FPSAttach3 int not null default (0)
alter table Items_Weapons add FPSAttach4 int not null default (0)
alter table Items_Weapons add FPSAttach5 int not null default (0)
alter table Items_Weapons add FPSAttach6 int not null default (0)
alter table Items_Weapons add FPSAttach7 int not null default (0)
alter table Items_Weapons add FPSAttach8 int not null default (0)

alter table Items_Weapons add AnimPrefix varchar(32) not null default ('')

go

