CREATE TABLE dbo.cd_ble_tags (
	id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
	f_type integer NOT NULL,
	c_name text NOT NULL,
	c_id1 text NOT NULL,
	c_id2 text,
	c_id3 text,
	jb_data jsonb,
	b_disabled boolean DEFAULT false NOT NULL
);

ALTER TABLE dbo.cd_ble_tags OWNER TO mobwal;

COMMENT ON TABLE dbo.cd_ble_tags IS 'BLE-метки';

COMMENT ON COLUMN dbo.cd_ble_tags.f_type IS 'Тип метки';

COMMENT ON COLUMN dbo.cd_ble_tags.c_name IS 'Наименование';

COMMENT ON COLUMN dbo.cd_ble_tags.c_id1 IS 'Id1';

COMMENT ON COLUMN dbo.cd_ble_tags.c_id2 IS 'Id2';

COMMENT ON COLUMN dbo.cd_ble_tags.c_id3 IS 'Id3';

--------------------------------------------------------------------------------

CREATE INDEX cd_ble_tags_id_idx ON dbo.cd_ble_tags USING btree (id);

--------------------------------------------------------------------------------

ALTER TABLE dbo.cd_ble_tags
	ADD CONSTRAINT cd_ble_tags_f_type_fkey FOREIGN KEY (f_type) REFERENCES dbo.cs_ble_types(id);

--------------------------------------------------------------------------------

ALTER TABLE dbo.cd_ble_tags
	ADD CONSTRAINT cd_ble_tags_pkey PRIMARY KEY (id);
