CREATE OR REPLACE FUNCTION dbo.of_mui_cd_points(sender jsonb, _c_version text) RETURNS TABLE(id uuid, fn_route uuid, c_address text, c_description text, n_order integer, n_longitude numeric, n_latitude numeric, jb_data text, b_anomaly boolean, b_check boolean, c_comment text, b_server boolean, b_disabled boolean, c_rfid text)
    LANGUAGE plpgsql STABLE
    AS $$
/**
* @params {jsonb} sender - информация о пользователе
* @params {text} _c_version - текущая версия приложения
*
* @example
* [{ "action": "of_mui_cd_points", "schema": "dbo", "method": "Select", "data": [{ "params": [sender, _c_version] }], "type": "rpc", "tid": 0 }]
*/
DECLARE
	_is_new_version			boolean = false; -- новая версия приложения
BEGIN
	-- 1.923.3.390
	SELECT core.sf_version_to_number(_c_version) > 1329510 INTO _is_new_version;

    RETURN QUERY 
		select p.id,
			p.fn_route,
			p.c_address,
			p.c_description,
			p.n_order,
			p.n_longitude,
			p.n_latitude,
			CASE 
				WHEN _is_new_version THEN (p.jb_data - 'questions')::text
				ELSE p.jb_data::text
			END,
			p.b_anomaly,
			p.b_check,
			p.c_comment,
			true,
			p.b_disabled,
			p.c_rfid
		from dbo.cd_points as p
		inner join dbo.cd_routes as r on r.id = p.fn_route
		inner join core.pd_users as u ON u.id = r.f_user
		inner join dbo.cs_route_statuses as rs ON r.f_status = rs.id
		where p.b_disabled = false 
		and (u.c_login = (sender#>>'{c_level}')::text
		or r.f_user = (sender#>>'{id}')::bigint) 
		and rs.c_const = 'ASSIGNED' and r.d_date_expired::date >= now()::date;
END
$$;

ALTER FUNCTION dbo.of_mui_cd_points(sender jsonb, _c_version text) OWNER TO sdss;

COMMENT ON FUNCTION dbo.of_mui_cd_points(sender jsonb, _c_version text) IS 'Список задание';
