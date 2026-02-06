# Quick Start Guide - Wagic PS Vita Build

This guide will help you quickly build Wagic for PlayStation Vita.

## Prerequisites Check

Before starting, ensure you have:

- [ ] Linux, macOS, or WSL on Windows
- [ ] VitaSDK installed
- [ ] CMake 3.19 or newer
- [ ] Git
- [ ] zip utility

## Step-by-Step Build Instructions

### 1. Install VitaSDK

If you haven't already, install VitaSDK:

```bash
# Clone VitaSDK setup scripts
git clone https://github.com/vitasdk/vdpm
cd vdpm
./bootstrap-vitasdk.sh

# This installs VitaSDK to /usr/local/vitasdk by default
```

### 2. Set Environment Variables

Add to your `~/.bashrc` or `~/.zshrc`:

```bash
export VITASDK=/usr/local/vitasdk
export PATH=$VITASDK/bin:$PATH
```

Then reload:
```bash
source ~/.bashrc  # or ~/.zshrc
```

### 3. Verify Installation

```bash
# Check that tools are available
which arm-vita-eabi-gcc
vita-elf-create --version
```

Both commands should produce output (not "command not found").

### 4. Clone This Repository

```bash
git clone https://github.com/davidaverhage/tryinghere.git
cd tryinghere
```

### 5. Build the VPK

Choose one of the build methods:

#### CMake Build (Recommended):
```bash
./build-vita-cmake.sh
```

#### Make Build:
```bash
./build-vita.sh
```

### 6. Find Your VPK

After successful build:
- **CMake**: `projects/mtg/build/Wagic.vpk`
- **Make**: `projects/mtg/Wagic.vpk`

## Installation on PS Vita

### Requirements
- PS Vita with HENkaku/h-encore/Trinity
- VitaShell or similar package installer

### Steps

1. **Connect Vita to PC**
   - Use USB connection or FTP

2. **Transfer VPK**
   ```bash
   # If using USB
   cp projects/mtg/build/Wagic.vpk /path/to/vita/
   
   # If using FTP (example)
   curl -T projects/mtg/build/Wagic.vpk ftp://192.168.1.XXX:1337/
   ```

3. **Install on Vita**
   - Open VitaShell
   - Navigate to the VPK file
   - Press X to install
   - Press X again to confirm

4. **Launch**
   - Exit VitaShell
   - Find "Wagic The Homebrew" in LiveArea
   - Tap to launch!

## Troubleshooting

### "VITASDK not set" Error

```bash
# Verify VITASDK is set
echo $VITASDK

# If empty, set it:
export VITASDK=/usr/local/vitasdk
export PATH=$VITASDK/bin:$PATH
```

### Build Fails with Missing Libraries

```bash
# Update VitaSDK packages
vdpm update
vdpm install sdl2 # If using SDL2
```

### "arm-vita-eabi-gcc: command not found"

VitaSDK is not in your PATH:
```bash
export PATH=$VITASDK/bin:$PATH
```

### Compilation Errors

This port may require additional platform-specific code. See [IMPLEMENTATION_NOTES.md](IMPLEMENTATION_NOTES.md) for details on what may need to be implemented.

Common areas:
- Graphics backend (SDL2 recommended)
- Input handling
- Audio system
- JGE engine Vita port

### VPK Install Fails on Vita

- Ensure you have enough space (check in VitaShell)
- Verify VPK is not corrupted (re-download)
- Check that you have the latest VitaShell

## Next Steps

After installation:

1. **Add Game Assets**
   - The game requires card images and resources
   - Place in `ux0:/data/Wagic/Res/` on your Vita
   - See original Wagic project for asset downloads

2. **Configure Game**
   - Settings are in `ux0:/data/Wagic/`
   - Customize controls, graphics, etc.

## Need Help?

- **Build Issues**: Check [IMPLEMENTATION_NOTES.md](IMPLEMENTATION_NOTES.md)
- **VitaSDK Issues**: https://vitasdk.org/
- **Wagic Gameplay**: https://github.com/WagicProject/wagic
- **Vita Homebrew**: https://wiki.henkaku.xyz/

## Quick Reference Commands

```bash
# Build (CMake)
./build-vita-cmake.sh

# Build (Make)
./build-vita.sh

# Clean build
./build-vita-cmake.sh clean
# or
./build-vita.sh clean

# Check VitaSDK
echo $VITASDK
which arm-vita-eabi-gcc

# Update VitaSDK packages
vdpm update
```

## Testing Without Vita Hardware

Use the **Vita3K** emulator:

1. Download from https://vita3k.org/
2. Install the VPK in the emulator
3. Test functionality

Note: Emulator is not perfect, real hardware testing recommended.

## Success Checklist

- [x] VitaSDK installed
- [x] Build script runs without errors
- [x] Wagic.vpk created
- [x] VPK installs on Vita
- [ ] Game launches (may need assets)
- [ ] Game is playable (may need platform code)

If you get through the first 3 items, the build system is working! The last items depend on complete platform implementation.
