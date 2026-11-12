-- How a domain decides when a contract version can be retired: look at who still reads it.
-- Run by the INVENTORY team against the query log before dropping devices_v1.
-- (Normal views show up in query_log.tables; query_log.views only lists materialized views.)
SELECT
    arrayJoin(arrayFilter(t -> startsWith(t, 'inventory.devices_v'), tables)) AS contract,
    user,
    count()         AS queries,
    max(event_time) AS last_used
FROM clusterAllReplicas('default', system.query_log)
WHERE type = 'QueryFinish'
  AND event_time > now() - INTERVAL 1 HOUR
  AND arrayExists(t -> startsWith(t, 'inventory.devices_v'), tables)
GROUP BY contract, user
ORDER BY contract, user
