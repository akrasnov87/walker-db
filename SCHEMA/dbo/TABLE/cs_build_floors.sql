CREATE TABLE dbo.cs_build_floors (
	id integer DEFAULT nextval('dbo.cs_build_floors_id_seq'::regclass) NOT NULL,
	c_name text NOT NULL,
	c_const text NOT NULL,
	n_order integer DEFAULT 0 NOT NULL,
	b_disabled boolean DEFAULT false NOT NULL
);

ALTER TABLE dbo.cs_build_floors OWNER TO mobwal;

COMMENT ON TABLE dbo.cs_build_floors IS 'Этажи';

COMMENT ON COLUMN dbo.cs_build_floors.c_name IS 'Наименование';

COMMENT ON COLUMN dbo.cs_build_floors.c_const IS 'Контстанта';

COMMENT ON COLUMN dbo.cs_build_floors.n_order IS 'Порядок сортировки';

COMMENT ON COLUMN dbo.cs_build_floors.b_disabled IS 'Отключено';

--------------------------------------------------------------------------------

ALTER TABLE dbo.cs_build_floors
	ADD CONSTRAINT cs_build_floors_pkey PRIMARY KEY (id);
