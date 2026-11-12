-- A normal day in the inventory domain: an update and a decommissioning.
-- Updates are inserts with a higher version; deletes are inserts with is_deleted = 1.

-- DEV-003 moves from Finance to Sales
INSERT INTO inventory.devices (device_id, hostname, os, os_version, department, last_seen, owner_email, version) VALUES
    ('DEV-003', 'WS-SAL-003', 'Windows 10', '22H2', 'Sales', '2026-11-10 09:00:00', 'carla@example.com', 2);

-- DEV-010 is decommissioned
INSERT INTO inventory.devices (device_id, hostname, os, os_version, department, last_seen, owner_email, version, is_deleted) VALUES
    ('DEV-010', 'WS-SAL-010', 'macOS', '14.7', 'Sales', '2026-11-10 09:05:00', 'jonas@example.com', 2, 1);
