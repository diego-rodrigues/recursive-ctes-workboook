CREATE TABLE edge (
    source_node INTEGER,
    target_node INTEGER,
    weight INTEGER
);

INSERT INTO edge (source_node, target_node, weight)
VALUES
    (1, 2, 1),
    (1, 3, 2),
    (2, 4, 1),
    (3, 4, 3),
    (4, 5, 1),
    (3, 5, 4),
	(1, 5, 4),
	(6, 1, 2);

WITH RECURSIVE shortest_path AS (
    -- Anchor query: Initialize the shortest path from the source node to immediate neighbors
    SELECT source_node, target_node, weight, ARRAY[source_node,target_node] AS path, weight AS total_weight
    FROM edge
    WHERE source_node = 1

    UNION ALL

    -- Recursive query: Expand the shortest path to reach neighboring nodes
    SELECT e.source_node,
           e.target_node,
           e.weight,
           sp.path || e.target_node AS path,
           sp.total_weight + e.weight AS total_weight
    FROM shortest_path sp
    JOIN edge e ON sp.target_node = e.source_node
    WHERE NOT e.target_node = ANY(sp.path) -- to void cycles
)

-- Final query: Select the shortest path to each node from the source node
SELECT DISTINCT ON (target_node)
       target_node,
       path,
       total_weight
FROM shortest_path
ORDER BY target_node, total_weight;


DROP TABLE edge;
