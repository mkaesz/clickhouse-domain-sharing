# Sharing data between domains in ClickHouse without coupling releases

Two domains (endpoint inventory, software management) each own a database in ClickHouse Cloud
and publish versioned **contract views** (`inventory.devices_v1`, `software.installations_v1`,
...) on top of their internal tables. A consumer (compliance) joins the contracts, never the
tables. A domain can change its tables freely as long as every published contract version keeps
its columns and types, which a contract test in the domain's own pipeline verifies.

The SQL files walk through this end to end with a small hand-written data set: deploy both
domains, load data, run cross-domain queries, rename columns in domain A, show that the consumer
is unaffected, let the consumer adopt the next contract version.

## Layout

```
domains/inventory/schema/    010 table, 020 contract view v1, 030 release 2 (rename + views v1/v2)
domains/inventory/data/      010 devices, 020 a day of changes, 030 release-2 rows
domains/inventory/contract/  devices_v1_check.sql: the contract test as a single query
domains/software/            domain B (catalog, installations), same structure
consumer/compliance/schema/  database, optional role + dictionary, refreshable MVs (release 1 and 2)
consumer/compliance/queries/ the cross-domain question three ways, and the contract-usage query
```

## Run

Apply the SQL files with `clickhouse client` or the Cloud SQL console, one statement at a time,
in the order below. Run your own queries in between to see what each step changed.

**1. Both domains deploy release 1** (tables and contract views)

```
domains/inventory/schema/010_devices.sql
domains/inventory/schema/020_contract_devices_v1.sql
domains/software/schema/010_tables.sql
domains/software/schema/020_contracts_v1.sql
```

**2. Load the data**

```
domains/inventory/data/010_devices.sql
domains/software/data/010_catalog.sql
domains/software/data/020_installations.sql
```

**3. A normal day: a department move, a decommissioned device, an uninstall**

```
domains/inventory/data/020_churn.sql
domains/software/data/030_churn.sql
```

**4. The consumer deploys** (refreshable materialized view over both domains' contracts)

```
consumer/compliance/schema/000_database.sql
consumer/compliance/schema/030_report_mv.sql
SYSTEM REFRESH VIEW compliance.vulnerable_software_report
```

**5. Ask the cross-domain question** (vulnerable devices per department)

```
consumer/compliance/queries/vulnerable_by_department_join.sql
consumer/compliance/queries/vulnerable_by_department_report.sql
```

**6. Domain A ships release 2** (columns renamed, `site` added, `v1` re-published, `v2` added)

```
domains/inventory/schema/030_release2.sql
domains/inventory/data/030_release2_devices.sql
domains/software/data/040_release2_installations.sql
```

**7. Prove the consumer is unaffected**: re-run the two queries from step 5 unchanged, then run
the contract test:

```
domains/inventory/contract/devices_v1_check.sql
```

**8. The consumer adopts `v2` on its own schedule**, then checks who still reads `v1`

```
consumer/compliance/schema/040_release2_report_v2.sql
SYSTEM REFRESH VIEW compliance.vulnerable_software_by_site
consumer/compliance/queries/contract_usage.sql
```

**Optional: enforce the boundary.** `consumer/compliance/schema/010_access.sql` creates a role
with `SELECT` on the contract views only; create a consumer user with that role and try reading
`inventory.devices` directly. `020_device_dict.sql` adds dictionary-based enrichment; it needs a
dedicated read-only user for the dictionary source (replace the two placeholders).

## The pattern

- **One database per domain, owned by that domain.** Internal tables use
  `ReplacingMergeTree(version, is_deleted)`: updates are inserts with a higher version, deletes are
  tombstones.
- **Contracts are versioned views.** They fix columns and types, apply `FINAL`, filter tombstones,
  and run with `SQL SECURITY DEFINER`, so consumers need no grant on the tables behind them.
- **The contract test is the domain's release gate.** The view's columns and types must equal the
  committed contract (`domains/inventory/contract/devices_v1_check.sql`).
- **Breaking changes are expand and contract.** Re-publish `v1` on top of the new layout with
  `CREATE OR REPLACE VIEW`, add `v2`, retire `v1` when `system.query_log` shows no readers
  (`consumer/compliance/queries/contract_usage.sql`).
- **Consumers choose how to join.** Runtime JOIN for ad-hoc work, refreshable materialized views
  for reports, dictionaries for hot-path lookups. All of them read contracts only.

## Notes

- A `CLICKHOUSE` dictionary source on ClickHouse Cloud needs explicit credentials, hence the
  `{{DICT_USER}}` / `{{DICT_PASSWORD}}` placeholders in `020_device_dict.sql`.
