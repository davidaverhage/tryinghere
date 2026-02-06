# Wagic Source Files Attribution

This repository contains source files from the Wagic project, adapted for PlayStation Vita.

## Original Project

- **Name**: Wagic, the Homebrew
- **Repository**: https://github.com/WagicProject/wagic.git
- **License**: See LICENSE file
- **Commit**: Latest from master branch as of build date

## Files Included

The following directories were copied from the original Wagic repository:

### Core Engine
- `JGE/` - Complete JGE game engine
  - `include/` - Engine headers
  - `src/` - Engine source code
  - Platform-specific code for PSP, iOS, Android, PC

### Game Code
- `projects/mtg/` - Main Wagic card game implementation
  - `src/` - Game logic
  - `include/` - Game headers
  - `bin/` - Resources and assets
  - Original Makefiles preserved

### Dependencies
- `Boost/` - Boost C++ library headers
- `tools/` - Build and development tools
- `pspsdk/` - PSP SDK utilities (for reference)

### Documentation
- `LICENSE` - Original license
- `WAGIC_README.md` - Original README

## Modifications for Vita

The following new files were added specifically for PlayStation Vita support:

### Build System
- `projects/mtg/Makefile.vita` - Vita-specific Makefile
- `projects/mtg/CMakeLists.txt` - CMake build configuration
- `build-vita.sh` - Makefile build script
- `build-vita-cmake.sh` - CMake build script

### Documentation
- `README.md` - Vita build documentation
- `IMPLEMENTATION_NOTES.md` - Technical implementation details
- `QUICKSTART.md` - Quick start guide
- `SOURCE_ATTRIBUTION.md` - This file

### Assets
- `projects/mtg/icon0.png` - Copied from original icon.png
- `projects/mtg/sce_sys/` - Vita system directory

### Configuration
- `.gitignore` - Updated for Vita build artifacts

## No Code Modifications

**Important**: The original Wagic source code has NOT been modified. All original `.cpp`, `.h`, and other source files remain unchanged from the upstream repository.

The Vita port is configured through:
1. New build system files (Makefile.vita, CMakeLists.txt)
2. Build scripts that use VitaSDK toolchain
3. Additional documentation

Any platform-specific adaptations needed for Vita would need to be implemented by adding:
- `#ifdef VITA` blocks in existing code
- Vita-specific backend implementations
- SDL2 or GXM graphics adapters

## Upstream Sync

To update from upstream Wagic:

```bash
# Add original repo as remote
git remote add wagic https://github.com/WagicProject/wagic.git

# Fetch updates
git fetch wagic

# Merge updates (careful with conflicts)
git merge wagic/master
```

Or manually:
```bash
# Clone latest Wagic
git clone https://github.com/WagicProject/wagic.git wagic-new

# Copy updated directories
cp -r wagic-new/JGE ./
cp -r wagic-new/projects/mtg/src ./projects/mtg/
# etc.
```

## License Compliance

This repository complies with Wagic's original license. See the `LICENSE` file for complete license text.

All credit for the game engine and game logic goes to the original Wagic developers:
- https://github.com/WagicProject/wagic
- http://wololo.net/wagic/

This Vita port only adds build infrastructure - no game code was created or modified.

## Contributing

If you improve this Vita port:
1. Consider contributing back to the original Wagic project
2. Submit platform-specific Vita code as conditional compilation
3. Keep build files separate from game logic

For game bugs or features, report to the original Wagic project.
For Vita build issues, report to this repository.
