CREATE OR REPLACE FUNCTION dbo.of_mui_cd_results(sender jsonb, _c_version text) RETURNS TABLE(id uuid, fn_route uuid, fn_point uuid, fn_user integer, d_date timestamp without time zone, n_longitude numeric, n_latitude numeric, jb_data text, c_notice text, n_distance numeric, c_template text, b_server boolean, b_disabled boolean)
    LANGUAGE plpgsql STABLE
    AS $$
/**
* @params {jsonb} sender - информация о пользователе
* @params {text} _c_version - текущая версия приложения
*
* @example
* [{ "action": "of_mui_cd_results", "schema": "dbo", "method": "Select", "data": [{ "params": [sender, _c_version] }], "type": "rpc", "tid": 0 }]
*/
BEGIN
    RETURN QUERY 
	select
		rr.id,
		rr.fn_route,
		rr.fn_point,
		rr.fn_user,
		rr.d_date,
		rr.n_longitude,
		rr.n_latitude,
		rr.jb_data::text,
		rr.c_notice,
		rr.n_distance,
		rr.c_template,
		true,
		rr.b_disabled
	FROM dbo.cd_userinroutes AS uir
	inner join core.pd_users as u on u.id = uir.f_user
	inner join dbo.cd_routes AS r ON r.id = uir.f_route
	inner join dbo.cd_points AS p ON p.fn_route = r.id
	inner join dbo.cd_results AS rr ON rr.fn_point = p.id
	where (u.c_login = (sender#>>'{c_level}')::text or uir.f_user = (sender#>>'{id}')::integer) AND dbo.sf_is_mobile_route(r.id);
END
$$;

ALTER FUNCTION dbo.of_mui_cd_results(sender jsonb, _c_version text) OWNER TO mobwal;

COMMENT ON FUNCTION dbo.of_mui_cd_results(sender jsonb, _c_version text) IS 'Список результатов';
