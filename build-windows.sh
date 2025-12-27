#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -ne 3 ]; then
    echo "Usage: $0 <SDL3_Version> <SDL3_Image_Version> <SDL3_ttf_Version>"
    exit 1
fi

echo "Building SDL3-$1..."

# Set SDL3 versions
SDL3=release-$1
SDL3_Image=release-$2
SDL3_ttf=release-$3

# Set runtime directories
Windows_Runtime=artifacts/runtimes/win-x64/native
mkdir -p ${Windows_Runtime} toolchains

# Setup MinGW toolchain
cat > toolchains/x86_64-w64-mingw32.cmake <<EOL
SET(CMAKE_SYSTEM_NAME Windows)
SET(CMAKE_SYSTEM_PROCESSOR x86_64)
find_program(CMAKE_C_COMPILER NAMES x86_64-w64-mingw32-gcc REQUIRED)
find_program(CMAKE_CXX_COMPILER NAMES x86_64-w64-mingw32-g++ REQUIRED)
find_program(CMAKE_RC_COMPILER NAMES x86_64-w64-mingw32-windres windres REQUIRED)
EOL

# Build SDL3
git clone --branch ${SDL3} --depth 1 https://github.com/libsdl-org/SDL.git

cmake -S SDL -B SDL/build-windows -G Ninja \
      -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_TOOLCHAIN_FILE=../toolchains/x86_64-w64-mingw32.cmake \
      && cmake --build SDL/build-windows --config Release \
      && cmake --install SDL/build-windows --config Release --prefix SDL/bin-windows \
      && x86_64-w64-mingw32-strip SDL/bin-windows/bin/SDL3.dll \
      && cp -r SDL/bin-windows/bin/SDL3.dll ${Windows_Runtime}

# Build SDL3_image
git clone --branch ${SDL3_Image} --depth 1 https://github.com/libsdl-org/SDL_image.git && SDL_image/external/download.sh

cmake -S SDL_image -B SDL_image/build-windows -G Ninja \
      -DSDLIMAGE_VENDORED=ON \
      -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_TOOLCHAIN_FILE=../toolchains/x86_64-w64-mingw32.cmake \
      -DSDL3_DIR=../SDL/bin-windows/lib/cmake/SDL3 \
      && cmake --build SDL_image/build-windows --config Release \
      && cmake --install SDL_image/build-windows --config Release --prefix SDL_image/bin-windows \
      && x86_64-w64-mingw32-strip SDL_image/bin-windows/bin/SDL3_image.dll \
      && cp -r SDL_image/bin-windows/bin/*.dll ${Windows_Runtime}

# Build SDL3_ttf
git clone --branch ${SDL3_ttf} --depth 1 https://github.com/libsdl-org/SDL_ttf.git && SDL_ttf/external/download.sh

cmake -S SDL_ttf -B SDL_ttf/build-windows -G Ninja \
      -DSDLTTF_VENDORED=ON \
      -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_TOOLCHAIN_FILE=../toolchains/x86_64-w64-mingw32.cmake \
      -DSDL3_DIR=../SDL/bin-windows/lib/cmake/SDL3 \
      && cmake --build SDL_ttf/build-windows --config Release \
      && cmake --install SDL_ttf/build-windows --config Release --prefix SDL_ttf/bin-windows \
      && x86_64-w64-mingw32-strip SDL_ttf/bin-windows/bin/SDL3_ttf.dll \
      && cp -r SDL_ttf/bin-windows/bin/*.dll ${Windows_Runtime}

# Cleanup
rm -rf SDL SDL_image SDL_ttf toolchains

echo "SDL3-$1 build complete."
