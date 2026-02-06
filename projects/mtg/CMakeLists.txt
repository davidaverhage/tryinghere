cmake_minimum_required(VERSION 3.19)

if(NOT DEFINED CMAKE_TOOLCHAIN_FILE)
  if(DEFINED ENV{VITASDK})
    set(CMAKE_TOOLCHAIN_FILE "$ENV{VITASDK}/share/vita.toolchain.cmake" CACHE PATH "toolchain file")
  else()
    message(FATAL_ERROR "Please define VITASDK to point to your SDK path!")
  endif()
endif()

project(Wagic C CXX)

set(CMAKE_C_STANDARD 99)
set(CMAKE_CXX_STANDARD 11)

# Application metadata
set(VITA_APP_NAME "Wagic The Homebrew")
set(VITA_TITLEID  "WAGI00001")
set(VITA_VERSION  "01.00")

# Source files
file(GLOB_RECURSE SOURCES 
  "src/*.cpp"
  "src/*.c"
)

# Remove test suite if it exists (for non-Vita builds)
list(FILTER SOURCES EXCLUDE REGEX ".*TestSuiteAI\\.cpp$")

# Include directories
include_directories(
  include
  ../../JGE/include
  ../../JGE/src
  ../../JGE/src/zipFS
  ../../Boost
)

# Compile definitions
add_definitions(
  -DVITA
  -DTIXML_USE_STL
)

# Create executable
add_executable(${PROJECT_NAME}
  ${SOURCES}
)

# Link libraries
target_link_libraries(${PROJECT_NAME}
  SceDisplay_stub
  SceGxm_stub
  SceCtrl_stub
  SceAudio_stub
  SceSysmodule_stub
  SceCommonDialog_stub
  freetype
  jpeg
  png
  z
  m
  stdc++
)

# Vita packaging
vita_create_self(${PROJECT_NAME}.self ${PROJECT_NAME})
vita_create_vpk(${PROJECT_NAME}.vpk ${VITA_TITLEID} ${PROJECT_NAME}.self
  VERSION ${VITA_VERSION}
  NAME ${VITA_APP_NAME}
  FILE icon0.png sce_sys/icon0.png
  FILE bin/Res bin/Res
)
