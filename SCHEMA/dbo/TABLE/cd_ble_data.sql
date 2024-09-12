CREATE TABLE dbo.cd_ble_data (
	id bigint DEFAULT nextval('dbo.cd_ble_data_id_seq'::regclass) NOT NULL,
	c_id1 text NOT NULL,
	c_id2 text,
	c_id3 text,
	n_power numeric(6,3),
	n_rssi numeric(6,3),
	d_date date NOT NULL,
	d_time time without time zone NOT NULL
);

ALTER TABLE dbo.cd_ble_data OWNER TO mobwal;

--------------------------------------------------------------------------------

ALTER TABLE dbo.cd_ble_data
	ADD CONSTRAINT cd_ble_data_pkey PRIMARY KEY (id);
