CREATE TABLE dbo.ad_sync_lost_items (
	id bigint DEFAULT nextval('dbo.ad_sync_lost_items_id_seq'::regclass) NOT NULL,
	d_date timestamp without time zone,
	jb_data jsonb,
	n_count integer,
	fn_user integer NOT NULL,
	dx_created timestamp without time zone DEFAULT now() NOT NULL,
	c_session_id uuid NOT NULL
);

ALTER TABLE dbo.ad_sync_lost_items OWNER TO sdss;

COMMENT ON TABLE dbo.ad_sync_lost_items IS 'Гео-трекинг';

COMMENT ON COLUMN dbo.ad_sync_lost_items.id IS 'Идентификатор';

COMMENT ON COLUMN dbo.ad_sync_lost_items.d_date IS 'Дата на устройстве';

COMMENT ON COLUMN dbo.ad_sync_lost_items.jb_data IS 'Расширенные данные';

COMMENT ON COLUMN dbo.ad_sync_lost_items.n_count IS 'Количество записей для передачи на сервер';

COMMENT ON COLUMN dbo.ad_sync_lost_items.fn_user IS 'Идентификатор пользователя';

COMMENT ON COLUMN dbo.ad_sync_lost_items.dx_created IS 'Дата создания в БД';

COMMENT ON COLUMN dbo.ad_sync_lost_items.c_session_id IS 'Сессия устройства';

--------------------------------------------------------------------------------

CREATE INDEX ad_sync_lost_items_c_session_id_idx ON dbo.ad_sync_lost_items USING btree (c_session_id);

--------------------------------------------------------------------------------

CREATE INDEX ad_sync_lost_items_fn_user_idx ON dbo.ad_sync_lost_items USING btree (fn_user);

--------------------------------------------------------------------------------

ALTER TABLE dbo.ad_sync_lost_items
	ADD CONSTRAINT ad_sync_lost_items_pkey PRIMARY KEY (id);
