CREATE TABLE dbo.sd_answers (
	id integer DEFAULT nextval('dbo.sd_answers_id_seq'::regclass) NOT NULL,
	c_text text NOT NULL,
	f_question integer NOT NULL,
	f_next_question integer,
	c_action text,
	n_order integer DEFAULT 0 NOT NULL,
	b_disabled boolean DEFAULT false NOT NULL,
	c_created_user text DEFAULT 'sdss'::text,
	d_created_date timestamp without time zone DEFAULT now(),
	c_change_user text,
	d_change_date timestamp without time zone,
	c_tag text
);

ALTER TABLE dbo.sd_answers OWNER TO sdss;

COMMENT ON TABLE dbo.sd_answers IS 'Варианты ответов';

COMMENT ON COLUMN dbo.sd_answers.id IS 'Идентификатор';

COMMENT ON COLUMN dbo.sd_answers.c_text IS 'Текст ответа';

COMMENT ON COLUMN dbo.sd_answers.f_question IS 'ID вопроса';

COMMENT ON COLUMN dbo.sd_answers.f_next_question IS 'ID след. вопроса, если есть';

COMMENT ON COLUMN dbo.sd_answers.c_action IS 'Действия при нажатии на вариант ответа: COMMENT, CONTACT, RATING, FINISH';

COMMENT ON COLUMN dbo.sd_answers.n_order IS 'Порядок следования';

COMMENT ON COLUMN dbo.sd_answers.b_disabled IS 'Отключение варианта';

COMMENT ON COLUMN dbo.sd_answers.c_created_user IS 'Логин пользователя создавшего запись';

COMMENT ON COLUMN dbo.sd_answers.d_created_date IS 'Дата создания записи';

COMMENT ON COLUMN dbo.sd_answers.c_change_user IS 'Логин пользователя обновившего запись';

COMMENT ON COLUMN dbo.sd_answers.d_change_date IS 'Дата обновления записи';

COMMENT ON COLUMN dbo.sd_answers.c_tag IS 'Метка';

--------------------------------------------------------------------------------

CREATE TRIGGER sd_answers_log
	BEFORE INSERT OR UPDATE OR DELETE ON dbo.sd_answers
	FOR EACH ROW
	EXECUTE PROCEDURE core.sft_log_action();

--------------------------------------------------------------------------------

ALTER TABLE dbo.sd_answers
	ADD CONSTRAINT sd_answers_f_next_question_fkey FOREIGN KEY (f_next_question) REFERENCES dbo.sd_questions(id) NOT VALID;

--------------------------------------------------------------------------------

ALTER TABLE dbo.sd_answers
	ADD CONSTRAINT sd_answers_f_question_fkey FOREIGN KEY (f_question) REFERENCES dbo.sd_questions(id) NOT VALID;

--------------------------------------------------------------------------------

ALTER TABLE dbo.sd_answers
	ADD CONSTRAINT sd_answers_pkey PRIMARY KEY (id);
