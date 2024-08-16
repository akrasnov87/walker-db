CREATE TABLE dbo.ad_firebase_connects (
	f_user integer NOT NULL,
	f_session uuid,
	c_firebase_token text,
	d_date date DEFAULT now() NOT NULL,
	d_time time without time zone DEFAULT now()
);

ALTER TABLE dbo.ad_firebase_connects OWNER TO sdss;

COMMENT ON TABLE dbo.ad_firebase_connects IS 'История соединения по TCP';

COMMENT ON COLUMN dbo.ad_firebase_connects.f_session IS 'Идентификатор сессии мобильного приложения';

COMMENT ON COLUMN dbo.ad_firebase_connects.c_firebase_token IS 'Токен';

--------------------------------------------------------------------------------

CREATE INDEX ad_firebase_connects_f_user_idx ON dbo.ad_firebase_connects USING btree (f_user);

--------------------------------------------------------------------------------

ALTER TABLE dbo.ad_firebase_connects
	ADD CONSTRAINT ad_firebase_connects_pkey PRIMARY KEY (f_user);
