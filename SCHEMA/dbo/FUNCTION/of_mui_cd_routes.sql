CREATE OR REPLACE FUNCTION dbo.of_mui_cd_routes(sender jsonb, _c_version text) RETURNS TABLE(id uuid, c_name text, c_description text, c_templates text, d_date timestamp without time zone, d_date_expired date, jb_data text)
    LANGUAGE plpgsql STABLE ROWS 10000
    AS $$
/**
* @params {jsonb} sender - информация о пользователе
* @params {text} _c_version - текущая версия приложения
*
* @example
* [{ "action": "of_mui_cd_routes", "schema": "dbo", "method": "Select", "data": [{ "params": [sender, _c_version] }], "type": "rpc", "tid": 0 }]
*/
DECLARE
	_c_min_version 		text;
BEGIN
	IF dbo.sf_is_mobile_version_valid(_c_version) THEN
	    RETURN QUERY 
		select 
			r.id, 
			r.c_name, 
			r.c_description, 
			r.c_templates,
			r.dx_created,
			r.d_date_expired,
			r.jb_data::text
		from dbo.cd_userinroutes as uir
		inner join core.pd_users as u on u.id = uir.f_user
		inner join dbo.cd_routes as r on r.id = uir.f_route
		where (uir.f_user = (sender#>>'{id}')::integer or u.c_login = (sender#>>'{c_level}')::text) and dbo.sf_is_mobile_route(r.id);
	ELSE
		SELECT c_value INTO _c_min_version FROM core.sd_settings AS s WHERE lower(s.c_key) = 'system.db_min_version_mobile';
		
		RETURN QUERY 
			SELECT 	'00000000-0000-0000-0000-000000000000'::uuid, 
					'Минимальная версия должна быть ' || coalesce(_c_min_version, '0.0.0.0'), 
					'',
					'',
					now()::timestamp without time zone, 
					now()::date, 
					'{}';
	END IF;
	
END
$$;

ALTER FUNCTION dbo.of_mui_cd_routes(sender jsonb, _c_version text) OWNER TO mobwal;

COMMENT ON FUNCTION dbo.of_mui_cd_routes(sender jsonb, _c_version text) IS 'Получение списка маршрутов';
