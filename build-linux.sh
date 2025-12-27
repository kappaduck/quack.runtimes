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
Linux_Runtime=artifacts/runtimes/linux-x64/native
mkdir -p ${Linux_Runtime}

# Build SDL3
git clone --branch ${SDL3} --depth 1 https://github.com/libsdl-org/SDL.git

cmake -S SDL -B SDL/build-linux \
      -DCMAKE_BUILD_TYPE=Release \
      && cmake --build SDL/build-linux --config Release \
      && cmake --install SDL/build-linux --config Release --prefix SDL/bin-linux \
      && strip SDL/bin-linux/lib/libSDL3.so.* \
      && cp -r SDL/bin-linux/lib/*.so* ${Linux_Runtime}

# Build SDL3_image
git clone --branch ${SDL3_Image} --depth 1 https://github.com/libsdl-org/SDL_image.git && SDL_image/external/download.sh

cmake -S SDL_image -B SDL_image/build-linux \
      -DSDLIMAGE_VENDORED=ON \
      -DCMAKE_BUILD_TYPE=Release \
      -DSDL3_DIR=../SDL/bin-linux/lib/cmake/SDL3 \
      && cmake --build SDL_image/build-linux --config Release \
      && cmake --install SDL_image/build-linux --config Release --prefix SDL_image/bin-linux \
      && strip SDL_image/bin-linux/lib/libSDL3_image.so.* \
      && cp -r SDL_image/bin-linux/lib/*.so* ${Linux_Runtime}

# Build SDL3_ttf
git clone --branch ${SDL3_ttf} --depth 1 https://github.com/libsdl-org/SDL_ttf.git && SDL_ttf/external/download.sh

cmake -S SDL_ttf -B SDL_ttf/build-linux \
      -DSDLTTF_VENDORED=ON \
      -DCMAKE_BUILD_TYPE=Release \
      -DSDL3_DIR=../SDL/bin-linux/lib/cmake/SDL3 \
      && cmake --build SDL_ttf/build-linux --config Release \
      && cmake --install SDL_ttf/build-linux --config Release --prefix SDL_ttf/bin-linux \
      && strip SDL_ttf/bin-linux/lib/libSDL3_ttf.so.* \
      && cp -r SDL_ttf/bin-linux/lib/*.so* ${Linux_Runtime}

# Cleanup
rm -rf SDL SDL_image SDL_ttf

echo "SDL3-$1 build complete."
