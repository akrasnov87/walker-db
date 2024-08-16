CREATE OR REPLACE FUNCTION core.of_mui_cd_settings(sender jsonb, _c_version text) RETURNS TABLE(c_key text, c_value text, c_type text)
    LANGUAGE plpgsql STABLE ROWS 10
    AS $$
/**
* @params {jsonb} sender - информация о пользователе
* @params {text} _c_version - текущая версия приложения
*
* @example
* [{ "action": "of_mui_cd_settings", "schema": "core", "method": "Select", "data": [{ "params": [sender, _c_version] }], "type": "rpc", "tid": 0 }]
*/
BEGIN
    RETURN QUERY 
	select
		replace(lower(s.c_key), 'mobile.', ''),
		lower(s.c_value),
		lower(s.c_type)
	from core.sd_settings as s
	where s.b_disabled = false;
END
$$;

ALTER FUNCTION core.of_mui_cd_settings(sender jsonb, _c_version text) OWNER TO mobwal;

COMMENT ON FUNCTION core.of_mui_cd_settings(sender jsonb, _c_version text) IS 'Настройки для мобильного приложения';
