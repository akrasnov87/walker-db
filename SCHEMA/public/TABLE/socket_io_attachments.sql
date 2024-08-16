CREATE TABLE public.socket_io_attachments (
	id bigint DEFAULT nextval('public.socket_io_attachments_id_seq'::regclass) NOT NULL,
	created_at timestamp with time zone DEFAULT now(),
	payload bytea
);

ALTER TABLE public.socket_io_attachments OWNER TO mobwal;

COMMENT ON TABLE public.socket_io_attachments IS 'Socket.IO';

--------------------------------------------------------------------------------

ALTER TABLE public.socket_io_attachments
	ADD CONSTRAINT socket_io_attachments_id_key UNIQUE (id);
