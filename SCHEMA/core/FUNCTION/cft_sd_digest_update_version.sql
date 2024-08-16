CREATE OR REPLACE FUNCTION core.cft_sd_digest_update_version() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    IF (TG_OP = 'INSERT' OR TG_OP = 'UPDATE') THEN
		NEW.n_version = core.sf_version_to_number(NEW.c_version);
    END IF;

    RETURN NEW;
END
$$;

ALTER FUNCTION core.cft_sd_digest_update_version() OWNER TO mobwal;

COMMENT ON FUNCTION core.cft_sd_digest_update_version() IS 'Триггер. Обновления версии приложения';
