CREATE OR REPLACE FUNCTION dbo.sf_del_route(_f_route uuid) RETURNS void
    LANGUAGE plpgsql
    AS $$
/**
 * @params {jsonb} sender - объект
 * @params {uuid} _f_route - иден. маршрута
 */
BEGIN
	delete from dbo.cd_attachments
	where fn_route = _f_route;
	
	delete from dbo.cd_results
	where fn_route = _f_route;
	
	delete from dbo.cd_points
	where fn_route = _f_route;

	delete from dbo.cd_routes
	where id = _f_route;
	
	perform core.sf_write_log('Удален маршрут', _f_route::text, 0);
END
$$;

ALTER FUNCTION dbo.sf_del_route(_f_route uuid) OWNER TO sdss;

COMMENT ON FUNCTION dbo.sf_del_route(_f_route uuid) IS 'Функция по удалению маршрута';
