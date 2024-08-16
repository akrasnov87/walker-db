CREATE SEQUENCE dbo.sd_questions_id_seq
	AS integer
	START WITH 1
	INCREMENT BY 1
	NO MAXVALUE
	NO MINVALUE
	CACHE 1;

ALTER SEQUENCE dbo.sd_questions_id_seq OWNER TO sdss;

ALTER SEQUENCE dbo.sd_questions_id_seq
	OWNED BY dbo.sd_questions.id;
