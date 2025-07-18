# LMDB Tree Viewer Usage Guide

This guide covers advanced usage patterns and tips for getting the most out of LMDB Tree Viewer.

## Table of Contents

- [Basic Usage](#basic-usage)
- [Advanced Filtering](#advanced-filtering)
- [Performance Tips](#performance-tips)
- [Output Formats](#output-formats)
- [Common Use Cases](#common-use-cases)
- [Troubleshooting](#troubleshooting)

## Basic Usage

### Prerequisites

Before using LMDB Tree Viewer, ensure you have the LMDB utilities installed:

```bash
# macOS
brew install lmdb

# Ubuntu/Debian
sudo apt-get install lmdb-utils

# CentOS/RHEL
sudo yum install lmdb-utils

# Fedora
sudo dnf install lmdb-utils
```

### Basic Commands

```bash
# View full tree structure
mdb_dump /path/to/database.lmdb | lmdb-tree-viewer

# View summary
mdb_dump /path/to/database.lmdb | lmdb-tree-viewer --summary

# Show version
lmdb-tree-viewer --version

# Show help
lmdb-tree-viewer --help
```

## Advanced Filtering

While LMDB Tree Viewer doesn't have built-in filtering, you can use standard Unix tools to filter the output:

### Filter by Key Pattern

```bash
# Show only keys containing "user"
mdb_dump /path/to/database.lmdb | grep -i user | lmdb-tree-viewer

# Show only keys starting with "config"
mdb_dump /path/to/database.lmdb | grep "^config" | lmdb-tree-viewer
```

### Limit Output Size

```bash
# Show only first 1000 keys
mdb_dump /path/to/database.lmdb | head -1000 | lmdb-tree-viewer

# Show only last 1000 keys
mdb_dump /path/to/database.lmdb | tail -1000 | lmdb-tree-viewer
```

### Search for Specific Patterns

```bash
# Find all link references
mdb_dump /path/to/database.lmdb | lmdb-tree-viewer | grep "🔗"

# Find all group containers
mdb_dump /path/to/database.lmdb | lmdb-tree-viewer | grep "📁"
```

## Performance Tips

### Large Databases

For very large databases (>10GB), consider these optimizations:

```bash
# Use summary mode for quick overview
mdb_dump /path/to/large.lmdb | lmdb-tree-viewer --summary

# Limit depth by filtering output
mdb_dump /path/to/large.lmdb | lmdb-tree-viewer | head -500

# Process in chunks
mdb_dump /path/to/large.lmdb | split -l 10000 - chunk_
for chunk in chunk_*; do
    cat "$chunk" | lmdb-tree-viewer --summary
done
```

### Memory Usage

LMDB Tree Viewer is memory-efficient and can handle databases larger than available RAM:

- **Streaming processing**: Keys are processed as they're read
- **Efficient parsing**: Optimized hex-to-string conversion
- **Bounded memory**: Memory usage doesn't scale with database size

## Output Formats

### Tree Format (Default)

The default tree format uses Unicode box-drawing characters:

```
├── parent
│   ├── child1
│   └── child2
└── 🔗 link+reference
```

### Summary Format

Summary format provides statistical overview:

```
📁 group_name (1,234 entries)
    key1
    key2
  🔗 link_key
    key3
```

### Saving Output

```bash
# Save tree to file
mdb_dump /path/to/database.lmdb | lmdb-tree-viewer > tree.txt

# Save summary to file
mdb_dump /path/to/database.lmdb | lmdb-tree-viewer --summary > summary.txt

# Save with timestamp
mdb_dump /path/to/database.lmdb | lmdb-tree-viewer --summary > "summary-$(date +%Y%m%d-%H%M%S).txt"
```

## Common Use Cases

### Database Debugging

```bash
# Quick overview of unknown database
mdb_dump /var/lib/unknown-app/data.lmdb | lmdb-tree-viewer --summary

# Find specific key patterns
mdb_dump /var/lib/app/data.lmdb | lmdb-tree-viewer | grep -i "error\|failed\|exception"
```

### Schema Documentation

```bash
# Generate documentation
echo "# Database Schema" > schema.md
echo "Generated on $(date)" >> schema.md
echo "" >> schema.md
mdb_dump /path/to/database.lmdb | lmdb-tree-viewer --summary >> schema.md
```

### Migration Planning

```bash
# Compare two database versions
mdb_dump /path/to/old.lmdb | lmdb-tree-viewer --summary > old-schema.txt
mdb_dump /path/to/new.lmdb | lmdb-tree-viewer --summary > new-schema.txt
diff old-schema.txt new-schema.txt
```

### Performance Analysis

```bash
# Find largest groups
mdb_dump /path/to/database.lmdb | lmdb-tree-viewer --summary | grep "entries)" | sort -nr -k3

# Count total keys
mdb_dump /path/to/database.lmdb | lmdb-tree-viewer --summary | grep "Total keys:" | cut -d: -f2
```

## Troubleshooting

### Common Issues

#### "No keys found" Error

```bash
# Check if database file exists
ls -la /path/to/database.lmdb

# Check if mdb_dump works
mdb_dump /path/to/database.lmdb | head -10

# Check if database is valid
mdb_stat /path/to/database.lmdb
```

#### "mdb_dump: command not found"

```bash
# Install LMDB utilities
# macOS
brew install lmdb

# Ubuntu/Debian
sudo apt-get install lmdb-utils
```

#### Permission Denied

```bash
# Check file permissions
ls -la /path/to/database.lmdb

# Run with appropriate permissions
sudo mdb_dump /path/to/database.lmdb | lmdb-tree-viewer
```

#### Database Corruption

```bash
# Check database integrity
mdb_stat /path/to/database.lmdb

# Try to recover
mdb_copy /path/to/database.lmdb /path/to/recovered.lmdb
```

### Performance Issues

#### Slow Processing

```bash
# Use summary mode for large databases
mdb_dump /path/to/large.lmdb | lmdb-tree-viewer --summary

# Limit output size
mdb_dump /path/to/large.lmdb | head -1000 | lmdb-tree-viewer
```

#### Memory Issues

```bash
# Monitor memory usage
top -p $(pgrep lmdb-tree-viewer)

# Use streaming approach
mdb_dump /path/to/database.lmdb | lmdb-tree-viewer --summary | head -100
```

### Environment Issues

#### Different Lua Versions

LMDB Tree Viewer is compatible with Lua 5.1+. If you encounter issues:

```bash
# Check Lua version
lua -v

# Use bundled runtime if available
./lmdb-tree-viewer --version
```

#### Path Issues

```bash
# Check if lmdb-tree-viewer is in PATH
which lmdb-tree-viewer

# Use absolute path
/usr/local/bin/lmdb-tree-viewer --help
```

## Tips and Tricks

### Shortcuts

```bash
# Quick alias for common usage
alias lmdb-summary='mdb_dump "$1" | lmdb-tree-viewer --summary'
alias lmdb-tree='mdb_dump "$1" | lmdb-tree-viewer'

# Usage
lmdb-summary /path/to/database.lmdb
lmdb-tree /path/to/database.lmdb
```

### Integration with Other Tools

```bash
# Combine with find
find /var/lib -name "*.lmdb" -exec sh -c 'echo "=== {} ===" && mdb_dump {} | lmdb-tree-viewer --summary' \;

# Combine with watch for monitoring
watch -n 10 'mdb_dump /path/to/database.lmdb | lmdb-tree-viewer --summary'
```

### Automation

```bash
#!/bin/bash
# Script to analyze all LMDB databases in a directory

for db in /var/lib/*/data.lmdb; do
    echo "Analyzing $db..."
    mdb_dump "$db" | lmdb-tree-viewer --summary > "${db%.lmdb}-analysis.txt"
done
```

## Best Practices

1. **Use summary mode first**: Always start with `--summary` to get an overview
2. **Limit output for large databases**: Use `head` or `tail` to manage output size
3. **Save results**: Redirect output to files for later analysis
4. **Check database health**: Use `mdb_stat` before analysis
5. **Monitor performance**: Use `top` or `htop` for resource monitoring

## Getting Help

If you encounter issues not covered in this guide:

1. Check the [GitHub Issues](https://github.com/twilson63/lmdb-tree-viewer/issues)
2. Review the [FAQ](https://github.com/twilson63/lmdb-tree-viewer/wiki/FAQ)
3. Join the [Discussions](https://github.com/twilson63/lmdb-tree-viewer/discussions)
4. Create a new issue with detailed information about your problem