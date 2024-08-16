CREATE SEQUENCE public.socket_io_attachments_id_seq
	START WITH 1
	INCREMENT BY 1
	NO MAXVALUE
	NO MINVALUE
	CACHE 1;

ALTER SEQUENCE public.socket_io_attachments_id_seq OWNER TO mobwal;

ALTER SEQUENCE public.socket_io_attachments_id_seq
	OWNED BY public.socket_io_attachments.id;
