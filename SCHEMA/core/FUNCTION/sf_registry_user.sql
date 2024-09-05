CREATE OR REPLACE FUNCTION core.sf_registry_user(jb_user jsonb, version_code text) RETURNS integer
    LANGUAGE plpgsql
    AS $$
/**
	jb_user: jsonb  - данные о пользователе
 	version_code: string - версия

	Результат:
	- идентификатор пользователя
 */
DECLARE
	userId integer;
	walkerId smallint;
	_d_expired_date date;
BEGIN
	SELECT r.id INTO walkerId
	FROM core.pd_roles AS r 
	WHERE r.c_name = 'walker' AND (jb_user#>>'{"c_claims"}')::text ILIKE '%' || r._id || '%';

	INSERT INTO core.pd_users (c_login, c_email, b_disabled, d_last_auth_date, c_version, budibase_user_id, s_notice)
	VALUES ((jb_user#>>'{"c_login"}')::text, 
			(jb_user#>>'{"c_email"}')::text, 
			(jb_user#>>'{"b_disabled"}')::boolean, 
			now(), 
			version_code, 
			(jb_user#>>'{"_id"}')::text,
			'Автоматически созданный профиль пользователя мобильного устройства'
	) 
	ON CONFLICT (c_login) 
		DO UPDATE SET d_last_auth_date = now(),
		c_version = coalesce(EXCLUDED.c_version, core.pd_users.c_version),
		_id = EXCLUDED._id
		RETURNING id INTO userId;

	-- только для walker
	IF walkerId IS NOT NULL THEN
		INSERT INTO core.pd_userinroles(f_role, f_user)
		VALUES(walkerId, userId) ON CONFLICT (f_role, f_user) DO NOTHING;
	ELSE
		DELETE FROM core.pd_userinroles AS uir WHERE uir.f_user = userId;
	END IF;

	-- проверяем блокировку
	SELECT u.d_expired_date INTO _d_expired_date 
	FROM core.pd_users AS u 
	WHERE u.id = userId;
	
	IF _d_expired_date IS NOT NULL AND NOW() > _d_expired_date THEN
		UPDATE core.pd_users AS u
		SET b_disabled = true
		WHERE u.id = userId;
		
		RETURN null;
	END IF;
		
	RETURN userId;
END
$$;

ALTER FUNCTION core.sf_registry_user(jb_user jsonb, version_code text) OWNER TO mobwal;

COMMENT ON FUNCTION core.sf_registry_user(jb_user jsonb, version_code text) IS 'Регистрация пользователя';
