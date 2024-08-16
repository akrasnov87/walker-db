CREATE TABLE dbo.sd_questions (
	id integer DEFAULT nextval('dbo.sd_questions_id_seq'::regclass) NOT NULL,
	c_text text NOT NULL,
	c_notice text,
	n_order integer DEFAULT 0 NOT NULL,
	b_disabled boolean DEFAULT false NOT NULL,
	c_created_user text DEFAULT 'mobwal'::text,
	d_created_date timestamp without time zone DEFAULT now(),
	c_change_user text,
	d_change_date timestamp without time zone,
	jb_data jsonb,
	c_group text
);

ALTER TABLE dbo.sd_questions OWNER TO mobwal;

COMMENT ON TABLE dbo.sd_questions IS 'Вопросы';

COMMENT ON COLUMN dbo.sd_questions.id IS 'Идентификатор';

COMMENT ON COLUMN dbo.sd_questions.c_text IS 'Текст ответа';

COMMENT ON COLUMN dbo.sd_questions.c_notice IS 'Примечание';

COMMENT ON COLUMN dbo.sd_questions.n_order IS 'Порядок следования';

COMMENT ON COLUMN dbo.sd_questions.b_disabled IS 'Отключение варианта';

COMMENT ON COLUMN dbo.sd_questions.c_created_user IS 'Логин пользователя создавшего запись';

COMMENT ON COLUMN dbo.sd_questions.d_created_date IS 'Дата создания записи';

COMMENT ON COLUMN dbo.sd_questions.c_change_user IS 'Логин пользователя обновившего запись';

COMMENT ON COLUMN dbo.sd_questions.d_change_date IS 'Дата обновления записи';

COMMENT ON COLUMN dbo.sd_questions.c_group IS 'Название группы объединяющая несколько вопросов (можно передать иден. главного вопроса)';

--------------------------------------------------------------------------------

CREATE TRIGGER sd_questions_log
	BEFORE INSERT OR UPDATE OR DELETE ON dbo.sd_questions
	FOR EACH ROW
	EXECUTE PROCEDURE core.sft_log_action();

----------------------------------------------------------------------------

ALTER TABLE dbo.sd_questions
	ADD CONSTRAINT sd_questions_pkey PRIMARY KEY (id);
