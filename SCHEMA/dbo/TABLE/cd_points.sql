CREATE TABLE dbo.cd_points (
	id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
	fn_route uuid NOT NULL,
	c_address text NOT NULL,
	c_description text,
	c_imp_id text,
	n_order integer DEFAULT 0 NOT NULL,
	n_longitude numeric(20,15),
	n_latitude numeric(20,15),
	jb_data jsonb,
	b_anomaly boolean DEFAULT false NOT NULL,
	b_check boolean DEFAULT true NOT NULL,
	c_comment text,
	dx_created timestamp without time zone DEFAULT now() NOT NULL,
	b_disabled boolean DEFAULT false NOT NULL,
	f_collection uuid,
	c_rfid text,
	jb_ext jsonb
);

ALTER TABLE dbo.cd_points OWNER TO mobwal;

COMMENT ON TABLE dbo.cd_points IS 'Точки';

COMMENT ON COLUMN dbo.cd_points.id IS 'Идентификатор';

COMMENT ON COLUMN dbo.cd_points.fn_route IS 'Маршрут';

COMMENT ON COLUMN dbo.cd_points.c_address IS 'Адрес';

COMMENT ON COLUMN dbo.cd_points.c_description IS 'Описание';

COMMENT ON COLUMN dbo.cd_points.c_imp_id IS 'Идентификатор импорта';

COMMENT ON COLUMN dbo.cd_points.n_order IS 'Сортировка';

COMMENT ON COLUMN dbo.cd_points.n_longitude IS 'Долгота';

COMMENT ON COLUMN dbo.cd_points.n_latitude IS 'Широта';

COMMENT ON COLUMN dbo.cd_points.jb_data IS 'Дополнительные данные';

COMMENT ON COLUMN dbo.cd_points.dx_created IS 'Дата создания в БД';

COMMENT ON COLUMN dbo.cd_points.f_collection IS 'Ссылка на точки';

COMMENT ON COLUMN dbo.cd_points.c_rfid IS 'RFID';

--------------------------------------------------------------------------------

CREATE INDEX cd_points_fn_route_b_ckeck_idx ON dbo.cd_points USING btree (fn_route, b_check);

--------------------------------------------------------------------------------

ALTER TABLE dbo.cd_points
	ADD CONSTRAINT cd_points_f_route_fkey FOREIGN KEY (fn_route) REFERENCES dbo.cd_routes(id);

--------------------------------------------------------------------------------

ALTER TABLE dbo.cd_points
	ADD CONSTRAINT cd_points_pkey PRIMARY KEY (id);
