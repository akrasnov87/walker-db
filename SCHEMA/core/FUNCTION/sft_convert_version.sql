CREATE OR REPLACE FUNCTION core.sft_convert_version() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
	IF (TG_OP = 'INSERT' OR TG_OP = 'UPDATE') THEN
		NEW.n_version = core.sf_version_to_number(NEW.c_version);
    END IF;

    RETURN NEW;
END;
$$;

ALTER FUNCTION core.sft_convert_version() OWNER TO mobwal;

COMMENT ON FUNCTION core.sft_convert_version() IS 'Триггер. Обновления версии приложения';
