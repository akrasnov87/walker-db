CREATE OR REPLACE FUNCTION core.sf_verify_user(jb_user jsonb, version_code text) RETURNS integer
    LANGUAGE plpgsql
    AS $$
/**
	jb_user: jsonb - данные о пользователе
	version_code: text - версия
 */
DECLARE
	_f_user_without_device	integer;
	_d_expired_date			date;
	_c_login				text;
	_is_device				boolean; -- авторизация происходит через вспомогательные устроства (код)
BEGIN
	SELECT (jb_user#>>'{isDevice}')::boolean INTO _is_device;
	SELECT (jb_user#>>'{c_login}')::text INTO _c_login;

	IF _is_device THEN
		SELECT u.c_login INTO _c_login
		FROM core.pd_devices AS d
		INNER JOIN core.pd_users AS u ON u.id = d.f_user
		WHERE d.c_serial_number = _c_login;
	END IF;

	IF _c_login IS NULL THEN
		RETURN null;
	END IF;
	
	-- проверяем блокировку
	SELECT u.d_expired_date INTO _d_expired_date 
	FROM core.pd_users AS u 
	WHERE u.c_login = _c_login;
	
	IF _d_expired_date IS NOT NULL AND NOW() > _d_expired_date THEN
		UPDATE core.pd_users AS u
		SET b_disabled = true
		WHERE u.c_login = _c_login;
		
		RETURN null;
	END IF;

	SELECT 
		u.id INTO _f_user_without_device
	FROM core.pd_users AS u 
	WHERE u.c_login = _c_login AND u.b_disabled = false;

	UPDATE core.pd_users AS u
	SET d_last_auth_date = now(),
	c_version = version_code
	WHERE u.id = _f_user_without_device;

	RETURN _f_user_without_device;
END
$$;

ALTER FUNCTION core.sf_verify_user(jb_user jsonb, version_code text) OWNER TO mobwal;

COMMENT ON FUNCTION core.sf_verify_user(jb_user jsonb, version_code text) IS 'Проверка пользователя на авторизацию';
