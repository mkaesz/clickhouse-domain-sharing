-- Domain B: Software Management. Owned and released by the software team.
-- Internal tables. Note what is NOT here: no copy of device hostname / department / OS.
-- In a sync-based setup domain B would keep that copy to answer "which devices run
-- software X". With joins on domain A's contract view, the copy is unnecessary.
CREATE DATABASE IF NOT EXISTS software;

CREATE TABLE IF NOT EXISTS software.catalog
(
    software_id         String,
    name                String,
    vendor              String,
    severity            String,          -- severity of the known vulnerability, 'none' if clean
    vulnerable_versions Array(String),
    version             UInt64,
    is_deleted          UInt8 DEFAULT 0
)
ENGINE = ReplacingMergeTree(version, is_deleted)
ORDER BY software_id;

CREATE TABLE IF NOT EXISTS software.installations
(
    device_id    String,
    software_id  String,
    version      String,                 -- installed software version
    installed_at DateTime,
    row_version  UInt64,
    is_deleted   UInt8 DEFAULT 0
)
ENGINE = ReplacingMergeTree(row_version, is_deleted)
ORDER BY (device_id, software_id);
