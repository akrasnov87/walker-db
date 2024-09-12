CREATE TABLE dbo.cd_sensors (
	id integer DEFAULT nextval('dbo.cd_sensors_id_seq'::regclass) NOT NULL,
	f_perimeter uuid NOT NULL,
	f_ble_tag uuid NOT NULL,
	x numeric(8,3),
	y numeric(8,3),
	z numeric(8,3),
	n_measured_power_1 numeric(6,3),
	n_measured_power_2 numeric(6,3),
	n_measured_power_3 numeric(6,3),
	c_user_created text,
	d_date_created timestamp without time zone DEFAULT now() NOT NULL,
	c_user_updated text,
	d_date_updated timestamp without time zone,
	b_disabled boolean DEFAULT false NOT NULL
);

ALTER TABLE dbo.cd_sensors OWNER TO mobwal;

COMMENT ON TABLE dbo.cd_sensors IS 'Закрепление маяков за периметром';

COMMENT ON COLUMN dbo.cd_sensors.f_perimeter IS 'Периметр';

COMMENT ON COLUMN dbo.cd_sensors.f_ble_tag IS 'Маяк';

COMMENT ON COLUMN dbo.cd_sensors.n_measured_power_1 IS 'Уровень сигнала на расстоянии N1';

COMMENT ON COLUMN dbo.cd_sensors.n_measured_power_2 IS 'Уровень сигнала на расстоянии N2';

COMMENT ON COLUMN dbo.cd_sensors.n_measured_power_3 IS 'Уровень сигнала на расстоянии N3';

COMMENT ON COLUMN dbo.cd_sensors.c_user_created IS 'Кто создал';

COMMENT ON COLUMN dbo.cd_sensors.d_date_created IS 'Дата создания';

COMMENT ON COLUMN dbo.cd_sensors.c_user_updated IS 'Кто обновил';

COMMENT ON COLUMN dbo.cd_sensors.d_date_updated IS 'Дата обновления информации';

--------------------------------------------------------------------------------

ALTER TABLE dbo.cd_sensors
	ADD CONSTRAINT cd_sensors_f_ble_tag_fkey FOREIGN KEY (f_ble_tag) REFERENCES dbo.cd_ble_tags(id) NOT VALID;

--------------------------------------------------------------------------------

ALTER TABLE dbo.cd_sensors
	ADD CONSTRAINT cd_sensors_f_perimetes_fkey FOREIGN KEY (f_perimeter) REFERENCES dbo.cd_perimeters(id) NOT VALID;

--------------------------------------------------------------------------------

ALTER TABLE dbo.cd_sensors
	ADD CONSTRAINT cd_sensors_pkey PRIMARY KEY (id);
