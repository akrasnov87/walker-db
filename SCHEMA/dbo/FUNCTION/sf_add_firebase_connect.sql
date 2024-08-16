CREATE OR REPLACE FUNCTION dbo.sf_add_firebase_connect(sender jsonb, params jsonb) RETURNS void
    LANGUAGE plpgsql
    AS $$
/**
	Добавление подключения к firebase

	sender: jsonb - текущий авторизованный пользователь
	params: jsonb - параметры

	Описание параметров:
	f_session: uuid - идент. сессии в мобильном приложении
	c_firebase_token: text - токен авторизации из firebase
*/
DECLARE
	user_id				integer; -- идент. пользователя	
BEGIN
	SELECT (sender#>>'{id}')::integer INTO user_id;

	INSERT INTO dbo.ad_firebase_connects(f_user, f_session, c_firebase_token)
    VALUES (user_id, (params#>>'{f_session}')::uuid, (params#>>'{c_firebase_token}')::text) 
    ON CONFLICT (f_user) DO UPDATE SET  f_session = EXCLUDED.f_session, 
                                        c_firebase_token = EXCLUDED.c_firebase_token, 
                                        d_date = EXCLUDED.d_date, 
                                        d_time = EXCLUDED.d_time;
END
$$;

ALTER FUNCTION dbo.sf_add_firebase_connect(sender jsonb, params jsonb) OWNER TO mobwal;

COMMENT ON FUNCTION dbo.sf_add_firebase_connect(sender jsonb, params jsonb) IS 'Добавление подключения к firebase';
