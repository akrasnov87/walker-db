CREATE TABLE core.pd_users (
	id integer DEFAULT nextval('core.auto_id_pd_users'::regclass) NOT NULL,
	c_login text NOT NULL,
	c_email text,
	d_last_auth_date timestamp without time zone,
	b_disabled boolean DEFAULT false NOT NULL,
	c_version text,
	c_name text,
	s_notice text,
	n_version integer,
	d_created_date timestamp without time zone DEFAULT now(),
	c_created_user text DEFAULT 'walker'::text NOT NULL,
	d_change_date timestamp without time zone,
	c_change_user text,
	_id text,
	d_expired_date date
);

ALTER TABLE core.pd_users OWNER TO mobwal;

COMMENT ON TABLE core.pd_users IS 'Пользователи / Организации';

COMMENT ON COLUMN core.pd_users.id IS 'Идентификатор';

COMMENT ON COLUMN core.pd_users.c_login IS 'Логин';

COMMENT ON COLUMN core.pd_users.c_email IS 'Адрес электронной почты';

COMMENT ON COLUMN core.pd_users.d_last_auth_date IS 'Дата последней авторизации';

COMMENT ON COLUMN core.pd_users.b_disabled IS 'Отключен';

COMMENT ON COLUMN core.pd_users.c_name IS 'Пользовательское наименование';

COMMENT ON COLUMN core.pd_users.s_notice IS 'Системное примечание';

COMMENT ON COLUMN core.pd_users.n_version IS 'Числовой вариант версии';

COMMENT ON COLUMN core.pd_users.d_created_date IS 'Дата создания записи';

COMMENT ON COLUMN core.pd_users.c_created_user IS 'Логин пользователья создавшего запись';

COMMENT ON COLUMN core.pd_users.d_change_date IS 'Дата обновления записи';

COMMENT ON COLUMN core.pd_users.c_change_user IS 'Логин пользователья изменившего запись';

COMMENT ON COLUMN core.pd_users._id IS 'Идентификатор внешней системы';

COMMENT ON COLUMN core.pd_users.d_expired_date IS 'Срок действия УЗ';

--------------------------------------------------------------------------------

CREATE TRIGGER pd_users_log
	BEFORE INSERT OR UPDATE OR DELETE ON core.pd_users
	FOR EACH ROW
	EXECUTE PROCEDURE core.sft_log_action();

--------------------------------------------------------------------------------

CREATE TRIGGER pd_users_trigger_version
	BEFORE INSERT OR UPDATE ON core.pd_users
	FOR EACH ROW
	EXECUTE PROCEDURE core.cft_convert_version();

--------------------------------------------------------------------------------

ALTER TABLE core.pd_users
	ADD CONSTRAINT pd_users_pkey PRIMARY KEY (id);

--------------------------------------------------------------------------------

ALTER TABLE core.pd_users
	ADD CONSTRAINT pd_users_uniq_c_login UNIQUE (c_login);
