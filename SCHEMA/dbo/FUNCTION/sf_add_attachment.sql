CREATE OR REPLACE FUNCTION dbo.sf_add_attachment(_id uuid, _f_user bigint, _f_route uuid, _f_point uuid, _f_result uuid, _n_latitude numeric, _n_longitude numeric, _d_date timestamp without time zone, _c_name text, _c_dir text, _n_size integer, _c_extension text, _c_mime text, _n_distance numeric, _ba_data bytea, _c_type text) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
	INSERT INTO dbo.cd_attachments(id, fn_user, fn_route, fn_point, fn_result, n_longitude, n_latitude, c_name, c_dir, ba_data, n_size, c_mime, n_distance, d_date, c_type)
	VALUES (_id, _f_user, _f_route, _f_point, _f_result, _n_longitude, _n_latitude, _c_name, _c_dir, _ba_data, _n_size, _c_mime, _n_distance, _d_date, _c_type);
END
$$;

ALTER FUNCTION dbo.sf_add_attachment(_id uuid, _f_user bigint, _f_route uuid, _f_point uuid, _f_result uuid, _n_latitude numeric, _n_longitude numeric, _d_date timestamp without time zone, _c_name text, _c_dir text, _n_size integer, _c_extension text, _c_mime text, _n_distance numeric, _ba_data bytea, _c_type text) OWNER TO sdss;

COMMENT ON FUNCTION dbo.sf_add_attachment(_id uuid, _f_user bigint, _f_route uuid, _f_point uuid, _f_result uuid, _n_latitude numeric, _n_longitude numeric, _d_date timestamp without time zone, _c_name text, _c_dir text, _n_size integer, _c_extension text, _c_mime text, _n_distance numeric, _ba_data bytea, _c_type text) IS 'Добавление файла';
