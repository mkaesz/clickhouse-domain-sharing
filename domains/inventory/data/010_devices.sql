-- Release 1 data: twelve endpoints.
INSERT INTO inventory.devices (device_id, hostname, os, os_version, department, last_seen, owner_email, version) VALUES
    ('DEV-001', 'WS-FIN-001', 'Windows 11', '23H2',  'Finance',     '2026-11-09 08:12:00', 'anna@example.com',   1),
    ('DEV-002', 'WS-FIN-002', 'Windows 11', '24H2',  'Finance',     '2026-11-09 08:40:00', 'ben@example.com',    1),
    ('DEV-003', 'WS-FIN-003', 'Windows 10', '22H2',  'Finance',     '2026-11-08 17:05:00', 'carla@example.com',  1),
    ('DEV-004', 'WS-ENG-004', 'Ubuntu',     '24.04', 'Engineering', '2026-11-09 09:01:00', 'dave@example.com',   1),
    ('DEV-005', 'WS-ENG-005', 'macOS',      '15.1',  'Engineering', '2026-11-09 09:15:00', 'eva@example.com',    1),
    ('DEV-006', 'WS-ENG-006', 'Windows 11', '24H2',  'Engineering', '2026-11-09 07:55:00', 'finn@example.com',   1),
    ('DEV-007', 'WS-ENG-007', 'Ubuntu',     '22.04', 'Engineering', '2026-11-07 16:30:00', 'gina@example.com',   1),
    ('DEV-008', 'WS-SAL-008', 'Windows 11', '23H2',  'Sales',       '2026-11-09 10:20:00', 'hugo@example.com',   1),
    ('DEV-009', 'WS-SAL-009', 'Windows 10', '22H2',  'Sales',       '2026-11-09 10:45:00', 'ines@example.com',   1),
    ('DEV-010', 'WS-SAL-010', 'macOS',      '14.7',  'Sales',       '2026-11-05 12:00:00', 'jonas@example.com',  1),
    ('DEV-011', 'WS-HR-011',  'Windows 11', '24H2',  'HR',          '2026-11-09 08:05:00', 'klara@example.com',  1),
    ('DEV-012', 'WS-HR-012',  'Windows 11', '23H2',  'HR',          '2026-11-09 08:30:00', 'lukas@example.com',  1);
