-- Software catalog with known-vulnerable versions.
INSERT INTO software.catalog (software_id, name, vendor, severity, vulnerable_versions, version) VALUES
    ('SW-001', 'Acrobat Reader', 'Adobe',     'critical', ['23.001'],           1),
    ('SW-002', 'Firefox',        'Mozilla',   'high',     ['118.0', '119.0'],   1),
    ('SW-003', '7-Zip',          '7-Zip',     'high',     ['22.01'],            1),
    ('SW-004', 'Zoom',           'Zoom',      'none',     [],                   1),
    ('SW-005', 'Java 8',         'Oracle',    'critical', ['8u381'],            1),
    ('SW-006', 'VLC',            'VideoLAN',  'medium',   ['3.0.18'],           1);
