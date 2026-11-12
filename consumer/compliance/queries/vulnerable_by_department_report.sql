-- Same question from the pre-computed refreshable MV (no join at read time).
-- The report is grouped per software, so this counts vulnerable installations, not devices.
SELECT department, sum(device_count) AS vulnerable_installations
FROM compliance.vulnerable_software_report
GROUP BY department
ORDER BY department
