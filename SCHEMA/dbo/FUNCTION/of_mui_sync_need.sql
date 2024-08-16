CREATE OR REPLACE FUNCTION dbo.of_mui_sync_need(sender jsonb, params jsonb) RETURNS TABLE(b_sync_need boolean)
    LANGUAGE plpgsql STABLE
    AS $$
/**
	Получение уведомления о надобности выполнения синхронизации
	
	sender: jsonb - идентификатор пользователя
	params: jsonb - параметры фильтрации
	
	Параметры фильтрации:
	- c_version: text - версия мобильного приложения
	- d_last_sync_datetime: timestamp without time zone - дата и время последней успешной синхронизации
	
	Пример запроса:
	select * 
	from dbo.of_mui_sync_need((SELECT to_jsonb(t) FROM core.sf_users(11) AS t), '{ "c_version": "1.0.0.1", "d_last_sync_datetime": "2023-12-01" }')
*/
DECLARE
	last_sync_datetime			timestamp without time zone = null;
BEGIN	
	SELECT (params#>>'{d_last_sync_datetime}')::timestamp without time zone INTO last_sync_datetime;
	
	IF last_sync_datetime IS NULL THEN
		RETURN QUERY 
			SELECT false;
	ELSE
		RETURN QUERY 
			-- тут нужно определить, есть ли новые задания после даты d_last_sync_datetime
			SELECT COUNT(*) > 0
			FROM dbo.cd_points AS p
			INNER JOIN dbo.cd_routes AS r ON r.id = p.fn_route
			--INNER JOIN dbo.cd_userinroutes AS uir ON uir.f_route = r.id
			WHERE 
				p.dx_created >= last_sync_datetime AND 
				p.b_anomaly = false AND
				r.f_user = (sender#>>'{id}')::integer;
	END IF;
END
$$;

ALTER FUNCTION dbo.of_mui_sync_need(sender jsonb, params jsonb) OWNER TO mobwal;

COMMENT ON FUNCTION dbo.of_mui_sync_need(sender jsonb, params jsonb) IS 'Проверка на потребность в синхронизации: получение обновлённой информации по заданиям';
