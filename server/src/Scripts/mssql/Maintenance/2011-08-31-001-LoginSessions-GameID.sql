use gameid_v1

alter table LoginSessions add GameSessionID bigint not null default 0
