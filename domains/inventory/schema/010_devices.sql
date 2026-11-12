-- Domain A: Endpoint Inventory. Owned and released by the inventory team.
-- Internal table. Nobody outside the domain reads it; the domain may change it at will.
-- ReplacingMergeTree keeps the newest `version` per device; `is_deleted = 1` is a tombstone.
CREATE DATABASE IF NOT EXISTS inventory;

CREATE TABLE IF NOT EXISTS inventory.devices
(
    device_id   String,
    hostname    String,
    os          String,
    os_version  String,
    department  String,
    last_seen   DateTime,
    owner_email String,
    version     UInt64,
    is_deleted  UInt8 DEFAULT 0
)
ENGINE = ReplacingMergeTree(version, is_deleted)
ORDER BY device_id;
