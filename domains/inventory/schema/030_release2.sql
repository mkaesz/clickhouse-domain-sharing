-- Domain A, release 2: the inventory team changes its internal table.
--   os / os_version  ->  platform_name / platform_version   (rename)
--   + platform_build, + site                                (new columns)
--
-- Rule of the pattern: a domain may change its internals at will, but every contract
-- version that still has consumers must keep producing identical columns and types.
-- devices_v1 is therefore re-published to map the new names back. CREATE OR REPLACE swaps
-- it atomically; consumers notice nothing. devices_v2 is added for the new fields.
ALTER TABLE inventory.devices
    RENAME COLUMN os TO platform_name,
    RENAME COLUMN os_version TO platform_version,
    ADD COLUMN platform_build String DEFAULT '',
    ADD COLUMN site String DEFAULT '';

CREATE OR REPLACE VIEW inventory.devices_v1
SQL SECURITY DEFINER DEFINER = CURRENT_USER
AS SELECT
    device_id,
    hostname,
    platform_name    AS os,
    platform_version AS os_version,
    department,
    last_seen,
    owner_email
FROM inventory.devices FINAL
WHERE is_deleted = 0;

CREATE OR REPLACE VIEW inventory.devices_v2
SQL SECURITY DEFINER DEFINER = CURRENT_USER
AS SELECT
    device_id,
    hostname,
    platform_name    AS os,
    platform_version AS os_version,
    platform_build   AS os_build,
    department,
    site,
    last_seen,
    owner_email
FROM inventory.devices FINAL
WHERE is_deleted = 0;
