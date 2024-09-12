CREATE TABLE dbo.cs_ble_types (
	id integer DEFAULT nextval('dbo.cs_ble_types_id_seq'::regclass) NOT NULL,
	c_name text NOT NULL,
	c_const text NOT NULL,
	n_order integer DEFAULT 0 NOT NULL,
	b_disabled boolean DEFAULT false NOT NULL
);

ALTER TABLE dbo.cs_ble_types OWNER TO mobwal;

COMMENT ON TABLE dbo.cs_ble_types IS 'Типы BLE-меток';

COMMENT ON COLUMN dbo.cs_ble_types.c_name IS 'Наименование';

COMMENT ON COLUMN dbo.cs_ble_types.c_const IS 'Контстанта';

COMMENT ON COLUMN dbo.cs_ble_types.n_order IS 'Порядок сортировки';

COMMENT ON COLUMN dbo.cs_ble_types.b_disabled IS 'Отключено';

--------------------------------------------------------------------------------

ALTER TABLE dbo.cs_ble_types
	ADD CONSTRAINT cs_ble_types_pkey PRIMARY KEY (id);
