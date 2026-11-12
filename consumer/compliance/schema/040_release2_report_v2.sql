-- Compliance release 2 (independent of inventory release 2): the team decides it wants
-- a per-site breakdown and moves to inventory.devices_v2. Nothing in inventory changes.
CREATE MATERIALIZED VIEW IF NOT EXISTS compliance.vulnerable_software_by_site
REFRESH EVERY 5 MINUTE
ENGINE = MergeTree
ORDER BY (site, department, software_name)
AS SELECT
    d.site                AS site,
    d.department          AS department,
    c.name                AS software_name,
    c.severity            AS severity,
    count()               AS device_count
FROM software.installations_v1 AS i
INNER JOIN inventory.devices_v2 AS d ON d.device_id = i.device_id
INNER JOIN software.catalog_v1  AS c ON c.software_id = i.software_id
WHERE has(c.vulnerable_versions, i.version)
GROUP BY ALL;
