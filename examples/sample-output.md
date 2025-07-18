# Sample Output Examples

This document shows example outputs from `lmdb-tree-viewer` on different types of LMDB databases.

## Example 1: Application Database (Summary Mode)

```bash
mdb_dump /var/lib/myapp/data.lmdb | lmdb-tree-viewer --summary
```

**Output:**
```
LMDB Database Structure Summary
===============================

Total keys: 45,234

Main Groups (top 10):
--------------------
📁 users (15,432 entries)
    id
    email
    profile
  🔗 sessions+link
    settings

📁 products (8,901 entries)
    name
    price
  🔗 inventory+link
    category

📁 orders (6,789 entries)
    id
    user_id
    total
    status
    items

📁 sessions (4,567 entries)
    token
    user_id
    expires
    data

📁 inventory (3,234 entries)
    product_id
    quantity
    location
    updated

Statistics:
-----------
Total groups: 156
Total entries: 45,234
Link references: 12,543

Common field types:
  id: 2,345
  user_id: 1,234
  product_id: 987
  status: 456
```

## Example 2: Blockchain Database (Tree Mode)

```bash
mdb_dump /var/lib/blockchain/blocks.lmdb | lmdb-tree-viewer
```

**Output:**
```
LMDB Database Tree Visualization
================================

Found 125,678 keys

Sample keys:
  blocks
  blocks/0000001
  blocks/0000001/hash
  blocks/0000001/transactions
  blocks/0000001/timestamp
  blocks/0000002
  chain+link
  transactions
  accounts
  balances+link

Tree Structure:
---------------
├── accounts
│   ├── 0x1234567890abcdef...
│   │   ├── balance
│   │   ├── nonce
│   │   └── code
│   └── 0x9876543210fedcba...
│       ├── balance
│       ├── nonce
│       └── code
├── blocks
│   ├── 0000001
│   │   ├── hash
│   │   ├── transactions
│   │   │   ├── 0
│   │   │   │   ├── from
│   │   │   │   ├── to
│   │   │   │   └── value
│   │   │   └── 1
│   │   │       ├── from
│   │   │       ├── to
│   │   │       └── value
│   │   └── timestamp
│   └── 0000002
│       ├── hash
│       ├── transactions
│       └── timestamp
├── 🔗 chain+link
│   └── latest
└── transactions
    ├── pool
    │   ├── pending
    │   └── queued
    └── history
        ├── confirmed
        └── failed

Legend:
🔗 = Link/Reference
📁 = Group/Container
Tree depth limited to 6 levels for readability
```

## Example 3: Configuration Database (Summary Mode)

```bash
mdb_dump /etc/myservice/config.lmdb | lmdb-tree-viewer --summary
```

**Output:**
```
LMDB Database Structure Summary
===============================

Total keys: 1,234

Main Groups (top 10):
--------------------
📁 settings (456 entries)
    server
    database
    logging
    security
    cache

📁 users (234 entries)
    admin
    service
    guest
    roles

📁 permissions (123 entries)
    read
    write
    execute
    admin

📁 cache (89 entries)
    ttl
    size
    policies

Statistics:
-----------
Total groups: 23
Total entries: 1,234
Link references: 45

Common field types:
  enabled: 67
  timeout: 34
  port: 23
  host: 12
```

## Example 4: Empty Database

```bash
mdb_dump /tmp/empty.lmdb | lmdb-tree-viewer --summary
```

**Output:**
```
LMDB Database Structure Summary
===============================

Total keys: 0

Main Groups (top 10):
--------------------
(No groups found)

Statistics:
-----------
Total groups: 0
Total entries: 0
Link references: 0
```

## Example 5: Large Database with Deep Nesting

```bash
mdb_dump /var/lib/analytics/events.lmdb | lmdb-tree-viewer
```

**Output:**
```
LMDB Database Tree Visualization
================================

Found 2,345,678 keys

Sample keys:
  events
  events/2024
  events/2024/01
  events/2024/01/01
  events/2024/01/01/user_login
  events/2024/01/01/user_logout
  events/2024/01/01/page_view
  metrics
  aggregates+link
  indices

Tree Structure:
---------------
├── 🔗 aggregates+link
│   ├── daily
│   ├── weekly
│   └── monthly
├── events
│   ├── 2024
│   │   ├── 01
│   │   │   ├── 01
│   │   │   │   ├── user_login
│   │   │   │   ├── user_logout
│   │   │   │   └── page_view
│   │   │   └── 02
│   │   │       ├── user_login
│   │   │       ├── user_logout
│   │   │       └── page_view
│   │   └── 02
│   │       └── 01
│   │           ├── user_login
│   │           ├── user_logout
│   │           └── page_view
├── indices
│   ├── by_user
│   ├── by_date
│   └── by_type
└── metrics
    ├── counters
    ├── gauges
    └── histograms

Legend:
🔗 = Link/Reference
📁 = Group/Container
Tree depth limited to 6 levels for readability
```

## Error Handling Examples

### No Input Data
```bash
echo "" | lmdb-tree-viewer
```

**Output:**
```
No keys found. Make sure to pipe mdb_dump output:
mdb_dump /path/to/lmdb | lmdb-tree-viewer

If you don't have mdb_dump installed:
  macOS: brew install lmdb
  Ubuntu/Debian: apt-get install lmdb-utils
  CentOS/RHEL: yum install lmdb-utils
```

### Invalid Options
```bash
lmdb-tree-viewer --invalid-option
```

**Output:**
```
Unknown option: --invalid-option
Use --help for usage information
```

### Help Output
```bash
lmdb-tree-viewer --help
```

**Output:**
```
LMDB Tree Viewer v1.0.0
=======================

A tool for visualizing LMDB database structure as hierarchical trees.

Usage: mdb_dump /path/to/lmdb | lmdb-tree-viewer [OPTIONS]

OPTIONS:
  --summary, -s    Show condensed structure summary
  --parser, -p     Show full tree visualization (default)
  --help, -h       Show this help message
  --version, -v    Show version information

Examples:
  mdb_dump /var/lib/myapp/data.lmdb | lmdb-tree-viewer
  mdb_dump /var/lib/myapp/data.lmdb | lmdb-tree-viewer --summary
  mdb_dump /var/lib/myapp/data.lmdb | lmdb-tree-viewer -s

Note: This tool requires the 'mdb_dump' utility from the LMDB tools package.
Install with: brew install lmdb (macOS) or apt-get install lmdb-utils (Ubuntu)
```