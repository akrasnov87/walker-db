CREATE OR REPLACE FUNCTION dbo.sf_reset_route(_f_route uuid) RETURNS void
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
	where fn_route = _f_route and (b_disabled = true or b_anomaly = true);
	
	update dbo.cd_points
	set b_check = true,
	c_comment = ''
	where fn_route = _f_route;

	update dbo.cd_routes
	set f_status = 2
	where id = _f_route;
	
	perform core.sf_write_log('Маршрут сброшен', _f_route::text, 0);
END
$$;

ALTER FUNCTION dbo.sf_reset_route(_f_route uuid) OWNER TO mobwal;

COMMENT ON FUNCTION dbo.sf_reset_route(_f_route uuid) IS 'Функция по сбросу маршрута';
