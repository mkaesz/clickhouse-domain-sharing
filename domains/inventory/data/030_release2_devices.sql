-- Release 2 data: written against the NEW internal column names, with the new site column.
-- Two existing devices get their site filled in (new version), three new devices arrive.
INSERT INTO inventory.devices (device_id, hostname, platform_name, platform_version, platform_build, department, site, last_seen, owner_email, version) VALUES
    ('DEV-001', 'WS-FIN-001', 'Windows 11', '23H2',  '22631.4460', 'Finance',     'Augsburg', '2026-11-11 08:00:00', 'anna@example.com', 2),
    ('DEV-004', 'WS-ENG-004', 'Ubuntu',     '24.04', '',           'Engineering', 'Berlin',   '2026-11-11 08:02:00', 'dave@example.com', 2),
    ('DEV-013', 'WS-ENG-013', 'Windows 11', '24H2',  '26100.2314', 'Engineering', 'Berlin',   '2026-11-11 08:10:00', 'mia@example.com',  1),
    ('DEV-014', 'WS-SAL-014', 'Windows 11', '24H2',  '26100.2314', 'Sales',       'Vienna',   '2026-11-11 08:12:00', 'noah@example.com', 1),
    ('DEV-015', 'WS-HR-015',  'macOS',      '15.1',  '24B83',      'HR',          'Augsburg', '2026-11-11 08:15:00', 'olga@example.com', 1);
