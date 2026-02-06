#!/bin/bash
###############################################################################
# Wagic PlayStation Vita Build Script
# This script builds the Wagic .vpk file for PlayStation Vita
###############################################################################

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}Wagic PlayStation Vita Build Script${NC}"
echo -e "${GREEN}========================================${NC}"
echo ""

# Check for VitaSDK
if [ -z "$VITASDK" ]; then
    if [ -d "/usr/local/vitasdk" ]; then
        export VITASDK="/usr/local/vitasdk"
        echo -e "${YELLOW}VITASDK not set, using default: /usr/local/vitasdk${NC}"
    else
        echo -e "${RED}ERROR: VITASDK environment variable is not set!${NC}"
        echo -e "${RED}Please install VitaSDK and set VITASDK environment variable.${NC}"
        echo ""
        echo "Installation instructions:"
        echo "  https://vitasdk.org/"
        exit 1
    fi
fi

export PATH=$VITASDK/bin:$PATH

# Verify tools are available
echo -e "${GREEN}Checking for required tools...${NC}"
REQUIRED_TOOLS=("arm-vita-eabi-gcc" "vita-elf-create" "vita-make-fself" "vita-mksfoex")
MISSING_TOOLS=0

for tool in "${REQUIRED_TOOLS[@]}"; do
    if ! command -v "$tool" &> /dev/null; then
        echo -e "${RED}ERROR: $tool not found!${NC}"
        MISSING_TOOLS=$((MISSING_TOOLS + 1))
    else
        echo -e "  ✓ $tool found"
    fi
done

if [ $MISSING_TOOLS -gt 0 ]; then
    echo -e "${RED}Please ensure VitaSDK is properly installed.${NC}"
    exit 1
fi

echo ""
echo -e "${GREEN}All required tools found!${NC}"
echo ""

# Navigate to project directory
cd "$(dirname "$0")/projects/mtg"

# Clean previous build if requested
if [ "$1" == "clean" ]; then
    echo -e "${YELLOW}Cleaning previous build...${NC}"
    make -f Makefile.vita clean
    echo -e "${GREEN}Clean complete!${NC}"
    exit 0
fi

# Build the VPK
echo -e "${GREEN}Building Wagic.vpk...${NC}"
echo ""

if make -f Makefile.vita; then
    echo ""
    echo -e "${GREEN}========================================${NC}"
    echo -e "${GREEN}Build successful!${NC}"
    echo -e "${GREEN}========================================${NC}"
    echo ""
    echo -e "Output: ${GREEN}Wagic.vpk${NC}"
    echo ""
    echo "To install on your PS Vita:"
    echo "  1. Transfer Wagic.vpk to your Vita"
    echo "  2. Install using VitaShell or similar"
    echo "  3. Launch from LiveArea"
    echo ""
else
    echo ""
    echo -e "${RED}========================================${NC}"
    echo -e "${RED}Build failed!${NC}"
    echo -e "${RED}========================================${NC}"
    exit 1
fi
