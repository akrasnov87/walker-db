CREATE OR REPLACE FUNCTION core.pf_accesses(n_user_id integer) RETURNS TABLE(table_name text, record_criteria text, rpc_function text, column_name text, is_editable boolean, is_deletable boolean, is_creatable boolean, is_fullcontrol boolean, access smallint)
    LANGUAGE plpgsql
    AS $$
/**
* @params {integer} n_user_id - иден. пользователя
*/
BEGIN
	RETURN QUERY 
		SELECT * FROM (SELECT 
	        a.c_name,
	        a.c_criteria,
	        a.c_function,
	        a.c_columns,
	        a.b_editable, 
	        a.b_deletable, 
	        a.b_creatable, 
	        a.b_full_control, 
	        core.sf_accesses(r.c_name, u.id, u.c_claims, a.f_user) AS access 
	    FROM core.pd_accesses AS a
	    LEFT JOIN core.sf_users(n_user_id) AS u ON n_user_id = u.id
	    LEFT JOIN core.pd_roles AS r ON a.f_role = r.id) AS t 
		WHERE t.access > 0;
END;
$$;

ALTER FUNCTION core.pf_accesses(n_user_id integer) OWNER TO sdss;

COMMENT ON FUNCTION core.pf_accesses(n_user_id integer) IS 'Системная функция. Получение прав доступа для пользователя. Используется "vaccine-node"JS';
