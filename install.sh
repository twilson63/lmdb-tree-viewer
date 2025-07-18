#!/bin/bash

# LMDB Tree Viewer Installation Script
# Usage: curl -sSL https://raw.githubusercontent.com/twilson63/lmdb-tree-viewer/main/install.sh | bash

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
REPO_URL="https://github.com/twilson63/lmdb-tree-viewer"
RELEASE_URL="https://api.github.com/repos/twilson63/lmdb-tree-viewer/releases/latest"
INSTALL_DIR="/usr/local/bin"
BINARY_NAME="lmdb-tree-viewer"

# Functions
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Detect OS and architecture
detect_platform() {
    local os=$(uname -s | tr '[:upper:]' '[:lower:]')
    local arch=$(uname -m)
    
    case $os in
        linux*)
            OS="linux"
            ;;
        darwin*)
            OS="darwin"
            ;;
        mingw*|msys*|cygwin*)
            OS="windows"
            ;;
        *)
            print_error "Unsupported operating system: $os"
            exit 1
            ;;
    esac
    
    case $arch in
        x86_64|amd64)
            ARCH="amd64"
            ;;
        aarch64|arm64)
            ARCH="arm64"
            ;;
        armv7l)
            ARCH="armv7"
            ;;
        *)
            print_error "Unsupported architecture: $arch"
            exit 1
            ;;
    esac
    
    print_status "Detected platform: $OS/$ARCH"
}

# Check if mdb_dump is available
check_dependencies() {
    if ! command -v mdb_dump &> /dev/null; then
        print_warning "mdb_dump is not installed. LMDB Tree Viewer requires it to function."
        echo
        echo "Please install the LMDB utilities:"
        case $OS in
            linux)
                echo "  Ubuntu/Debian: sudo apt-get install lmdb-utils"
                echo "  CentOS/RHEL:   sudo yum install lmdb-utils"
                echo "  Arch Linux:    sudo pacman -S lmdb"
                ;;
            darwin)
                echo "  macOS: brew install lmdb"
                ;;
            windows)
                echo "  Windows: Download from https://www.lmdb.tech/doc/"
                ;;
        esac
        echo
        read -p "Continue installation anyway? (y/N): " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            print_error "Installation cancelled"
            exit 1
        fi
    else
        print_success "mdb_dump found: $(which mdb_dump)"
    fi
}

# Download and install binary
install_binary() {
    local tmpdir=$(mktemp -d)
    local binary_url
    
    print_status "Creating temporary directory: $tmpdir"
    
    # Get latest release info
    print_status "Fetching latest release information..."
    
    if command -v curl &> /dev/null; then
        local release_data=$(curl -s "$RELEASE_URL")
    elif command -v wget &> /dev/null; then
        local release_data=$(wget -qO- "$RELEASE_URL")
    else
        print_error "Neither curl nor wget found. Please install one of them."
        exit 1
    fi
    
    # Extract download URL for our platform
    local binary_name="${BINARY_NAME}-${OS}-${ARCH}"
    if [[ $OS == "windows" ]]; then
        binary_name="${binary_name}.exe"
    fi
    
    binary_url=$(echo "$release_data" | grep -o "\"browser_download_url\":[[:space:]]*\"[^\"]*${binary_name}[^\"]*\"" | cut -d'"' -f4)
    
    if [[ -z "$binary_url" ]]; then
        print_error "Could not find binary for platform $OS/$ARCH"
        print_status "Available releases:"
        echo "$release_data" | grep -o "\"browser_download_url\":[[:space:]]*\"[^\"]*\"" | cut -d'"' -f4
        exit 1
    fi
    
    print_status "Downloading $binary_name..."
    print_status "URL: $binary_url"
    
    # Download binary
    if command -v curl &> /dev/null; then
        curl -L -o "$tmpdir/$BINARY_NAME" "$binary_url"
    else
        wget -O "$tmpdir/$BINARY_NAME" "$binary_url"
    fi
    
    # Make executable
    chmod +x "$tmpdir/$BINARY_NAME"
    
    # Install binary
    print_status "Installing to $INSTALL_DIR..."
    
    if [[ -w "$INSTALL_DIR" ]]; then
        cp "$tmpdir/$BINARY_NAME" "$INSTALL_DIR/"
    else
        print_status "Requesting sudo privileges for installation..."
        sudo cp "$tmpdir/$BINARY_NAME" "$INSTALL_DIR/"
    fi
    
    # Cleanup
    rm -rf "$tmpdir"
    
    print_success "Installation completed!"
}

# Verify installation
verify_installation() {
    if command -v "$BINARY_NAME" &> /dev/null; then
        print_success "lmdb-tree-viewer is now available in your PATH"
        print_status "Version: $($BINARY_NAME --version)"
        echo
        echo "Try it out:"
        echo "  $BINARY_NAME --help"
        echo "  mdb_dump /path/to/database.lmdb | $BINARY_NAME --summary"
    else
        print_error "Installation verification failed"
        print_status "You may need to restart your terminal or run:"
        echo "  export PATH=\"$INSTALL_DIR:\$PATH\""
        exit 1
    fi
}

# Main installation flow
main() {
    echo
    echo "╔══════════════════════════════════════════════════════════════════════════════╗"
    echo "║                         LMDB Tree Viewer Installer                          ║"
    echo "║                                                                              ║"
    echo "║  A powerful tool for visualizing LMDB database structure as hierarchical    ║"
    echo "║  trees. Perfect for debugging, exploring, and understanding LMDB databases. ║"
    echo "╚══════════════════════════════════════════════════════════════════════════════╝"
    echo
    
    detect_platform
    check_dependencies
    install_binary
    verify_installation
    
    echo
    print_success "🎉 Installation complete!"
    echo
    echo "Quick start:"
    echo "  1. Find an LMDB database file (usually *.lmdb or in a directory with data.mdb)"
    echo "  2. Run: mdb_dump /path/to/database.lmdb | lmdb-tree-viewer"
    echo "  3. For a summary: mdb_dump /path/to/database.lmdb | lmdb-tree-viewer --summary"
    echo
    echo "Documentation: $REPO_URL"
    echo "Report issues: $REPO_URL/issues"
    echo
}

# Run installation
main "$@"