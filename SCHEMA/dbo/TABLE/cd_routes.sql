CREATE TABLE dbo.cd_routes (
	id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
	c_name text NOT NULL,
	c_description text,
	dx_created timestamp without time zone DEFAULT now(),
	c_templates text,
	f_user bigint,
	f_status integer,
	d_date_expired date DEFAULT ((now())::date + '30 days'::interval) NOT NULL,
	c_group text,
	jb_data jsonb
);

ALTER TABLE dbo.cd_routes OWNER TO mobwal;

COMMENT ON TABLE dbo.cd_routes IS 'Маршруты';

COMMENT ON COLUMN dbo.cd_routes.id IS 'Идентификатор';

COMMENT ON COLUMN dbo.cd_routes.c_name IS 'Наименование или номер маршрута';

COMMENT ON COLUMN dbo.cd_routes.c_description IS 'Примечание';

COMMENT ON COLUMN dbo.cd_routes.dx_created IS 'Дата создания в БД';

COMMENT ON COLUMN dbo.cd_routes.c_group IS 'Группа';

--------------------------------------------------------------------------------

CREATE INDEX cd_routes_c_group_idx ON dbo.cd_routes USING btree (c_group);

--------------------------------------------------------------------------------

CREATE INDEX cd_routes_f_status_idx ON dbo.cd_routes USING btree (f_status);

--------------------------------------------------------------------------------

CREATE INDEX cd_routes_f_user_idx ON dbo.cd_routes USING btree (f_user);

--------------------------------------------------------------------------------

ALTER TABLE dbo.cd_routes
	ADD CONSTRAINT cd_routes_pkey PRIMARY KEY (id);
