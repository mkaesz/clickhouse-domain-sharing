-- Ad-hoc cross-domain query: runtime JOIN over the two domains' contract views.
SELECT
    d.department                 AS department,
    uniqExact(i.device_id)       AS vulnerable_devices
FROM software.installations_v1 AS i
INNER JOIN inventory.devices_v1 AS d ON d.device_id = i.device_id
INNER JOIN software.catalog_v1  AS c ON c.software_id = i.software_id
WHERE has(c.vulnerable_versions, i.version)
GROUP BY department
ORDER BY department
