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
BEGIN
    RETURN QUERY 
	select 
		r.id, 
		r.c_name, 
		r.c_description, 
		r.c_templates,
		r.dx_created,
		r.d_date_expired,
		r.jb_data::text
	from dbo.cd_routes as r
	inner join core.pd_users as u ON u.id = r.f_user
	inner join dbo.cs_route_statuses as rs ON r.f_status = rs.id
	where (r.f_user = (sender#>>'{id}')::bigint)
	and rs.c_const = 'ASSIGNED' and r.d_date_expired::date >= now()::date;
END
$$;

ALTER FUNCTION dbo.of_mui_cd_routes(sender jsonb, _c_version text) OWNER TO mobwal;

COMMENT ON FUNCTION dbo.of_mui_cd_routes(sender jsonb, _c_version text) IS 'Получение списка маршрутов';
