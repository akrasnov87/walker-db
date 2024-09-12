CREATE SEQUENCE dbo.cs_build_floors_id_seq
	AS integer
	START WITH 1
	INCREMENT BY 1
	NO MAXVALUE
	NO MINVALUE
	CACHE 1;

ALTER SEQUENCE dbo.cs_build_floors_id_seq OWNER TO mobwal;

ALTER SEQUENCE dbo.cs_build_floors_id_seq
	OWNED BY dbo.cs_build_floors.id;
