-- SQL version of the contract test for inventory.devices_v1 (same content as devices_v1.json).
-- Every row must say 'ok'. Run it in the Cloud SQL console or with ./q.
WITH
    contract AS
    (
        SELECT * FROM VALUES('name String, type String, pos UInt8',
            ('device_id',   'String',   1),
            ('hostname',    'String',   2),
            ('os',          'String',   3),
            ('os_version',  'String',   4),
            ('department',  'String',   5),
            ('last_seen',   'DateTime', 6),
            ('owner_email', 'String',   7))
    ),
    actual AS
    (
        SELECT name, type, position AS pos
        FROM system.columns
        WHERE database = 'inventory' AND table = 'devices_v1'
    )
SELECT
    if(c.name != '', c.name, a.name)                       AS column,
    c.type                                                 AS contract_type,
    a.type                                                 AS view_type,
    multiIf(a.name = '',       'MISSING IN VIEW',
            c.name = '',       'NOT IN CONTRACT',
            c.type != a.type,  'TYPE MISMATCH',
                               'ok')                       AS status
FROM contract AS c
FULL OUTER JOIN actual AS a ON a.name = c.name
ORDER BY if(c.pos != 0, c.pos, 100 + a.pos)
