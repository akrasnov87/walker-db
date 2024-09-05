CREATE TABLE dbo.cd_userinroutes (
	id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
	f_route uuid NOT NULL,
	f_user integer NOT NULL,
	b_main boolean DEFAULT false NOT NULL,
	dx_created timestamp with time zone DEFAULT now() NOT NULL
);

ALTER TABLE dbo.cd_userinroutes OWNER TO mobwal;

COMMENT ON TABLE dbo.cd_userinroutes IS 'Исполнители задания';

COMMENT ON COLUMN dbo.cd_userinroutes.id IS 'Идентифиактор';

COMMENT ON COLUMN dbo.cd_userinroutes.f_route IS 'Маршрут';

COMMENT ON COLUMN dbo.cd_userinroutes.f_user IS 'Пользователь';

COMMENT ON COLUMN dbo.cd_userinroutes.b_main IS 'Является главным';

COMMENT ON COLUMN dbo.cd_userinroutes.dx_created IS 'Дата создания в БД';

--------------------------------------------------------------------------------

CREATE INDEX cd_userinroutes_f_route_idx ON dbo.cd_userinroutes USING btree (f_route);

--------------------------------------------------------------------------------

CREATE INDEX cd_userinroutes_f_user_idx ON dbo.cd_userinroutes USING btree (f_user);

--------------------------------------------------------------------------------

ALTER TABLE dbo.cd_userinroutes
	ADD CONSTRAINT cd_userinroutes_f_route_fkey FOREIGN KEY (f_route) REFERENCES dbo.cd_routes(id);

--------------------------------------------------------------------------------

ALTER TABLE dbo.cd_userinroutes
	ADD CONSTRAINT cd_userinroutes_f_user_fkey FOREIGN KEY (f_user) REFERENCES core.pd_users(id);

--------------------------------------------------------------------------------

ALTER TABLE dbo.cd_userinroutes
	ADD CONSTRAINT cd_userinroutes_pkey PRIMARY KEY (id);
