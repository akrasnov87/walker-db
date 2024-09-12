CREATE SEQUENCE dbo.cd_sensors_id_seq
	AS integer
	START WITH 1
	INCREMENT BY 1
	NO MAXVALUE
	NO MINVALUE
	CACHE 1;

ALTER SEQUENCE dbo.cd_sensors_id_seq OWNER TO mobwal;

ALTER SEQUENCE dbo.cd_sensors_id_seq
	OWNED BY dbo.cd_sensors.id;
