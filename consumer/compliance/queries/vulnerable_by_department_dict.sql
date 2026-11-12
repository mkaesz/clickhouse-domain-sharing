-- Same question, dictionary enrichment instead of a JOIN to the inventory domain.
-- dictHas() filters out devices the inventory domain has deleted.
SELECT
    dictGet('compliance.device_dict', 'department', i.device_id) AS department,
    uniqExact(i.device_id)                                       AS vulnerable_devices
FROM software.installations_v1 AS i
INNER JOIN software.catalog_v1 AS c ON c.software_id = i.software_id
WHERE has(c.vulnerable_versions, i.version)
  AND dictHas('compliance.device_dict', i.device_id)
GROUP BY department
ORDER BY department
