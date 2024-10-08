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
BEGIN
    RETURN QUERY 
		select p.id,
			p.fn_route,
			p.c_address,
			p.c_description,
			p.n_order,
			p.n_longitude,
			p.n_latitude,
			(p.jb_data - 'questions')::text,
			p.b_anomaly,
			p.b_check,
			p.c_comment,
			true,
			p.b_disabled,
			p.c_rfid
		FROM dbo.cd_userinroutes AS uir
		inner join core.pd_users as u on u.id = uir.f_user
		inner join dbo.cd_routes AS r ON r.id = uir.f_route
		inner join dbo.cd_points AS p ON p.fn_route = r.id
		where p.b_disabled = false and (u.c_login = (sender#>>'{c_level}')::text or uir.f_user = (sender#>>'{id}')::integer) AND dbo.sf_is_mobile_route(r.id);
END
$$;

ALTER FUNCTION dbo.of_mui_cd_points(sender jsonb, _c_version text) OWNER TO mobwal;

COMMENT ON FUNCTION dbo.of_mui_cd_points(sender jsonb, _c_version text) IS 'Список задание';
