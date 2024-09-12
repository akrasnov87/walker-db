CREATE TABLE dbo.cd_perimeters (
	id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
	c_name text NOT NULL,
	jb_points jsonb,
	f_floor integer NOT NULL,
	b_disabled boolean
);

ALTER TABLE dbo.cd_perimeters OWNER TO mobwal;

COMMENT ON COLUMN dbo.cd_perimeters.c_name IS 'Наименование';

COMMENT ON COLUMN dbo.cd_perimeters.jb_points IS 'Массив координат';

COMMENT ON COLUMN dbo.cd_perimeters.f_floor IS 'Этаж';

COMMENT ON COLUMN dbo.cd_perimeters.b_disabled IS 'Отключено';

--------------------------------------------------------------------------------

CREATE INDEX cd_perimeters_id_idx ON dbo.cd_perimeters USING btree (id);

--------------------------------------------------------------------------------

ALTER TABLE dbo.cd_perimeters
	ADD CONSTRAINT cd_perimeters_f_floor_fkey FOREIGN KEY (f_floor) REFERENCES dbo.cs_build_floors(id) NOT VALID;

--------------------------------------------------------------------------------

ALTER TABLE dbo.cd_perimeters
	ADD CONSTRAINT cd_perimeters_pkey PRIMARY KEY (id);
