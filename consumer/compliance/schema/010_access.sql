-- Optional hardening (run with `--with-acl`): the consumer identity gets SELECT on
-- published contract views ONLY. The domains' internal tables are not granted, so coupling
-- to a domain's internals becomes impossible rather than merely discouraged. The contract
-- views use SQL SECURITY DEFINER, so the consumer never needs access to internal tables.
CREATE ROLE IF NOT EXISTS compliance_reader;

GRANT SELECT ON inventory.devices_v1       TO compliance_reader;
GRANT SELECT ON inventory.devices_v2       TO compliance_reader;
GRANT SELECT ON software.installations_v1  TO compliance_reader;
GRANT SELECT ON software.catalog_v1        TO compliance_reader;
GRANT SELECT ON compliance.*               TO compliance_reader;
GRANT dictGet ON compliance.*              TO compliance_reader;
