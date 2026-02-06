# PlayStation Vita Port - Setup and Implementation Notes

## Overview

This document describes the PlayStation Vita port implementation for Wagic, including what has been set up and what gaps may need to be filled for a complete working build.

## What Has Been Implemented

### 1. Build System

Two build system options have been provided:

#### Option A: Makefile-based Build
- **File**: `projects/mtg/Makefile.vita`
- **Script**: `build-vita.sh`
- Uses traditional Make with VitaSDK toolchain
- Manually packages VPK files

#### Option B: CMake-based Build (Recommended)
- **File**: `projects/mtg/CMakeLists.txt`
- **Script**: `build-vita-cmake.sh`
- Uses CMake with VitaSDK's built-in CMake support
- Automated VPK packaging via vita_create_vpk

### 2. Project Structure

```
tryinghere/
├── JGE/                    # Game Engine
│   ├── include/           # Headers
│   └── src/               # Source code
├── projects/mtg/          # Main Game
│   ├── src/               # Game source
│   ├── include/           # Game headers
│   ├── bin/Res/           # Resources
│   ├── Makefile.vita      # Make build config
│   ├── CMakeLists.txt     # CMake build config
│   ├── icon0.png          # App icon (copied from icon.png)
│   └── sce_sys/           # Vita system files
├── Boost/                 # C++ Boost library
├── build-vita.sh          # Make build script
├── build-vita-cmake.sh    # CMake build script
└── README.md              # Main documentation
```

### 3. VPK Package Configuration

- **Title ID**: WAGI00001
- **Title Name**: Wagic The Homebrew
- **Version**: 01.00
- **Icon**: icon0.png (512x512 PNG recommended)

### 4. Build Scripts

Both build scripts include:
- VitaSDK environment validation
- Required tool checking
- Automated building and packaging
- Error handling and user-friendly output

## Potential Gaps That May Need Filling

### 1. Platform-Specific Code

The original Wagic project was designed for PSP, which has different APIs than PS Vita. The following areas may need platform-specific implementations:

#### Graphics Backend
- **PSP uses**: PSP GU (Graphics Utility) library
- **Vita needs**: One of:
  - SDL2 (easiest, cross-platform)
  - SceGxm (native Vita graphics, most performant)
  - libvita2d (simplified 2D wrapper over GXM)

**Location**: `JGE/src/` - Graphics rendering code
**Files to check**: `JGfx.cpp`, `JRenderer.cpp`

#### Input Handling
- **PSP uses**: sceCtrl functions
- **Vita uses**: SceCtrl (similar but different API)

**Location**: `JGE/src/` - Input handling code
**Files to check**: `JApp.cpp`, controller input code

#### Audio System
- **PSP uses**: sceAudio, MP3 decoder PRX
- **Vita uses**: SceAudio

**Location**: `JGE/src/` - Audio code
**Files to check**: `JSfx.cpp`, `JAudio.cpp`, `JMP3.cpp`

### 2. Engine Platform Abstraction

The JGE engine may need Vita-specific implementations:

```cpp
// Vita-specific code may need to be added to:
JGE/include/JGE.h           // Platform detection
JGE/src/JApp.cpp            // Application lifecycle
JGE/src/JFileSystem.cpp     // Vita filesystem paths
```

**Suggested approach**:
1. Add `#ifdef VITA` blocks similar to existing `#ifdef PSP` code
2. Implement Vita equivalents of PSP functions
3. Use SDL2 as an abstraction layer where possible

### 3. Missing Dependencies

The Makefile/CMakeLists references libraries that may need to be compiled for Vita:

#### JGE Engine Library
- May need to be built separately for Vita
- Located in `JGE/` directory
- Check `JGE/Makefile` for PSP build, adapt for Vita

#### Third-party Libraries
The following libraries are used and should be available via VitaSDK:
- ✅ freetype - Available in VitaSDK
- ✅ jpeg - Available in VitaSDK
- ✅ png - Available in VitaSDK
- ✅ zlib - Available in VitaSDK
- ❓ Custom libraries (hgetools, etc.) - May need porting

### 4. Resource Files

The game requires resource files in `projects/mtg/bin/Res/`:
- Card images
- Fonts
- Audio files
- Configuration files

**Current status**: Directory structure exists, but actual game assets need to be present for the game to run.

### 5. Entry Point

The main entry point may need Vita-specific initialization:

**Original**: `JGE/src/main.cpp` (PSP-specific)
**Needed**: Vita-specific main() that:
- Initializes SceGxm or SDL2
- Sets up Vita filesystem paths
- Handles Vita-specific lifecycle events

### 6. Build Testing

Since this is a cross-compilation setup, actual build testing requires:
- VitaSDK installed and configured
- All dependencies available
- Actual compilation to verify no missing symbols

## Recommended Next Steps

### For a Complete Working Port:

1. **Install VitaSDK** on a development machine
2. **Choose Graphics Backend**:
   - Quick/Easy: Port to SDL2
   - Performance: Port to libvita2d or SceGxm
3. **Adapt JGE Engine**:
   - Add Vita platform definitions
   - Implement Vita-specific graphics/input/audio
4. **Build JGE Library** for Vita
5. **Test Compilation**:
   ```bash
   ./build-vita-cmake.sh
   ```
6. **Fix Compilation Errors** iteratively
7. **Add Vita-specific Code** where needed
8. **Test on Real Hardware** or Vita3K emulator

### Quick Start Path (Using SDL2):

If starting fresh with minimal PSP code:

1. Replace graphics backend with SDL2:
   ```bash
   # Install SDL2 for Vita via vdpm
   vdpm install sdl2
   ```

2. Modify CMakeLists.txt to include SDL2:
   ```cmake
   find_package(SDL2 REQUIRED)
   target_link_libraries(${PROJECT_NAME} SDL2)
   ```

3. Replace PSP-specific rendering with SDL2 calls

4. Build and test

## Testing Without Vita Hardware

For testing without a PS Vita:

1. **Vita3K Emulator**: https://vita3k.org/
   - Can run .vpk files
   - Good for initial testing

2. **Cross-compilation Testing**:
   - Just try to build, fix errors
   - Many issues will be caught at compile time

## Additional Resources

- **VitaSDK Documentation**: https://vitasdk.org/
- **Vita Development Wiki**: https://wiki.henkaku.xyz/
- **SDL2 Vita Port**: Available via vdpm package manager
- **Original Wagic**: https://github.com/WagicProject/wagic

## Summary

This setup provides:
- ✅ Build system infrastructure (Makefile + CMake)
- ✅ Build scripts with error handling
- ✅ VPK packaging configuration
- ✅ Project structure
- ✅ Documentation

Still needed for a complete port:
- ⚠️ Platform-specific graphics/input/audio code
- ⚠️ JGE engine Vita adaptation
- ⚠️ Actual build testing and compilation
- ⚠️ Testing on hardware/emulator

The foundation is in place - the remaining work is adapting the PSP-specific code to use Vita APIs or SDL2.
