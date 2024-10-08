CREATE OR REPLACE FUNCTION dbo.sf_is_mobile_route(_f_route uuid) RETURNS boolean
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $$
/**
* @params {integer} _f_route - иден. маршрута
*
* @returns {boolean} true - маршрут доступен для мобильного устройства
*/
BEGIN
	-- маршруты возвращаютяс если:
	-- - период не истёк
	-- - есть задания на доработку
	-- - есть не выполненные задания
	IF (select count(*) 
		from dbo.cd_routes as r
		inner join dbo.cs_route_statuses as rs ON r.f_status = rs.id
		where r.id = _f_route and rs.c_const = 'ASSIGNED' and dbo.sf_finish_date(r.d_date_expired)
	   ) = 1 THEN 
		RETURN true;
	ELSE
		RETURN false;	
	END IF;
END
$$;

ALTER FUNCTION dbo.sf_is_mobile_route(_f_route uuid) OWNER TO mobwal;

COMMENT ON FUNCTION dbo.sf_is_mobile_route(_f_route uuid) IS 'Является ли маршрут доступным для мобильного устройства';
