CREATE OR REPLACE FUNCTION dbo.of_mui_cd_results(sender jsonb, _c_version text) RETURNS TABLE(id uuid, fn_route uuid, fn_point uuid, fn_user bigint, d_date timestamp without time zone, n_longitude numeric, n_latitude numeric, jb_data text, c_notice text, n_distance numeric, fn_template uuid, b_server boolean, b_disabled boolean)
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
		rr.fn_template,
		true,
		rr.b_disabled
	from dbo.cd_results as rr
    inner join dbo.cd_routes as r on r.id = rr.fn_route
	inner join core.pd_users as u ON u.id = r.f_user
	inner join dbo.cs_route_statuses as rs ON r.f_status = rs.id
	where (r.f_user = (sender#>>'{id}')::bigint or
	u.c_login = (sender#>>'{c_level}')::text)
	and rs.c_const = 'ASSIGNED' and r.d_date_expired::date >= now()::date;
END
$$;

ALTER FUNCTION dbo.of_mui_cd_results(sender jsonb, _c_version text) OWNER TO mobwal;

COMMENT ON FUNCTION dbo.of_mui_cd_results(sender jsonb, _c_version text) IS 'Список результатов';
