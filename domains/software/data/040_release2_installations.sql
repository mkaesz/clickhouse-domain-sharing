-- Installations for the devices that arrived with inventory release 2.
INSERT INTO software.installations (device_id, software_id, version, installed_at, row_version) VALUES
    ('DEV-013', 'SW-002', '118.0',  '2026-11-11 08:30:00', 1),   -- (!) Engineering, Berlin
    ('DEV-013', 'SW-004', '6.2.0',  '2026-11-11 08:30:00', 1),
    ('DEV-014', 'SW-001', '24.002', '2026-11-11 08:30:00', 1),
    ('DEV-015', 'SW-006', '3.0.18', '2026-11-11 08:30:00', 1);   -- (!) HR, Augsburg
