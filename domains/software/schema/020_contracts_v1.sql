-- Domain B, release 1: publish contracts `software.installations_v1` and `software.catalog_v1`.
CREATE OR REPLACE VIEW software.installations_v1
SQL SECURITY DEFINER DEFINER = CURRENT_USER
AS SELECT
    device_id,
    software_id,
    version,
    installed_at
FROM software.installations FINAL
WHERE is_deleted = 0;

CREATE OR REPLACE VIEW software.catalog_v1
SQL SECURITY DEFINER DEFINER = CURRENT_USER
AS SELECT
    software_id,
    name,
    vendor,
    severity,
    vulnerable_versions
FROM software.catalog FINAL
WHERE is_deleted = 0;
