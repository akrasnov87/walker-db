CREATE OR REPLACE FUNCTION dbo.sf_vote_mobile_object(_question_id integer) RETURNS TABLE(result jsonb)
    LANGUAGE plpgsql ROWS 1
    AS $$
/**
 * @params {integer} _question_id - идентификатор опроса (главного вопроса)
 * 
 * Пример: select * from vote.sf_vote_mobile_object(1)
 */
BEGIN
	RETURN QUERY SELECT 	jsonb_build_object(	
				'questions', 
				(SELECT  array_to_json(array_agg(row_to_json(j)))  from (
					  SELECT 	q.id AS question_id,
							q.c_text AS question,
							(SELECT array_to_json(array_agg(row_to_json(j))) from (
									SELECT 	a.c_tag AS tag,
											a.c_text AS answer,
											a.f_next_question AS question,
											a.c_action AS action
									FROM wlk.sd_answers AS a WHERE a.f_question = q.id
									ORDER BY a.n_order
								) AS j) AS answers
					FROM wlk.sd_questions AS q
					WHERE q.c_group = _question_id::text
					ORDER BY q.n_order
				) AS j)
			) || q.jb_data
	FROM wlk.sd_questions AS q
	where q.id = _question_id;
END;
$$;

ALTER FUNCTION dbo.sf_vote_mobile_object(_question_id integer) OWNER TO mobwal;

COMMENT ON FUNCTION dbo.sf_vote_mobile_object(_question_id integer) IS 'Опрос для мобильного приложения';
