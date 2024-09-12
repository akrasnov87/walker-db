CREATE TABLE dbo.ad_tracks (
	id bigint DEFAULT nextval('dbo.ad_tracks_id_seq'::regclass) NOT NULL,
	fn_user integer NOT NULL,
	x numeric,
	y numeric,
	d_date date DEFAULT (now())::date NOT NULL,
	d_time time without time zone DEFAULT (now())::time without time zone NOT NULL
);

ALTER TABLE dbo.ad_tracks OWNER TO mobwal;

--------------------------------------------------------------------------------

ALTER TABLE dbo.ad_tracks
	ADD CONSTRAINT ad_tracks_pkey PRIMARY KEY (id);
