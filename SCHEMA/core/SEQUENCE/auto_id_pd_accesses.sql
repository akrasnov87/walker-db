CREATE SEQUENCE core.auto_id_pd_accesses
	START WITH 1
	INCREMENT BY 1
	NO MAXVALUE
	NO MINVALUE
	CACHE 1;

ALTER SEQUENCE core.auto_id_pd_accesses OWNER TO mobwal;
