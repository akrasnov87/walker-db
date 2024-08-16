CREATE OR REPLACE FUNCTION core.cft_pd_users_update_version() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF (TG_OP = 'INSERT' OR TG_OP = 'UPDATE') THEN
		UPDATE core.pd_users as u
		set n_version = core.sf_version_to_number(NEW.c_version),
		c_version = NEW.c_version
		where u.id = NEW.fn_user;
    END IF;

    RETURN NEW;
END
$$;

ALTER FUNCTION core.cft_pd_users_update_version() OWNER TO mobwal;

COMMENT ON FUNCTION core.cft_pd_users_update_version() IS 'Триггер. Обновление версии в пользователях';
