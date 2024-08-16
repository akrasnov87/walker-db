CREATE OR REPLACE FUNCTION dbo.of_mui_cd_templates(sender jsonb, _c_version text) RETURNS TABLE(id uuid, c_name text, c_template text, c_layout text, c_description text, n_order integer)
    LANGUAGE plpgsql STABLE ROWS 10
    AS $$
/**
* @params {jsonb} sender - информация о пользователе
* @params {text} _c_version - текущая версия приложения
*
* @example
* [{ "action": "of_mui_cd_templates", "schema": "dbo", "method": "Select", "data": [{ "params": [sender, _c_version] }], "type": "rpc", "tid": 0 }]
*/
BEGIN
    RETURN QUERY 
	select
		t.id,
		t.c_name,
		t.c_template,
		t.c_layout,
		t.c_description,
		t.n_order
	from dbo.cd_templates as t;
END
$$;

ALTER FUNCTION dbo.of_mui_cd_templates(sender jsonb, _c_version text) OWNER TO mobwal;

COMMENT ON FUNCTION dbo.of_mui_cd_templates(sender jsonb, _c_version text) IS 'Список шаблонов';
