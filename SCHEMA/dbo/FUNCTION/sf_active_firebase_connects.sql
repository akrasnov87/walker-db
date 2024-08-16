CREATE OR REPLACE FUNCTION dbo.sf_active_firebase_connects(user_id integer) RETURNS TABLE(f_session uuid, c_firebase_token text, f_user integer, d_date date, d_time time without time zone)
    LANGUAGE plpgsql ROWS 100
    AS $$
/**
 * Получение списка активных TCP - соединения за последние 7 дней
 *
 * Параметры:
 *  - user_id: integer - идентификатор пользователя
 *
 * Результат:
 *  - f_session: uuid - идент. сессии на мобильном устройстве
 *  - c_firebase_token: text - токен устройства
 *  - f_user: integer - идент. пользователя в СКР
 *  - d_date: date - дата
 *  - d_time: time without time zone - время
 */
BEGIN
	RETURN QUERY
		SELECT  atc.f_session,
				atc.c_firebase_token, 
				atc.f_user,
				atc.d_date,
				atc.d_time
		FROM dbo.ad_firebase_connects AS atc
		WHERE atc.f_user = user_id
		ORDER BY atc.d_date DESC, atc.d_time DESC
		LIMIT 1;
END
$$;

ALTER FUNCTION dbo.sf_active_firebase_connects(user_id integer) OWNER TO mobwal;

COMMENT ON FUNCTION dbo.sf_active_firebase_connects(user_id integer) IS 'Получение списка активных токенов';
