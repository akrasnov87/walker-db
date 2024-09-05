CREATE OR REPLACE FUNCTION dbo.sf_create_update_route(_c_current_user_id text, _id uuid, _c_number text, _c_walkers text, _c_templates text, _f_status integer, _d_expired_date timestamp without time zone, _jb_data jsonb, _c_description text, _c_group text, _jb_collections jsonb) RETURNS TABLE(id uuid)
    LANGUAGE plpgsql ROWS 1
    AS $$
/*
	currentUserId: text - идентификатор авторизованного пользователя
	c_number: text -
	c_walkers: text - обходчики
	c_templates: text
	f_status: integer
	d_expired_date: timestamp without time zone - дата завершения маршрута
	jb_data: jsonb - вспомогательные данные
	c_description: text - описание
	c_group: text - группа
	jb_collections: jsonb - 
*/
DECLARE
	_route_id			uuid;
BEGIN
	IF _id IS NULL THEN
		SELECT public.uuid_generate_v4() INTO _route_id;

		INSERT INTO dbo.cd_routes(id, c_name, c_description, dx_created, c_templates, f_status, d_date_expired, c_group, jb_data)
		VALUES(_route_id, _c_number, _c_description, now(), _c_templates, _f_status, _d_expired_date, _c_group, _jb_data);
	ELSE
		SELECT _id INTO _route_id;

		UPDATE dbo.cd_routes AS r
		SET c_name = _c_number,
		c_description = _c_description,
		c_templates = _c_templates,
		f_status = _f_status,
		d_date_expired = _d_expired_date,
		c_group = _c_group,
		jb_data = _jb_data
		WHERE r.id = _route_id;
	END IF;
	
	PERFORM core.sf_write_log(_jb_collections::text, null, 0);

	DELETE FROM dbo.cd_userinroutes AS uir WHERE uir.f_route = _route_id;
	
	INSERT INTO dbo.cd_userinroutes(f_route, f_user)
	SELECT _route_id, u.id
	FROM core.pd_users AS u
	WHERE u.id IN (select unnest(string_to_array(_c_walkers, ','))::integer);

	IF _id IS NULL THEN
		INSERT INTO dbo.cd_points(fn_route, c_address, c_description, n_order, n_longitude, n_latitude, jb_data, f_collection, c_rfid, n_height)
		SELECT _route_id, c.c_address, c.c_description, c.n_order, c.n_longitude, c.n_latitude, null, c.id, c.c_rfid, c.n_height
		FROM dbo.cd_collections AS c 
		WHERE c.id IN (
			SELECT (t.value#>>'{id}')::uuid 
			FROM jsonb_array_elements(_jb_collections) AS t
		);
	ELSE
		INSERT INTO dbo.cd_points(fn_route, c_address, c_description, n_order, n_longitude, n_latitude, jb_data, f_collection, c_rfid, n_height)
		SELECT _route_id, c.c_address, c.c_description, c.n_order, c.n_longitude, c.n_latitude, null, c.id, c.c_rfid, c.n_height
		FROM dbo.cd_collections AS c 
		WHERE c.id IN (
			SELECT 	t.collection_id
			FROM dbo.cd_points AS p
			LEFT JOIN 	(
							SELECT (t.value#>>'{id}')::uuid AS collection_id
							FROM jsonb_array_elements(_jb_collections) AS t
						) AS t ON t.collection_id = p.f_collection
			WHERE p.fn_route = _route_id AND p.id IS NULL
		);
	END IF;
	
    RETURN QUERY 
		SELECT _route_id;
END
$$;

ALTER FUNCTION dbo.sf_create_update_route(_c_current_user_id text, _id uuid, _c_number text, _c_walkers text, _c_templates text, _f_status integer, _d_expired_date timestamp without time zone, _jb_data jsonb, _c_description text, _c_group text, _jb_collections jsonb) OWNER TO mobwal;

COMMENT ON FUNCTION dbo.sf_create_update_route(_c_current_user_id text, _id uuid, _c_number text, _c_walkers text, _c_templates text, _f_status integer, _d_expired_date timestamp without time zone, _jb_data jsonb, _c_description text, _c_group text, _jb_collections jsonb) IS 'Создание и редактирование маршрута';
