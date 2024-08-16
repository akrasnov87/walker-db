CREATE TABLE dbo.ad_audits (
	id bigint DEFAULT nextval('dbo.ad_audits_id_seq'::regclass) NOT NULL,
	d_date timestamp without time zone,
	c_data text,
	c_type text,
	dx_created timestamp without time zone DEFAULT now() NOT NULL,
	c_session_id uuid NOT NULL
);

ALTER TABLE dbo.ad_audits OWNER TO mobwal;

COMMENT ON TABLE dbo.ad_audits IS 'Действия пользователя';

COMMENT ON COLUMN dbo.ad_audits.id IS 'Идентификатор';

COMMENT ON COLUMN dbo.ad_audits.d_date IS 'Дата события';

COMMENT ON COLUMN dbo.ad_audits.c_data IS 'Дополнительные параметры';

COMMENT ON COLUMN dbo.ad_audits.c_type IS 'Тип события';

COMMENT ON COLUMN dbo.ad_audits.dx_created IS 'Дата создания в БД';

--------------------------------------------------------------------------------

CREATE INDEX ad_audits_c_type_idx ON dbo.ad_audits USING btree (c_type);

--------------------------------------------------------------------------------

ALTER TABLE dbo.ad_audits
	ADD CONSTRAINT ad_audits_pkey PRIMARY KEY (id);
