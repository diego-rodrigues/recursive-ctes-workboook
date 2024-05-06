-- ==================== FINDING ORIGINAL RECORDS ========================== --
-- create Hands-on tables
CREATE TABLE record (
    record_id INT,
    previous_record_id INT,
    chain_description VARCHAR
);

-- populate record table
INSERT INTO record VALUES
    (0, null, 'chain of 1')
    
    ,(1, null, 'chain of 3')
    ,(2, 1, 'chain of 3')
    ,(3, 2, 'chain of 3')

    ,(4, 5, 'loop chain of two elements')
    ,(5, 4, 'loop chain of two elements')

    ,(6, null, 'merging chains')
    ,(7, 6, 'merging chains-left side')
    ,(8, 6, 'merging chains-right side')
    ,(9, 8, 'merging chains-right side')

    ,(10, 12, 'loop chain of three elements')
    ,(11, 10, 'loop chain of three elements')
    ,(12, 11, 'loop chain of three elements')
;

WITH RECURSIVE chain_origin(record_id, current_origin_record, previous_record_id_step, chain_sequence) AS (
    -- anchor query
    SELECT 
        r.record_id as record_id,
        r.record_id as current_origin_record,
        r.previous_record_id as previous_record_id_step,
		ARRAY[r.record_id] as chain_sequence
    FROM record r
    
    UNION ALL

    -- recursive step
    SELECT
        rc.record_id,
        rc.previous_record_id_step,
        r.previous_record_id,
		rc.previous_record_id_step || rc.chain_sequence
    FROM chain_origin rc
    JOIN record r
        ON rc.previous_record_id_step = r.record_id
		AND NOT rc.previous_record_id_step = ANY(rc.chain_sequence)
)
-- records in a chain
SELECT record_id as record_id,
	current_origin_record as chain_origin_id,
	chain_sequence as chain_sequence
FROM chain_origin
WHERE previous_record_id_step IS NULL
	
UNION ALL

-- records in a loop, no valid chain
SELECT DISTINCT record_id as record_id,
	record_id as chain_origin_id,
	ARRAY[record_id] as chain_sequence
FROM chain_origin a
WHERE NOT EXISTS (
	SELECT 1
	FROM chain_origin b
	WHERE b.previous_record_id_step IS NULL
		AND a.record_id = b.record_id
)

ORDER BY record_id
;


DROP TABLE record;
