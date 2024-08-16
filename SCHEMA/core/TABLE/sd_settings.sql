CREATE TABLE core.sd_settings (
	id smallint DEFAULT nextval('core.auto_id_sd_settings'::regclass) NOT NULL,
	c_key text NOT NULL,
	c_value text,
	c_summary text,
	c_type text DEFAULT 'TEXT'::text NOT NULL,
	c_created_user text DEFAULT 'walker'::text NOT NULL,
	d_created_date timestamp without time zone DEFAULT now() NOT NULL,
	c_change_user text,
	d_change_date timestamp without time zone,
	b_disabled boolean DEFAULT false NOT NULL
);

ALTER TABLE core.sd_settings OWNER TO mobwal;

COMMENT ON TABLE core.sd_settings IS 'Основные настройки';

COMMENT ON COLUMN core.sd_settings.id IS 'Идентификатор';

COMMENT ON COLUMN core.sd_settings.c_key IS 'Ключ';

COMMENT ON COLUMN core.sd_settings.c_value IS 'Значение';

COMMENT ON COLUMN core.sd_settings.c_summary IS 'Описание настройки';

COMMENT ON COLUMN core.sd_settings.c_type IS 'Тип данных: TEXT, INT, BOOL, DATE';

COMMENT ON COLUMN core.sd_settings.c_created_user IS 'Логин пользователя создавшего запись';

COMMENT ON COLUMN core.sd_settings.d_created_date IS 'Дата создания записи';

COMMENT ON COLUMN core.sd_settings.c_change_user IS 'Логин пользователя обновившего запись';

COMMENT ON COLUMN core.sd_settings.d_change_date IS 'Дата обновления записи';

COMMENT ON COLUMN core.sd_settings.b_disabled IS 'Отключить';

--------------------------------------------------------------------------------

CREATE TRIGGER sd_settings_log
	BEFORE INSERT OR UPDATE OR DELETE ON core.sd_settings
	FOR EACH ROW
	EXECUTE PROCEDURE core.sft_log_action();

--------------------------------------------------------------------------------

ALTER TABLE core.sd_settings
	ADD CONSTRAINT cd_settings_pkey PRIMARY KEY (id);
