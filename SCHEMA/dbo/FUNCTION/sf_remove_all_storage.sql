CREATE OR REPLACE FUNCTION dbo.sf_remove_all_storage(_f_user bigint) RETURNS void
    LANGUAGE plpgsql
    AS $$
/**
 * @params {bigint} _f_user - идентификатор пользователя
 */
BEGIN
	delete from dbo.cd_attachments where fn_user = _f_user;
END;
$$;

ALTER FUNCTION dbo.sf_remove_all_storage(_f_user bigint) OWNER TO sdss;

COMMENT ON FUNCTION dbo.sf_remove_all_storage(_f_user bigint) IS 'Процедура удаления хранилища';
