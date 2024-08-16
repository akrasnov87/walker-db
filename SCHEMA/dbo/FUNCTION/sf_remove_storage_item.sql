CREATE OR REPLACE FUNCTION dbo.sf_remove_storage_item(_f_user bigint, _f_storage uuid) RETURNS void
    LANGUAGE plpgsql
    AS $$
/**
 * @params {bigint} _f_user - идентификатор пользователя
 */
BEGIN
	delete from dbo.cd_attachments where fn_user= _f_user and id = _f_storage;
END;
$$;

ALTER FUNCTION dbo.sf_remove_storage_item(_f_user bigint, _f_storage uuid) OWNER TO mobwal;

COMMENT ON FUNCTION dbo.sf_remove_storage_item(_f_user bigint, _f_storage uuid) IS 'Процедура удаления элемента хранилища';
