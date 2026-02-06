#!/bin/bash
###############################################################################
# Wagic PlayStation Vita CMake Build Script
# This script builds the Wagic .vpk file using CMake
###############################################################################

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${GREEN}========================================${NC}"
echo -e "${GREEN}Wagic PlayStation Vita CMake Build${NC}"
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

# Verify CMake is available
if ! command -v cmake &> /dev/null; then
    echo -e "${RED}ERROR: cmake not found!${NC}"
    echo -e "${RED}Please install CMake.${NC}"
    exit 1
fi

echo -e "${GREEN}✓ CMake found${NC}"
echo -e "${GREEN}✓ VitaSDK: $VITASDK${NC}"
echo ""

# Navigate to project directory
cd "$(dirname "$0")/projects/mtg"

# Clean previous build if requested
if [ "$1" == "clean" ]; then
    echo -e "${YELLOW}Cleaning previous build...${NC}"
    rm -rf build
    echo -e "${GREEN}Clean complete!${NC}"
    exit 0
fi

# Create build directory
mkdir -p build
cd build

# Configure with CMake
echo -e "${GREEN}Configuring with CMake...${NC}"
if cmake ..; then
    echo -e "${GREEN}✓ Configuration successful${NC}"
else
    echo -e "${RED}Configuration failed!${NC}"
    exit 1
fi

echo ""
echo -e "${GREEN}Building...${NC}"
if make -j$(nproc); then
    echo ""
    echo -e "${GREEN}========================================${NC}"
    echo -e "${GREEN}Build successful!${NC}"
    echo -e "${GREEN}========================================${NC}"
    echo ""
    
    if [ -f "Wagic.vpk" ]; then
        echo -e "Output: ${GREEN}$(pwd)/Wagic.vpk${NC}"
        echo ""
        echo "To install on your PS Vita:"
        echo "  1. Transfer Wagic.vpk to your Vita"
        echo "  2. Install using VitaShell"
        echo "  3. Launch from LiveArea"
        echo ""
    else
        echo -e "${YELLOW}Warning: Wagic.vpk not found in build directory${NC}"
    fi
else
    echo ""
    echo -e "${RED}========================================${NC}"
    echo -e "${RED}Build failed!${NC}"
    echo -e "${RED}========================================${NC}"
    exit 1
fi
