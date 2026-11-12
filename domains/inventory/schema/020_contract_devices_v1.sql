-- Domain A, release 1: publish contract `inventory.devices_v1`.
-- This view IS the public API of the inventory domain inside ClickHouse.
-- Consumers may only read *_vN views, never inventory.devices. SQL SECURITY DEFINER lets a
-- consumer read the view without having any grant on the internal table.
CREATE OR REPLACE VIEW inventory.devices_v1
SQL SECURITY DEFINER DEFINER = CURRENT_USER
AS SELECT
    device_id,
    hostname,
    os,
    os_version,
    department,
    last_seen,
    owner_email
FROM inventory.devices FINAL
WHERE is_deleted = 0;
