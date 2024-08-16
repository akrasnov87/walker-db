CREATE TABLE dbo.cd_attachments (
	id uuid DEFAULT public.uuid_generate_v4() NOT NULL,
	fn_user bigint,
	fn_route uuid,
	fn_point uuid,
	fn_result uuid,
	n_longitude numeric(20,15),
	n_latitude numeric(20,15),
	c_name text NOT NULL,
	c_dir text,
	ba_data bytea,
	n_size integer NOT NULL,
	c_mime text NOT NULL,
	n_distance numeric,
	d_date timestamp without time zone,
	dx_created timestamp without time zone DEFAULT now() NOT NULL,
	b_disabled boolean DEFAULT false NOT NULL,
	c_type text,
	c_extension text
);

ALTER TABLE dbo.cd_attachments OWNER TO mobwal;

COMMENT ON TABLE dbo.cd_attachments IS 'Файлы';

COMMENT ON COLUMN dbo.cd_attachments.id IS 'Идентификатор';

COMMENT ON COLUMN dbo.cd_attachments.fn_user IS 'Пользователь';

COMMENT ON COLUMN dbo.cd_attachments.fn_route IS 'Маршрут';

COMMENT ON COLUMN dbo.cd_attachments.fn_point IS 'Точка';

COMMENT ON COLUMN dbo.cd_attachments.fn_result IS 'Результат';

COMMENT ON COLUMN dbo.cd_attachments.n_longitude IS 'Долгота';

COMMENT ON COLUMN dbo.cd_attachments.n_latitude IS 'Широта';

COMMENT ON COLUMN dbo.cd_attachments.c_name IS 'Имя файла';

COMMENT ON COLUMN dbo.cd_attachments.c_dir IS 'Локальная директория для хранения';

COMMENT ON COLUMN dbo.cd_attachments.ba_data IS 'Данные';

COMMENT ON COLUMN dbo.cd_attachments.n_size IS 'Размер файла в байтах';

COMMENT ON COLUMN dbo.cd_attachments.c_mime IS 'Тип MIME файла';

COMMENT ON COLUMN dbo.cd_attachments.n_distance IS 'Дистанция до задания в метрах';

COMMENT ON COLUMN dbo.cd_attachments.d_date IS 'Дата';

COMMENT ON COLUMN dbo.cd_attachments.dx_created IS 'Дата создания в БД';

--------------------------------------------------------------------------------

CREATE INDEX cd_attachments_fn_user_idx ON dbo.cd_attachments USING btree (fn_user);

--------------------------------------------------------------------------------

ALTER TABLE dbo.cd_attachments
	ADD CONSTRAINT cd_attachments_pkey PRIMARY KEY (id);
