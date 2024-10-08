CREATE OR REPLACE FUNCTION dbo.sf_is_mobile_version_valid(_c_version text) RETURNS boolean
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $$
/**
* @params {text} _c_version - версия приложения
*
* @returns {boolean} true - маршрут доступен для мобильного устройства
*/
DECLARE
	_n_current_version integer;
	_n_version integer;
BEGIN
	select core.sf_version_to_number(_c_version) into _n_current_version;
	select core.sf_version_to_number(c_value) into _n_version from core.sd_settings as s where lower(s.c_key) = 'system.db_min_version_mobile';
	
	IF _n_current_version >= _n_version THEN
		RETURN true;
	ELSE
		RETURN false;	
	END IF;
END
$$;

ALTER FUNCTION dbo.sf_is_mobile_version_valid(_c_version text) OWNER TO mobwal;

COMMENT ON FUNCTION dbo.sf_is_mobile_version_valid(_c_version text) IS 'Минимальная версия мобильного приложения для получения данных';
