CREATE OR REPLACE FUNCTION dbo.sf_finish_date(_d_date date) RETURNS boolean
    LANGUAGE plpgsql IMMUTABLE STRICT
    AS $$
/**
* @params {date} _d_date - дата
* @returns {boolean} false - маршрут завершен
*/
BEGIN
	RETURN (_d_date + interval '1 day') >= now();
END
$$;

ALTER FUNCTION dbo.sf_finish_date(_d_date date) OWNER TO mobwal;

COMMENT ON FUNCTION dbo.sf_finish_date(_d_date date) IS 'Проверка даты завершения маршрута, true - маршрут активный';
