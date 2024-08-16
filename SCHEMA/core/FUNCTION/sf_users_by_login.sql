CREATE OR REPLACE FUNCTION core.sf_users_by_login(_c_login text) RETURNS TABLE(id integer, c_login text, c_claims text, b_disabled boolean, d_created_date timestamp without time zone, d_change_date timestamp without time zone, d_last_auth_date timestamp without time zone, c_email text, c_claims_name text)
    LANGUAGE plpgsql
    AS $$
/**
* @params {integer} _c_login - иден. пользователя
*/

DECLARE
	_f_user			integer;
BEGIN
	SELECT u.id INTO _f_user
	FROM core.pd_users AS u
	WHERE u.c_login = _c_login;

	RETURN QUERY 
		SELECT * 
		FROM core.sf_users(_f_user, _alias);
END;
$$;

ALTER FUNCTION core.sf_users_by_login(_c_login text) OWNER TO sdss;

COMMENT ON FUNCTION core.sf_users_by_login(_c_login text) IS 'Системная функция. Получение информации о пользователе';
