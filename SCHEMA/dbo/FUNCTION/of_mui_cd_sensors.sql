CREATE OR REPLACE FUNCTION dbo.of_mui_cd_sensors(sender jsonb, _c_version text) RETURNS TABLE(id uuid, id1 text, id2 text, id3 text, x numeric, y numeric)
    LANGUAGE plpgsql STABLE
    AS $$
/**
* @params {jsonb} sender - информация о пользователе
* @params {text} _c_version - текущая версия приложения
*
* @example
* [{ "action": "of_mui_cd_sensors", "schema": "dbo", "method": "Select", "data": [{ "params": [sender, _c_version] }], "type": "rpc", "tid": 0 }]
*/
BEGIN
    RETURN QUERY 
		select 	bt.id,
				bt.c_id1,
				bt.c_id2,
				bt.c_id3,
				s.x,
				s.y
		from dbo.cd_sensors as s
		inner join dbo.cd_ble_tags as bt on bt.id = s.f_ble_tag
		where bt.b_disabled = false and s.b_disabled = false;
END
$$;

ALTER FUNCTION dbo.of_mui_cd_sensors(sender jsonb, _c_version text) OWNER TO mobwal;

COMMENT ON FUNCTION dbo.of_mui_cd_sensors(sender jsonb, _c_version text) IS 'Список меток';
