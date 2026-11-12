-- Hot-path enrichment (run with `--with-acl`): device attributes as an in-memory
-- dictionary built FROM THE CONTRACT VIEW. Same decoupling as a JOIN, but dictGet()
-- instead of a hash join on every query. Refreshes itself every 1-2 minutes; the
-- inventory domain is unaware of it.
-- ClickHouse Cloud requires explicit credentials for a CLICKHOUSE dictionary source, so
-- the consumer owns a dedicated read-only user (dict_reader) that holds SELECT on the
-- contract view only. The driver substitutes the placeholders.
CREATE DICTIONARY IF NOT EXISTS compliance.device_dict
(
    device_id  String,
    hostname   String,
    os         String,
    department String
)
PRIMARY KEY device_id
SOURCE(CLICKHOUSE(USER '{{DICT_USER}}' PASSWORD '{{DICT_PASSWORD}}' DB 'inventory' TABLE 'devices_v1'))
LAYOUT(COMPLEX_KEY_HASHED())
LIFETIME(MIN 60 MAX 120);
