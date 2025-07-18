# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Planning for JSON output format
- Planning for filtering by key patterns
- Planning for export to file functionality

## [1.0.0] - 2024-07-18

### Added
- Initial release of LMDB Tree Viewer
- **Tree visualization mode**: Display LMDB databases as hierarchical trees
- **Summary mode**: Condensed overview of database structure
- **Link detection**: Automatically identifies and highlights link references
- **Cross-platform support**: Linux, macOS, and Windows binaries
- **Universal compatibility**: Works with any LMDB database regardless of creation flags
- **Performance optimizations**: Efficiently handles large databases
- **Command-line interface** with options:
  - `--summary` / `-s`: Show condensed structure summary
  - `--parser` / `-p`: Show full tree visualization (default)
  - `--help` / `-h`: Show help message
  - `--version` / `-v`: Show version information
- **Professional documentation**: Comprehensive README with examples
- **Installation script**: One-liner installation for easy setup
- **GitHub Actions CI/CD**: Automated releases and cross-platform builds
- **Examples**: Sample output documentation for different database types

### Technical Details
- Pure Lua implementation for maximum compatibility
- Efficient hex-to-string conversion for key parsing
- Tree depth limiting to prevent overwhelming output
- Unicode tree characters for beautiful visualization
- Memory-efficient processing for large databases
- Robust error handling and user feedback

### Dependencies
- Requires `mdb_dump` utility from LMDB tools package
- Compatible with Lua 5.1+ or bundled runtime

### Supported Platforms
- Linux (amd64, arm64)
- macOS (amd64, arm64)
- Windows (amd64)

### Distribution
- Pre-built binaries available on GitHub Releases
- One-liner installation script
- Manual installation instructions
- Package includes bundled runtime for zero-dependency usage

---

## Release Notes

### What's New in v1.0.0

This is the initial release of LMDB Tree Viewer, a powerful command-line tool for visualizing LMDB database structure as hierarchical trees.

**Key Features:**
- 🌳 **Beautiful tree visualization** with Unicode characters
- 📊 **Summary mode** for quick database overview
- 🔗 **Smart link detection** with visual indicators
- 🚀 **High performance** for large databases
- 📱 **Cross-platform** support
- 🛠️ **Universal compatibility** with any LMDB database

**Perfect for:**
- Database debugging and exploration
- Documentation generation
- Migration planning
- Performance analysis
- Understanding unfamiliar databases

**Installation:**
```bash
curl -sSL https://raw.githubusercontent.com/twilson63/lmdb-tree-viewer/main/install.sh | bash
```

**Usage:**
```bash
mdb_dump /path/to/database.lmdb | lmdb-tree-viewer --summary
```

### Migration from Other Tools

If you're migrating from other LMDB inspection tools:

1. **From manual mdb_dump inspection**: LMDB Tree Viewer provides structured, readable output instead of raw hex dumps
2. **From custom scripts**: Replace ad-hoc database inspection scripts with a professional, maintained tool
3. **From GUI tools**: Get the same functionality in a scriptable, CI/CD-friendly command-line tool

### Development

This project is built with:
- **Lua**: Core implementation language
- **GitHub Actions**: CI/CD pipeline
- **Cross-platform builds**: Automated release generation
- **Professional documentation**: Comprehensive guides and examples

### Community

- **Issues**: Report bugs and request features on GitHub
- **Discussions**: Join the community for questions and ideas
- **Contributions**: Pull requests welcome!

### Acknowledgments

Thanks to the LMDB community and all contributors who made this project possible.