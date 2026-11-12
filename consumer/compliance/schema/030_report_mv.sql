-- Pre-computed cross-domain report. The 3-way join over two domains' contracts runs
-- on a schedule; dashboards read a plain table. Refresh period is the staleness budget.
CREATE MATERIALIZED VIEW IF NOT EXISTS compliance.vulnerable_software_report
REFRESH EVERY 5 MINUTE
ENGINE = MergeTree
ORDER BY (department, software_name)
AS SELECT
    d.department          AS department,
    d.os                  AS os,
    c.name                AS software_name,
    c.severity            AS severity,
    i.version             AS version,
    count()               AS device_count
FROM software.installations_v1 AS i
INNER JOIN inventory.devices_v1 AS d ON d.device_id = i.device_id
INNER JOIN software.catalog_v1  AS c ON c.software_id = i.software_id
WHERE has(c.vulnerable_versions, i.version)
GROUP BY ALL;
