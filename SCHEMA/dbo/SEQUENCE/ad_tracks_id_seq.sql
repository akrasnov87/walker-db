CREATE SEQUENCE dbo.ad_tracks_id_seq
	START WITH 1
	INCREMENT BY 1
	NO MAXVALUE
	NO MINVALUE
	CACHE 1;

ALTER SEQUENCE dbo.ad_tracks_id_seq OWNER TO mobwal;

ALTER SEQUENCE dbo.ad_tracks_id_seq
	OWNED BY dbo.ad_tracks.id;
