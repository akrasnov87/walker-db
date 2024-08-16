CREATE TABLE public.socket_io_messages (
	id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
	ba_data bytea NOT NULL,
	c_data_type text NOT NULL,
	c_to text NOT NULL,
	c_from text NOT NULL,
	b_delivered boolean DEFAULT false NOT NULL,
	b_temporary boolean DEFAULT true NOT NULL,
	dx_created timestamp without time zone DEFAULT now() NOT NULL,
	dx_delivered timestamp without time zone
);

ALTER TABLE public.socket_io_messages OWNER TO sdss;

--------------------------------------------------------------------------------

ALTER TABLE public.socket_io_messages
	ADD CONSTRAINT socket_io_messages_pkey PRIMARY KEY (id);
