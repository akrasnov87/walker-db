CREATE TABLE dbo.cs_route_statuses (
	id integer DEFAULT nextval('dbo.cs_route_statuses_id_seq'::regclass) NOT NULL,
	c_const text NOT NULL,
	n_order integer DEFAULT 0,
	b_disabled boolean DEFAULT false NOT NULL,
	c_name text
);

ALTER TABLE dbo.cs_route_statuses OWNER TO sdss;

COMMENT ON TABLE dbo.cs_route_statuses IS 'Тип результат';

COMMENT ON COLUMN dbo.cs_route_statuses.id IS 'Идентификатор';

COMMENT ON COLUMN dbo.cs_route_statuses.c_const IS 'Константа';

COMMENT ON COLUMN dbo.cs_route_statuses.n_order IS 'Приоритет статуса';

COMMENT ON COLUMN dbo.cs_route_statuses.b_disabled IS 'Отключено';

--------------------------------------------------------------------------------

ALTER TABLE dbo.cs_route_statuses
	ADD CONSTRAINT cs_route_statuses_c_const_uniq UNIQUE (c_const);

--------------------------------------------------------------------------------

ALTER TABLE dbo.cs_route_statuses
	ADD CONSTRAINT cs_route_statuses_pkey PRIMARY KEY (id);
