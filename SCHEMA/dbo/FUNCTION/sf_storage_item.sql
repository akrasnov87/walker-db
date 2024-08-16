CREATE OR REPLACE FUNCTION dbo.sf_storage_item(_f_storage uuid) RETURNS TABLE(c_dir text, c_name text, c_mime text, ba_data bytea)
    LANGUAGE plpgsql COST 1.0 ROWS 1
    AS $$
/**
 * функция по получению каталог для удаления
 * @params {uuid} _f_storage - идентификатор хранилища
 */
BEGIN
	return query 
	select a.c_dir, a.c_name, a.c_mime, a.ba_data 
	from dbo.cd_attachments as a
	where a.id = _f_storage;
END;
$$;

ALTER FUNCTION dbo.sf_storage_item(_f_storage uuid) OWNER TO mobwal;

COMMENT ON FUNCTION dbo.sf_storage_item(_f_storage uuid) IS 'Процедура элемента хранилища';
