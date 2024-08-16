CREATE OR REPLACE FUNCTION core.sf_version_to_number(_c_version text) RETURNS bigint
    LANGUAGE plpgsql STABLE
    AS $$
/**
* @returns _c_version {text} версия
*/
BEGIN
	RETURN (SELECT split_part(_c_version, '.', 2)::integer * 24 * 60) + split_part(_c_version, '.', 4)::integer;
END
$$;

ALTER FUNCTION core.sf_version_to_number(_c_version text) OWNER TO mobwal;

COMMENT ON FUNCTION core.sf_version_to_number(_c_version text) IS 'Преобразование версии в число';
