CREATE TABLE core.pd_devices (
	id bigint NOT NULL,
	f_user integer NOT NULL,
	c_serial_number text NOT NULL,
	b_disabled boolean DEFAULT false NOT NULL
);

ALTER TABLE core.pd_devices ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
	SEQUENCE NAME core.pd_devices_id_seq
	START WITH 1
	INCREMENT BY 1
	NO MAXVALUE
	NO MINVALUE
	CACHE 1
);

ALTER TABLE core.pd_devices OWNER TO mobwal;

COMMENT ON TABLE core.pd_devices IS 'Привязанные устройства';

COMMENT ON COLUMN core.pd_devices.c_serial_number IS 'Код';

--------------------------------------------------------------------------------

ALTER TABLE core.pd_devices
	ADD CONSTRAINT pd_devices_c_serial_number_uniq UNIQUE (c_serial_number);

--------------------------------------------------------------------------------

ALTER TABLE core.pd_devices
	ADD CONSTRAINT pd_devices_id_fkey FOREIGN KEY (f_user) REFERENCES core.pd_users(id);

--------------------------------------------------------------------------------

ALTER TABLE core.pd_devices
	ADD CONSTRAINT pd_devices_pkey PRIMARY KEY (id);
