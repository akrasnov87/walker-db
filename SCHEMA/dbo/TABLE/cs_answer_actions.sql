CREATE TABLE dbo.cs_answer_actions (
	id integer DEFAULT nextval('dbo.cs_answer_actions_id_seq'::regclass) NOT NULL,
	c_const text NOT NULL,
	n_order integer DEFAULT 0,
	b_disabled boolean DEFAULT false NOT NULL,
	c_name text
);

ALTER TABLE dbo.cs_answer_actions OWNER TO mobwal;

COMMENT ON TABLE dbo.cs_answer_actions IS 'Действия для ответа';

COMMENT ON COLUMN dbo.cs_answer_actions.id IS 'Идентификатор';

COMMENT ON COLUMN dbo.cs_answer_actions.c_const IS 'Константа';

COMMENT ON COLUMN dbo.cs_answer_actions.n_order IS 'Приоритет';

COMMENT ON COLUMN dbo.cs_answer_actions.b_disabled IS 'Отключено';

--------------------------------------------------------------------------------

ALTER TABLE dbo.cs_answer_actions
	ADD CONSTRAINT cs_answer_actions_c_const_uniq UNIQUE (c_const);

--------------------------------------------------------------------------------

ALTER TABLE dbo.cs_answer_actions
	ADD CONSTRAINT cs_answer_actions_pkey PRIMARY KEY (id);
