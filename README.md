# LMDB Tree Viewer

A powerful command-line tool for visualizing LMDB database structure as hierarchical trees. Perfect for debugging, exploring, and understanding the structure of any LMDB database.

![LMDB Tree Viewer Demo](https://img.shields.io/badge/status-stable-green.svg)
![Version](https://img.shields.io/badge/version-1.0.0-blue.svg)
![License](https://img.shields.io/badge/license-MIT-green.svg)

## Features

- 🌳 **Tree Visualization**: View your LMDB database as a hierarchical tree structure
- 📊 **Summary Mode**: Get a condensed overview of your database structure
- 🔗 **Link Detection**: Automatically identifies and highlights link references
- 🏗️ **Universal Compatibility**: Works with any LMDB database regardless of creation flags
- 🚀 **Fast Performance**: Efficiently handles large databases with millions of keys
- 📱 **Cross-platform**: Works on Linux, macOS, and Windows

## Installation

### Quick Install (Recommended)

```bash
curl -sSL https://raw.githubusercontent.com/username/lmdb-tree-viewer/main/install.sh | bash
```

### Manual Installation

1. Download the latest release from [GitHub Releases](https://github.com/username/lmdb-tree-viewer/releases)
2. Extract the archive
3. Make the binary executable: `chmod +x lmdb-tree-viewer`
4. Move to your PATH: `mv lmdb-tree-viewer /usr/local/bin/`

### Requirements

- **mdb_dump**: LMDB utilities package
  - macOS: `brew install lmdb`
  - Ubuntu/Debian: `apt-get install lmdb-utils`
  - CentOS/RHEL: `yum install lmdb-utils`
  - Windows: Download from [LMDB website](https://www.lmdb.tech/doc/)

## Usage

### Basic Usage

```bash
# Full tree visualization (default)
mdb_dump /path/to/database.lmdb | lmdb-tree-viewer

# Summary mode
mdb_dump /path/to/database.lmdb | lmdb-tree-viewer --summary

# Show help
lmdb-tree-viewer --help
```

### Command Line Options

```
Usage: mdb_dump /path/to/lmdb | lmdb-tree-viewer [OPTIONS]

OPTIONS:
  --summary, -s    Show condensed structure summary
  --parser, -p     Show full tree visualization (default)
  --help, -h       Show this help message
  --version, -v    Show version information
```

### Examples

#### Example 1: Application Database
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

Statistics:
-----------
Total groups: 156
Total entries: 45,234
Link references: 12,543
```

#### Example 2: Blockchain Database
```bash
mdb_dump /var/lib/blockchain/blocks.lmdb | lmdb-tree-viewer
```

**Output:**
```
LMDB Database Tree Visualization
================================

Tree Structure:
---------------
├── blocks
│   ├── 0000001
│   │   ├── hash
│   │   ├── transactions
│   │   └── timestamp
│   └── 0000002
│       ├── hash
│       ├── transactions
│       └── timestamp
└── 🔗 chain+link
    └── latest
```

## Why Use mdb_dump?

LMDB databases can be created with various flags (`MDB_INTEGERKEY`, `MDB_DUPSORT`, etc.) that affect how they can be accessed. Rather than trying to guess these flags, `lmdb-tree-viewer` uses the official `mdb_dump` utility which can read any LMDB database regardless of its creation flags.

This approach provides:
- **Universal compatibility** with any LMDB database
- **Reliability** through battle-tested official tools
- **Performance** optimized for large databases
- **Security** by using read-only operations

## Use Cases

- **🔍 Database Debugging**: Understand the structure of unfamiliar LMDB databases
- **📊 Data Analysis**: Explore key patterns and relationships in your data
- **🏗️ Schema Documentation**: Generate visual documentation of your database structure
- **🚀 Migration Planning**: Analyze existing databases before migration
- **📈 Performance Optimization**: Identify hotspots and optimize key distribution

## Output Formats

### Tree Mode (Default)
Displays the full hierarchical structure with proper indentation and Unicode tree characters.

### Summary Mode
Provides a condensed overview showing:
- Total key count
- Top groups by entry count
- Sample keys for each group
- Link reference statistics
- Common field type counts

## Performance

- **Memory Efficient**: Processes databases larger than available RAM
- **Fast Parsing**: Optimized hex-to-string conversion
- **Scalable**: Tested with databases containing millions of keys
- **Depth Limiting**: Prevents overwhelming output on deeply nested structures

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

### Development

```bash
git clone https://github.com/username/lmdb-tree-viewer.git
cd lmdb-tree-viewer
./lmdb-tree-viewer --help
```

### Testing

```bash
# Test with a sample database
mdb_dump /path/to/test.lmdb | ./lmdb-tree-viewer --summary
```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

- 🐛 [Report Issues](https://github.com/username/lmdb-tree-viewer/issues)
- 💬 [Discussions](https://github.com/username/lmdb-tree-viewer/discussions)
- 📧 [Email Support](mailto:support@example.com)

## Changelog

### v1.0.0
- Initial release
- Tree visualization mode
- Summary mode
- Cross-platform support
- Comprehensive documentation

---

**Made with ❤️ for the LMDB community**