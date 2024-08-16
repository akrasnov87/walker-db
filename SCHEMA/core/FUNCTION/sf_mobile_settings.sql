CREATE OR REPLACE FUNCTION core.sf_mobile_settings() RETURNS TABLE(c_key text, c_value text, c_summary text, c_type text)
    LANGUAGE plpgsql STABLE ROWS 100
    AS $$
BEGIN
	RETURN QUERY 	
	SELECT  s.c_key, 
			s.c_value, 
			s.c_summary, 
			s.c_type 
	FROM core.sd_settings AS s 
	WHERE s.b_disabled = false;
END;
$$;

ALTER FUNCTION core.sf_mobile_settings() OWNER TO sdss;

COMMENT ON FUNCTION core.sf_mobile_settings() IS 'получение настроек для мобильного приложения';
