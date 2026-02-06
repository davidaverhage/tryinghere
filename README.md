# Wagic PlayStation Vita Port

This repository contains Wagic, the Homebrew card game, configured to build for PlayStation Vita with `.vpk` output support.

## About Wagic

Wagic is a C++ game engine that allows you to play Magic: The Gathering-style card games against an AI. This port brings the game to PlayStation Vita.

Original project: https://github.com/WagicProject/wagic

## Features

- Full Wagic gameplay on PS Vita
- Native Vita controls
- Optimized for Vita hardware
- VPK package for easy installation

## Prerequisites

To build this project, you need:

1. **VitaSDK** - The PlayStation Vita Software Development Kit
   - Installation instructions: https://vitasdk.org/
   - Must be properly installed and in your PATH

2. **Required VitaSDK Tools**:
   - `arm-vita-eabi-gcc` - Vita cross-compiler
   - `vita-elf-create` - ELF to VELF converter
   - `vita-make-fself` - VELF to EBOOT converter  
   - `vita-mksfoex` - SFO parameter file creator

3. **Build Tools**:
   - `make`
   - `zip`

## Building

**Note**: For detailed implementation notes and information about potential gaps that may need filling, see [IMPLEMENTATION_NOTES.md](IMPLEMENTATION_NOTES.md).

### Build Options

This project supports two build methods:

#### Option 1: CMake Build (Recommended)

```bash
./build-vita-cmake.sh
```

Uses CMake with VitaSDK's native CMake support for streamlined building.

#### Option 2: Makefile Build

```bash
./build-vita.sh
```

Uses traditional Make with manual VPK packaging.

### Quick Build

Use the provided build script:

```bash
./build-vita.sh
```

This will:
1. Check for required tools
2. Build the project
3. Package everything into `Wagic.vpk`

### Manual Build

If you prefer to build manually:

```bash
cd projects/mtg
make -f Makefile.vita
```

### Clean Build

To clean build artifacts:

```bash
./build-vita.sh clean
```

Or manually:

```bash
cd projects/mtg
make -f Makefile.vita clean
```

## Installation

1. Transfer `Wagic.vpk` to your PlayStation Vita
2. Install using VitaShell or your preferred package manager
3. Launch from LiveArea

## Project Structure

```
.
├── JGE/                    # Game engine library
│   ├── include/           # Engine headers
│   └── src/               # Engine source
├── projects/
│   └── mtg/               # Main Wagic game
│       ├── src/           # Game source files
│       ├── include/       # Game headers
│       ├── Makefile.vita  # Vita build configuration
│       └── bin/Res/       # Game resources
├── Boost/                 # Boost C++ library
├── tools/                 # Build utilities
├── build-vita.sh          # Main build script
└── README.md             # This file
```

## Build Output

The build process creates:

- `Wagic.elf` - Executable ELF file
- `Wagic.velf` - Vita ELF format
- `eboot.bin` - Vita executable
- `param.sfo` - Application metadata
- `Wagic.vpk` - **Final installable package**

## Customization

### Application Metadata

Edit `projects/mtg/Makefile.vita` to customize:

- `TITLE_ID` - Application ID (default: WAGI00001)
- `TITLE_NAME` - Display name (default: Wagic The Homebrew)
- `VERSION` - Version string (default: 01.00)

### Icon

Replace `projects/mtg/icon0.png` with your custom 512x512 icon.

## Troubleshooting

### "VITASDK not set" Error

Set the VITASDK environment variable:

```bash
export VITASDK=/usr/local/vitasdk
export PATH=$VITASDK/bin:$PATH
```

Add to your `~/.bashrc` or `~/.zshrc` for persistence.

### "Tool not found" Errors

Ensure VitaSDK is properly installed:

```bash
# Verify installation
which arm-vita-eabi-gcc
vita-elf-create --version
```

### Build Errors

Make sure all dependencies are installed:

```bash
# Update VitaSDK packages
vdpm update
```

## Development

### Source Files

Game logic is in `projects/mtg/src/` and uses the JGE engine from `JGE/src/`.

### Adding Features

1. Modify source files in `projects/mtg/src/`
2. Update `OBJS` in `Makefile.vita` if adding new files
3. Rebuild with `./build-vita.sh`

## License

See `LICENSE` file for Wagic license information.

## Credits

- Original Wagic Project: https://github.com/WagicProject/wagic
- PlayStation Vita port configuration created for this repository

## Support

For Wagic gameplay questions, visit the original project.
For Vita-specific build issues, check VitaSDK documentation.